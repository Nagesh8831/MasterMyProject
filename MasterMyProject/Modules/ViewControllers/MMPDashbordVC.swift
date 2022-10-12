//
//  MMPDashbordVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 05/10/22.
//

import UIKit

class MMPDashbordVC: UIViewController {
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var earnTitleLabel: UILabel!
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var projectListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlerViewController()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPProfileVC") as! MMPProfileVC
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
