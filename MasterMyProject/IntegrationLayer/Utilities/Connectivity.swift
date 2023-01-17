//
//  Connectivity.swift
//  MasterMyProject
//
//  Created by Mac on 17/01/23.
//

import Foundation
import Alamofire
import Network

class Connectivity {
        
    class var isConnectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class var isConnectedToWIFI: Bool {
        return NetworkReachabilityManager()!.isReachableOnEthernetOrWiFi
    }
}

class NetStatus {
    
    // MARK: - Properties
    
    static let shared: NetStatus = {
        let netStatus = NetStatus()
        netStatus.startMonitoring()
        return netStatus
    }()
    
    var monitor: NWPathMonitor?
    
    var isMonitoring = false
    
    var didStartMonitoringHandler: (() -> Void)?
    
    var didStopMonitoringHandler: (() -> Void)?
    
    var netStatusChangeHandler: (() -> Void)?
    
    var isConnected: Bool {
        guard let monitor = monitor else { return false }
        return monitor.currentPath.status == .satisfied
    }
    
    var isConnectedToWIFI: Bool {
        guard let monitor = monitor else {return false}
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type == .wifi
    }
    
    var interfaceType: NWInterface.InterfaceType? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.type
    }

    var interfaceName: String? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.filter {
            monitor.currentPath.usesInterfaceType($0.type) }.first?.name
    }
    
    var availableInterfacesTypes: [NWInterface.InterfaceType]? {
        guard let monitor = monitor else { return nil }
        return monitor.currentPath.availableInterfaces.map { $0.type }
    }
    
    var isExpensive: Bool {
        return monitor?.currentPath.isExpensive ?? false
    }
    
    // MARK: - Init & Deinit
    
    private init() {
        
    }
    
    deinit {
        stopMonitoring()
    }
    
    // MARK: - Method Implementation
    
    func startMonitoring() {
        guard !isMonitoring else { return }
        
        monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetStatus_Monitor")
        monitor?.start(queue: queue)
        
        monitor?.pathUpdateHandler = { _ in
            self.netStatusChangeHandler?()
        }
                
        isMonitoring = true
        didStartMonitoringHandler?()
        
    }
    
    func stopMonitoring() {
        guard isMonitoring, let monitor = monitor else { return }
        monitor.cancel()
        self.monitor = nil
        isMonitoring = false
        didStopMonitoringHandler?()
    }
}

class LocalNetworkPrivacy: NSObject {
    
    let service: NetService
    var completion: ((Bool) -> Void)?
    var timer: Timer?
    var publishing = false
    var completionReturned = false
    
    override init() {
        service = .init(domain: "local.", type: "_lnp._tcp.", name: "LocalNetworkPrivacy", port: 1100)
        super.init()
    }
    
    @objc
    func checkAccessState(completion: @escaping (Bool) -> Void) {

        self.completion = completion
        self.publishing = true
        self.service.delegate = self
        self.service.publish()
        
        timer = .scheduledTimer(withTimeInterval: 3, repeats: true, block: { timer in
            guard UIApplication.shared.applicationState == .active else {
                return
            }
            if self.publishing {
                
                self.timer?.invalidate()
                if !self.completionReturned {
                    self.completion?(false)
                }
            }
        })
    }
    
    deinit {
        service.stop()
    }
}

extension LocalNetworkPrivacy: NetServiceDelegate {
    
    func netServiceDidPublish(_ sender: NetService) {
        timer?.invalidate()
        completionReturned = true
        completion?(true)
    }
    
    func netService(_ sender: NetService, didNotPublish errorDict: [String: NSNumber]) {
        print("Error: \(errorDict)")
    }
    
}
