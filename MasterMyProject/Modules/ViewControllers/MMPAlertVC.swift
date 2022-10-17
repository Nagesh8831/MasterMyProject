//
//  MMPAlertVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import UIKit

class MMPAlertVC: MMPBaseVC {
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    var titleString : String?
    var imageString : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
       // self.dismiss(animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPPrestartOneVC") as! MMPPrestartOneVC
        // vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckAlertVC") as!MMPTruckAlertVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overCurrentContext
            self.getTopMostViewController()?.present(vc, animated: true)
        })
        
        //self.present(vc, animated: true)
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
