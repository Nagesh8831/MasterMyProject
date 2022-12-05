//
//  MMPSignOutAlertVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import UIKit


class MMPSignOutAlertVC: MMPBaseVC, MMPAlertRemoveHelper {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
    @IBAction func okButtonAction(_ sender: UIButton) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDocketVC") as! MMPDocketVC
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func removeTopChildViewController() {
        //DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 ) {
            self.dismiss(animated: false)
        //}
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
