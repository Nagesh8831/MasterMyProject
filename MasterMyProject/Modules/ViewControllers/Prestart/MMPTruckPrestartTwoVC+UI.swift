//
//  MMPTruckPrestartTwoVC+UI.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import Foundation
import UIKit
extension MMPTruckPrestartTwoVC {
    func setUpUI() {
        setUpTableView()
    }
    
    func setUpTableView() {
        prestartTwoTableView.register(UINib(nibName: "MMPPrestartTableViewCell", bundle: nil), forCellReuseIdentifier: "MMPPrestartTableViewCell")
        prestartTwoTableView.reloadData()
        
    }
}

extension MMPTruckPrestartTwoVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryBArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPPrestartTableViewCell", for: indexPath) as! MMPPrestartTableViewCell
        cell.titleLabel.text = categoryBArray[indexPath.row]["title"] as? String
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        for data in categoryBSelectedArray {
            if (categoryBArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "Yes") {
                cell.yesButton.backgroundColor = MMPConstant.greenColor
                cell.yesButton.tintColor = .white
            } else if (categoryBArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "No") {
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
        if categoryBSelectedArray.count != 0 {
            for data in categoryBSelectedArray {
                if categoryBArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryBSelectedArray.remove(at: sender.tag)
                    categoryBDict.removeValue(forKey: "ans")
                } else {
                    categoryBDict = categoryBArray[sender.tag]
                    categoryBDict["ans"] = "Yes" as AnyObject
                }
            }
        }
       
        categoryBDict = categoryBArray[sender.tag]
        categoryBDict["ans"] = "Yes" as AnyObject
        categoryBSelectedArray.append(categoryBDict)
        
        print("categoryASelectedArray from Yes",categoryBSelectedArray)
    }
    
    @objc func noButtonTapped(_ sender : UIButton) {
        
        if categoryBSelectedArray.count != 0 {
            for data in categoryBSelectedArray {
                if categoryBArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryBSelectedArray.remove(at: sender.tag)
                    categoryBDict.removeValue(forKey: "ans")
                } else {
                    categoryBDict = categoryBArray[sender.tag]
                    categoryBDict["ans"] = "No" as AnyObject
                }
            }
        }
        
            categoryBDict = categoryBArray[sender.tag]
            categoryBDict["ans"] = "No" as AnyObject

        categoryBSelectedArray.append(categoryBDict)

        print("categoryASelectedArray from no",categoryBSelectedArray)
        
    }
}
