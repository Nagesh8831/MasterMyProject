//
//  AppDelegate.swift
//  MasterMyProject
//
//  Created by Nagesh on 03/10/22.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.resignFirstResponder()
       // UINavigationBar.scrollEdgeAppearance = UINavigationBar.standardAppearance
        
        //UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black , NSAttributedString.Key.font : UIFont(name: "Barlow-Bold", size: 18)!]
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
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UITextField.appearance().tintColor = .black
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
            UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")?.withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().standardAppearance = appearance

            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let saveValue = UserDefaults.standard.bool(forKey: "isLogin")
        if saveValue {
            getDashboard()
        } else {
            let rightViewController = storyboard.instantiateViewController(withIdentifier: "MMPSignInVC") as! MMPSignInVC
            let nvc: UINavigationController = UINavigationController(rootViewController: rightViewController)
            nvc.navigationBar.tintColor = UIColor.white
            nvc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            nvc.navigationBar.barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
            self.window?.rootViewController = nvc
            self.window?.makeKeyAndVisible()
        }
    }
    
    func getDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        let nvc: UINavigationController = UINavigationController(rootViewController: mainViewController)
        nvc.navigationBar.tintColor = UIColor.white
       // nvc.navigationBar.barTintColor = UIColor.red
        nvc.navigationBar.barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        nvc.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.window?.rootViewController = nvc
        self.window?.makeKeyAndVisible()
    }
}
