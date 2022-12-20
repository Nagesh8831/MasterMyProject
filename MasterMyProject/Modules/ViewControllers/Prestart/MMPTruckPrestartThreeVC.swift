//
//  MMPTruckPrestartThreeVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit

class MMPTruckPrestartThreeVC: MMPBaseVC {
    @IBOutlet weak var prestartTwoTableView: UITableView!
    var projectId: String?
    var categoryCArray = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(3/3)"
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPSignInSucessAlertVC") as!MMPSignInSucessAlertVC
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated: true, completion: nil)
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
