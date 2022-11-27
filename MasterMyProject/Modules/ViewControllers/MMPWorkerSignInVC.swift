//
//  MMPWorkerSignInVC.swift
//  MasterMyProject
//
//  Created by Mac on 26/11/22.
//

import UIKit

class MMPWorkerSignInVC: MMPBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.isNavigationBarHidden = false
        title = "Sign In"
        // Do any additional setup after loading the view.
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
