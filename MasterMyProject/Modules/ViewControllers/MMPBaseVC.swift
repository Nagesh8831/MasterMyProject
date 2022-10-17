//
//  MMPBaseVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import UIKit

class MMPBaseVC: UIViewController,UIBarPositioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    func showAlerViewController(_ message: String, imageName: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPAlertVC") as!MMPAlertVC
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        vc.titleString = message
        vc.imageString = imageName
        self.present(navController, animated: true)
        
        
        
    }
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
