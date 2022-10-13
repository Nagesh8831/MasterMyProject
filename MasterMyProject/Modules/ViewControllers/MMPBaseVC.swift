//
//  MMPBaseVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 13/10/22.
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
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleString = message
        vc.imageString = imageName
        self.present(vc, animated: true)
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
