//
//  MMPProjectDetailsVC+UI.swift
//  MasterMyProject
//
//  Created by Nagesh on 12/10/22.
//

import Foundation
import UIKit
extension MMPProjectDetailsVC {
    func setupUI() {
        navigationBarSetUp()
    }
    
    func navigationBarSetUp() {
        navigationController?.isNavigationBarHidden = false
        title = "Project X"
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        
    }
}
