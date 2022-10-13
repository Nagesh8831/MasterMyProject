//
//  MMPSignOutAlertVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 13/10/22.
//

import UIKit

class MMPSignOutAlertVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButtonAction(_ sender: UIButton) {
        dismiss(animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDocketVC") as! MMPDocketVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
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
