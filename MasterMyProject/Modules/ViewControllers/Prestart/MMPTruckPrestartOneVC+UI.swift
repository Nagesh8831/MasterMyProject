//
//  MMPTruckPrestartOneVC+UI.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import Foundation
import UIKit
extension MMPTruckPrestartOneVC {
    func setUpUI() {
        setUpTableView()
    }
    
    func setUpTableView() {
        prestartOneTableView.register(UINib(nibName: "MMPPrestartTableViewCell", bundle: nil), forCellReuseIdentifier: "MMPPrestartTableViewCell")
    }
}

extension MMPTruckPrestartOneVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryAArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPPrestartTableViewCell", for: indexPath) as! MMPPrestartTableViewCell
        cell.titleLabel.text = categoryAArray[indexPath.row]["title"] as? String
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        for data in categoryASelectedArray {
            if (categoryAArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "Yes") {
                cell.yesButton.backgroundColor = MMPConstant.greenColor
                cell.yesButton.tintColor = .white
            } else if (categoryAArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "No") {
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
        if categoryASelectedArray.count != 0 {
            for data in categoryASelectedArray {
                if categoryAArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryASelectedArray.remove(at: sender.tag)
                    categoryADict.removeValue(forKey: "ans")
                } else {
                    categoryADict = categoryAArray[sender.tag]
                    categoryADict["ans"] = "Yes" as AnyObject
                }
            }
        }
       
        categoryADict = categoryAArray[sender.tag]
        categoryADict["ans"] = "Yes" as AnyObject
        categoryASelectedArray.append(categoryADict)
        
        print("categoryASelectedArray from Yes",categoryASelectedArray)
    }
    
    @objc func noButtonTapped(_ sender : UIButton) {
        
        if categoryASelectedArray.count != 0 {
            for data in categoryASelectedArray {
                if categoryAArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryASelectedArray.remove(at: sender.tag)
                    categoryADict.removeValue(forKey: "ans")
                } else {
                    categoryADict = categoryAArray[sender.tag]
                    categoryADict["ans"] = "No" as AnyObject
                }
            }
        }
        
            categoryADict = categoryAArray[sender.tag]
            categoryADict["ans"] = "No" as AnyObject

        categoryASelectedArray.append(categoryADict)

        print("categoryASelectedArray from no",categoryASelectedArray)
        
    }
}
