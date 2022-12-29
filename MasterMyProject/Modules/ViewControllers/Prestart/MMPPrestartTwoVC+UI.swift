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
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        for data in inspectionListSelectedArray {
            if (prestartTwoListArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "Yes") {
                cell.yesButton.backgroundColor = MMPConstant.greenColor
                cell.yesButton.tintColor = .white
            } else if (prestartTwoListArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "No") {
                cell.noButton.backgroundColor = MMPConstant.redColor
                cell.noButton.tintColor = .white
        }
        }
//        } else {
//            cell.yesButton.backgroundColor = .clear
//            cell.yesButton.tintColor = MMPConstant.greenColor
//            cell.noButton.backgroundColor = .clear
//            cell.noButton.tintColor = MMPConstant.redColor
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
    @objc func yesButtonTapped(_ sender : UIButton) {
        if inspectionListSelectedArray.count != 0 {
            for data in inspectionListSelectedArray {
                if prestartTwoListArray[sender.tag]["id"] as? String == data["id"] as? String {
                    inspectionListSelectedArray.remove(at: sender.tag)
                    inspectionListDict.removeValue(forKey: "ans")
                } else {
                    inspectionListDict = prestartTwoListArray[sender.tag]
                    inspectionListDict["ans"] = "Yes" as AnyObject
                }
            }
        }
       
        inspectionListDict = prestartTwoListArray[sender.tag]
        inspectionListDict["ans"] = "Yes" as AnyObject
        inspectionListSelectedArray.append(inspectionListDict)
        prestartTwoTableView.reloadData()
        print("inspectionListSelectedArray from Yes",inspectionListSelectedArray)
    }
    
    @objc func noButtonTapped(_ sender : UIButton) {
        if inspectionListSelectedArray.count != 0 {
            for data in inspectionListSelectedArray {
                if prestartTwoListArray[sender.tag]["id"] as? String == data["id"] as? String {
                    inspectionListSelectedArray.remove(at: sender.tag)
                    inspectionListDict.removeValue(forKey: "ans")
                } else {
                    inspectionListDict = prestartTwoListArray[sender.tag]
                    inspectionListDict["ans"] = "No" as AnyObject
                }
            }
        }
       
        inspectionListDict = prestartTwoListArray[sender.tag]
        inspectionListDict["ans"] = "No" as AnyObject
        inspectionListSelectedArray.append(inspectionListDict)
        prestartTwoTableView.reloadData()
        print("inspectionListSelectedArray from No",inspectionListSelectedArray)
    }
}
