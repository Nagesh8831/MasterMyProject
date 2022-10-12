//
//  MMPAlertVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 13/10/22.
//

import UIKit

class MMPAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
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
