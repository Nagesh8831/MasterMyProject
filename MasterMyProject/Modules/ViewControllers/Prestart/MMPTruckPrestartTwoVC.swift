//
//  MMPTruckPrestartTwoVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit

class MMPTruckPrestartTwoVC: MMPBaseVC {
    @IBOutlet weak var prestartTwoTableView: UITableView!
    var projectId = ""
    var plant_id = ""
    var categoryBArray = [[String:AnyObject]]()
    var categoryCArray = [[String:AnyObject]]()
    var categoryASelectedArray = [[String:AnyObject]]()
    var categoryBSelectedArray = [[String:AnyObject]]()
    var categoryBDict = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(2/3)"
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartThreeVC") as! MMPTruckPrestartThreeVC
        vc.categoryCArray = categoryCArray
        vc.categoryASelectedArray = self.categoryASelectedArray
        vc.categoryBSelectedArray = self.categoryBSelectedArray
        vc.projectId = self.projectId
        vc.plant_id = self.plant_id
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
