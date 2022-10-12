//
//  MMPDashbordVC+UI.swift
//  MasterMyProject
//
//  Created by Nagesh on 11/10/22.
//

import Foundation
import UIKit
extension MMPDashbordVC {
    func setupUI() {
        projectTitleLabel.text = "Total Projects"
        timeTitleLabel.text = "Time This Week"
        earnTitleLabel.text = "Earned"
        navigationController?.isNavigationBarHidden = true
        profileButton.setTitle("", for: .normal)
        setUpTableView()
    }
    
    func setUpTableView() {
        projectListTableView.register(UINib(nibName: "ProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "ProjectTableViewCell")
    }
    
    func showAlerViewController(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPAlertVC") as!MMPAlertVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
}

extension MMPDashbordVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPProjectDetailsVC") as! MMPProjectDetailsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
}
