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
}

extension MMPDashbordVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell", for: indexPath) as! ProjectTableViewCell
        cell.actionButton.tag = indexPath.row
        cell.actionButton.addTarget(self, action: #selector(signOutButtonAction), for: .touchUpInside)
        cell.titleLabel.text = projectArray[indexPath.row]["pro_name"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPProjectDetailsVC") as! MMPProjectDetailsVC
        vc.projectId = projectArray[indexPath.row]["id"] as? String
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    @objc func signOutButtonAction(_ sender : UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPWorkerSignInVC") as! MMPWorkerSignInVC
        vc.projectId = projectArray[sender.tag]["id"] as? String
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
      /*  let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPSignOutAlertVC") as!MMPSignOutAlertVC
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated: true, completion: nil)*/
        
        
        
//       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPSignOutAlertVC") as!MMPSignOutAlertVC
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true)
        
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDocketVC") as! MMPDocketVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
