//
//  MMPPrestartTwoVC+UI.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import Foundation
import UIKit
extension MMPPrestartTwoVC {
    func setUpUI() {
        setUpTableView()
    }
    
    func setUpTableView() {
        prestartTwoTableView.register(UINib(nibName: "MMPPrestartTableViewCell", bundle: nil), forCellReuseIdentifier: "MMPPrestartTableViewCell")
        prestartTwoTableView.reloadData()
        
    }
}

extension MMPPrestartTwoVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prestartTwoListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPPrestartTableViewCell", for: indexPath) as! MMPPrestartTableViewCell
        cell.titleLabel.text = prestartTwoListArray[indexPath.row]["title"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
}
