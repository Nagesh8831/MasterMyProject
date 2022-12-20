//
//  MMPTruckAlertVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 17/10/22.
//

import UIKit
//protocol SelectTruckActionControllerDelegate {
//    func truckViewDismissed()
//}
class MMPTruckAlertVC: MMPBaseVC {
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    var projectId: String?
    var isFromPrestart = false
  //  var delegate: SelectTruckActionControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
        // print("VCLiked")
//        if isFromPrestart {
//            self.dismiss(animated: true)
//        } else {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
//            vc.projectId = projectId
//            vc.isFromPrestart = false
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
       
//        dismiss(animated: true) {
//            self.delegate?.truckViewDismissed()
//        }

    }
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        self.navigationController?.pushViewController(vc, animated: true)
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
