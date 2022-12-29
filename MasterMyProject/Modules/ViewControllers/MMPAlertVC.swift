//
//  MMPAlertVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import UIKit
protocol SelectActionControllerDelegate {
    func machineViewDismissed()
    func truckViewDismissed()
}
class MMPAlertVC: MMPBaseVC {
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertImage: UIImageView!
    var titleString : String?
    var imageString : String?
    var projectId: String?
    var isFromPrestartTwo = false
    var delegate: SelectActionControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     //   self.dismiss(animated: true)
    }
    
    @IBAction func yesButtonAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.machineViewDismissed()
        }
    }
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        dismiss(animated: true) {
            self.delegate?.truckViewDismissed()
        }
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckAlertVC") as!MMPTruckAlertVC
//        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
//        navController.modalTransitionStyle = .crossDissolve
//        navController.modalPresentationStyle = .overCurrentContext
//        vc.delegate = self
//        //vc.titleString = "Are you operating Machine?"
//        //vc.imageString = "machine"
//        vc.projectId = projectId
//        self.present(navController, animated: true)
//        self.dismiss(animated: true, completion: {
//            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckAlertVC") as!MMPTruckAlertVC
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overCurrentContext
//            self.getTopMostViewController()?.present(vc, animated: true)
//        })

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

//extension MMPAlertVC : SelectTruckActionControllerDelegate {
//    func truckViewDismissed() {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
//        vc.projectId = projectId
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//}
