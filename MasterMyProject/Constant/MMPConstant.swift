//
//  MMPConstant.swift
//  MasterMyProject
//
//  Created by KO158S8 on 01/11/22.
//

import Foundation
import UIKit
class MMPConstant: NSObject {
    
    static let baseURL = "http://52.63.247.85/mastermyproject/restapi/" //Live
    static let USER_LOGIN = "workers/login"
    static let GET_WORKER_BY_ID = "/workers/getworker/"
    static let FORGOT_PASSWORD = "workers/forgotpass"
    static let GET_PROJECT_BY_USERID = "projects/getproject/"
    static let GET_ALL_PROJECT = "projects/getprojects"
  
    
    //COLOR
    static let blueColor = UIColor(red: 23/255.0, green: 51/255.0, blue: 98/255.0, alpha: 1.0)
    static let greenColor = UIColor(red: 37/255.0, green: 186/255.0, blue: 42/255.0, alpha: 1.0)
    static let yellowColor = UIColor(red: 235/255.0, green: 151/255.0, blue: 0/255.0, alpha: 1.0)
    static let backgroundFillColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    static let cardbackgroundColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)
    static let textColor = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.87)
}
