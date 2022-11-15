//
//  MMPUtilities.swift
//  MasterMyProject
//
//  Created by Mac on 15/11/22.
//

import UIKit

class MMPUtilities: NSObject {
    class func valiadateBlankText(text: String?) -> Bool {
        guard let text = text, text.isEmpty else { return true }
        return false
    }
    
    class func isValidEmail(emaild:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{2,64}@[A-Za-z0-9.-]+\\.[A-Za-z]{2,255}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emaild)
    }
    
    class func isPasswordValid(_ password : String?) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,15}$")
        return passwordTest.evaluate(with: password)
    }
    
    class func valiadatePhoneNumber(text: String?) -> Bool {
        let PHONE_REGEX = "^[0-9]{10,}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: text)
        return result
    }
    
    class func isValidPhone(text:String) -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: text)
    }
    
    class func displayToastMessage(_ message : String) {
        DispatchQueue.main.async(execute: {
            let toastView = UILabel()
            toastView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
           // toastView.textColor = FFConstants.redColor
            toastView.textAlignment = .center
            toastView.font = UIFont.preferredFont(forTextStyle: .caption1)
            toastView.layer.cornerRadius = 25
            toastView.layer.masksToBounds = true
            toastView.text = message
            toastView.numberOfLines = 0
            toastView.alpha = 0
            //toastView.adjustsFontSizeToFitWidth = UIFont.italicSystemFont(ofSize: 15)
            toastView.translatesAutoresizingMaskIntoConstraints = false
            
            let window = UIApplication.shared.delegate?.window!
            window?.addSubview(toastView)
            
            let horizontalCenterContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .centerX, relatedBy: .equal, toItem: window, attribute: .centerX, multiplier: 1, constant: 0)
            
            let widthContraint: NSLayoutConstraint = NSLayoutConstraint(item: toastView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 275)
            
            let verticalContraint: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(>=200)-[loginView(==50)]-68-|", options: [.alignAllCenterX, .alignAllCenterY], metrics: nil, views: ["loginView": toastView])
            
            NSLayoutConstraint.activate([horizontalCenterContraint, widthContraint])
            NSLayoutConstraint.activate(verticalContraint)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                toastView.alpha = 1
            }, completion: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                UIView.animate(withDuration: 0.5, delay: 0.1, options: .curveEaseIn, animations: {
                    toastView.alpha = 0
                }, completion: { finished in
                    toastView.removeFromSuperview()
                })
            })
        })
        
    }
}
