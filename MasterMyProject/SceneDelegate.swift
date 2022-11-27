//
//  SceneDelegate.swift
//  MasterMyProject
//
//  Created by Nagesh on 03/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        makeRoot()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate {
    
    func makeRoot() {
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        UITextField.appearance().tintColor = .black
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.backgroundColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
            //let backImage = UIImage(named: "backArrow")?.withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().backIndicatorImage = UIImage(named: "backArrow")?.withRenderingMode(.alwaysOriginal)
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        let saveValue = UserDefaults.standard.bool(forKey: "isLogin")
        if saveValue {
            getDashboard()
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MMPSignInVC") as! MMPSignInVC
            let rootNC = UINavigationController(rootViewController: vc)
            rootNC.navigationBar.tintColor = UIColor.white
            rootNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            rootNC.navigationBar.barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
            self.window!.rootViewController = rootNC
            self.window!.makeKeyAndVisible()
        }
    }
    
    func getDashboard() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabbarVC = storyboard.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        let rootNC = UINavigationController(rootViewController: tabbarVC)
        rootNC.navigationBar.tintColor = UIColor.white
        rootNC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        rootNC.navigationBar.barTintColor = UIColor(red: 23.0/255.0, green: 51.0/255.0, blue: 98.0/255.0, alpha: 1.0)
        self.window!.rootViewController = rootNC
        self.window!.makeKeyAndVisible()
    }
}
