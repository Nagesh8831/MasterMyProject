//
//  AppDelegate.swift
//  MasterMyProject
//
//  Created by Nagesh on 03/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if #available(iOS 13.0, *) {
            // In iOS 13 setup is done in SceneDelegate
        } else {
            makeRootViewController()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    
    func makeRootViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let saveValue = UserDefaults.standard.bool(forKey: "isLogin")
        if saveValue {
            getDashboard()
        } else {
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "MMPSignInVC") as! MMPSignInVC
            let nvc: UINavigationController = UINavigationController(rootViewController: rightViewController)
            nvc.navigationBar.tintColor = UIColor.black
            self.window?.rootViewController = nvc
            self.window?.makeKeyAndVisible()
        }
    }
    
    func getDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.black
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }
}
