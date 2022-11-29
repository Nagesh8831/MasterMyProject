//
//  MMPPrestartTwoVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit

class MMPPrestartTwoVC: MMPBaseVC {
   // @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var prestartTwoTableView: UITableView!
    var projectId: String?
    var prestartTwoListArray = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(2/2)"
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
       scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }*/
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
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
