//
//  MMPAlertVC+UI.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import Foundation
import UIKit
extension MMPAlertVC {
    
    func setUpUI(){
        alertTitleLabel.text = titleString
        alertImage.image = UIImage(named: imageString ?? "")
    }
    
}
