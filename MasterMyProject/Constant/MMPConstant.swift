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
    static let USER_REGISTER = "customer/getRegisterOTP"
    static let USER_LOGIN = "users/login"
    static let GET_PROJECT_BY_USERID = "projects/getproject/"
    static let GET_ALL_PROJECT = "projects/getallprojects"
    
    
    
    
    
    static let SEND_OTP = "customerLogin/sendOTP"
    static let VERIFY_REGISTER_OTP = "customer/verifyOTP"
    static let GET_CARD_DETAILS = "debitCardService/getCard/customerId/"
    static let GET_USER_TRANSACTION_DETAILS = "transactionService/getCardTransactions"
    static let GET_VEHICLE_DETAILS = "vehicle/getVehicle/customerId/"
    static let GET_VEHICLE_DETAILS_BY_CUSTOMERID = "vehicle/getVehicle/driverId/"
    static let GET_POLICY_DETAILS = "policyService/getPolicy/vehicleId/"
    //Added by Pallavi
    static let GET_EMERGENCY_CONTACT = "contactDetails/getEmergencyContactNumber"
    //end of code 6 sept - Pallavi
    static let USER_PROFILE_UPDATE = "customer/updateProfile"
    static let GET_CUSTOMER_DETAILS = "customer/getProfile/customerId/"
    static let MONTHLY_REPORT = "reports/monthlyReports"
    static let LINK_CARD = "debitCardService/linkCard"
    //static let GET_CAR_LAST_LOCATION = "vehicle/getLastLocation"
    //API updated on 18th Feb as per latest API Doc shared by Sharad - Pallavi
    //vehicle/getLastLocation/vehicleId/{vehicleId}
    static let GET_CAR_LAST_LOCATION = "vehicle/getLastLocation/vehicleId/"
    static let GET_CARD_NUMBER = "debitCardService/getCardNumber/"
    static let GET_UNLINKED_DEBITCARD_POLICY = "getUnlinkedDebitCardPolicy/"
    static let GET_CUSTOMER_CARD = "debitCardService/getCustomerCards/"
    
    //COLOR
    static let redColor = UIColor(red: 238/255.0, green: 18/255.0, blue: 52/255.0, alpha: 1.0)
    static let greenColor = UIColor(red: 37/255.0, green: 186/255.0, blue: 42/255.0, alpha: 1.0)
    static let yellowColor = UIColor(red: 235/255.0, green: 151/255.0, blue: 0/255.0, alpha: 1.0)
    static let backgroundFillColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
    static let cardbackgroundColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)
    static let textColor = UIColor(red: 40/255.0, green: 40/255.0, blue: 40/255.0, alpha: 0.87)
}
