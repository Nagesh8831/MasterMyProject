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
      //  navigationController?.isNavigationBarHidden = false
     //   navigationController?.navigationItem.title = "Project X"
      //  navigationController?.navigationBar.tintColor = .red
        
    }
    
       func position(for bar: UIBarPositioning) -> UIBarPosition {
           return .topAttached
       }
}
