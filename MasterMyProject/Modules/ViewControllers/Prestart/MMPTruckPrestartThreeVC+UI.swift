//
//  MMPTruckPrestartThreeVC+UI.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import Foundation
import UIKit
extension MMPTruckPrestartThreeVC {
    func setUpUI() {
        setUpTableView()
    }
    
    func setUpTableView() {
        prestartTwoTableView.register(UINib(nibName: "MMPPrestartTableViewCell", bundle: nil), forCellReuseIdentifier: "MMPPrestartTableViewCell")
        prestartTwoTableView.reloadData()
        
    }
}

extension MMPTruckPrestartThreeVC: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryCArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MMPPrestartTableViewCell", for: indexPath) as! MMPPrestartTableViewCell
        cell.titleLabel.text = categoryCArray[indexPath.row]["title"] as? String
        cell.yesButton.tag = indexPath.row
        cell.noButton.tag = indexPath.row
        cell.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        cell.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
        for data in categoryBSelectedArray {
            if (categoryCArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "Yes") {
                cell.yesButton.backgroundColor = MMPConstant.greenColor
                cell.yesButton.tintColor = .white
            } else if (categoryCArray[indexPath.row]["id"] as? String == data["id"] as? String  && data["ans"] as? String == "No") {
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
        if categoryCSelectedArray.count != 0 {
            for data in categoryCSelectedArray {
                if categoryCArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryCSelectedArray.remove(at: sender.tag)
                    categoryCDict.removeValue(forKey: "ans")
                } else {
                    categoryCDict = categoryCArray[sender.tag]
                    categoryCDict["ans"] = "Yes" as AnyObject
                }
            }
        }
       
        categoryCDict = categoryCArray[sender.tag]
        categoryCDict["ans"] = "Yes" as AnyObject
        categoryCSelectedArray.append(categoryCDict)
        
        print("categoryASelectedArray from Yes",categoryBSelectedArray)
    }
    
    @objc func noButtonTapped(_ sender : UIButton) {
        
        if categoryCSelectedArray.count != 0 {
            for data in categoryCSelectedArray {
                if categoryCArray[sender.tag]["id"] as? String == data["id"] as? String {
                    categoryCSelectedArray.remove(at: sender.tag)
                    categoryCDict.removeValue(forKey: "ans")
                } else {
                    categoryCDict = categoryCArray[sender.tag]
                    categoryCDict["ans"] = "No" as AnyObject
                }
            }
        }
        
            categoryCDict = categoryCArray[sender.tag]
            categoryCDict["ans"] = "No" as AnyObject

        categoryCSelectedArray.append(categoryCDict)

        print("categoryASelectedArray from no",categoryCSelectedArray)
        
    }
}
