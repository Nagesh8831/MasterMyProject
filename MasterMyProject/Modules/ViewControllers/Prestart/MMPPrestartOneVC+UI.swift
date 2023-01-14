//
//  MMPPrestartOneVC+UI.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import Foundation
import UIKit
extension MMPPrestartOneVC {
    func setUpUI() {
        setUpTableView()
    }
    
    func setUpTableView() {
        prestartOneTableView.register(UINib(nibName: "MMPPrestartTableViewCell", bundle: nil), forCellReuseIdentifier: "MMPPrestartTableViewCell")
    }
}

extension MMPPrestartOneVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prestartListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPPrestartTableViewCell", for: indexPath) as! MMPPrestartTableViewCell
        cell.titleLabel.text = prestartListArray[indexPath.row]["title"] as? String
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        for data in fluidLevelsArray {
            if (prestartListArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "Yes") {
                cell.yesButton.backgroundColor = MMPConstant.greenColor
                cell.yesButton.tintColor = .white
            } else if (prestartListArray[indexPath.row]["id"] as? String == data["id"] as? String && data["ans"] as? String == "No") {
                cell.noButton.backgroundColor = MMPConstant.redColor
                cell.noButton.tintColor = .white
            }
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    @objc func yesButtonTapped(_ sender : UIButton) {
        if fluidLevelsArray.count != 0 {
            for data in fluidLevelsArray {
                if prestartListArray[sender.tag]["id"] as? String == data["id"] as? String {
                    fluidLevelsArray.remove(at: sender.tag)
                    fluidLevelsDict.removeValue(forKey: "ans")
                } else {
                    fluidLevelsDict = prestartListArray[sender.tag]
                    fluidLevelsDict["ans"] = "Yes" as AnyObject
                }
            }
        }
       
        fluidLevelsDict = prestartListArray[sender.tag]
        fluidLevelsDict["ans"] = "Yes" as AnyObject
        fluidLevelsArray.append(fluidLevelsDict)
        prestartOneTableView.reloadData()
        print("inspectionListSelectedArray from Yes",fluidLevelsArray)
    }
    
    @objc func noButtonTapped(_ sender : UIButton) {
        if fluidLevelsArray.count != 0 {
            for data in fluidLevelsArray {
                if prestartListArray[sender.tag]["id"] as? String == data["id"] as? String {
                    fluidLevelsArray.remove(at: sender.tag)
                    fluidLevelsDict.removeValue(forKey: "ans")
                } else {
                    fluidLevelsDict = prestartListArray[sender.tag]
                    fluidLevelsDict["ans"] = "No" as AnyObject
                }
            }
        }
       
        fluidLevelsDict = prestartListArray[sender.tag]
        fluidLevelsDict["ans"] = "No" as AnyObject
        fluidLevelsArray.append(fluidLevelsDict)
        prestartOneTableView.reloadData()
        print("inspectionListSelectedArray from No",fluidLevelsArray)
    }
}
