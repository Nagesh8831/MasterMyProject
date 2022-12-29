//
//  MMPPrestartTableViewCell.swift
//  MasterMyProject
//
//  Created by Mac on 28/11/22.
//

import UIKit

class MMPPrestartTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override func prepareForReuse() {
//            // invoke superclass implementation
//            super.prepareForReuse()
//            
//            // reset (hide) the checkmark label
//        yesButton.backgroundColor = .clear
//        yesButton.tintColor = MMPConstant.greenColor
//        noButton.backgroundColor = .clear
//        noButton.tintColor = MMPConstant.redColor
//
//        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        yesButton.backgroundColor = .clear
        yesButton.tintColor = MMPConstant.greenColor
        noButton.backgroundColor = .clear
        noButton.tintColor = MMPConstant.redColor
    }
    
    var toggle: Bool? {
              didSet {
                     //Do buttons operations like...
                  if toggle ?? false {
//                         yesButton.backgroundColor = isToggle ? MMPConstant.greenColor : .clear
//                         yesButton.tintColor = isToggle ? .white : MMPConstant.greenColor
//                         noButton.backgroundColor = isToggle ? .clear : MMPConstant.redColor
//                         noButton.tintColor = isToggle ? MMPConstant.greenColor : MMPConstant.redColor
                         yesButton.backgroundColor = MMPConstant.greenColor
                         yesButton.tintColor = .white
                         noButton.tintColor = MMPConstant.redColor
                         noButton.backgroundColor = .clear
                     } else {
                         yesButton.backgroundColor = .clear
                         yesButton.tintColor = MMPConstant.greenColor
                         noButton.backgroundColor = .clear
                         noButton.tintColor = MMPConstant.redColor
                     }
              }
          }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

         //Yes Button - IBAction Method
         @IBAction func yesButtonTapped(_ sender: UIButton) {
               setAction(true)
         }

         //No Button - IBAction Method
         @IBAction func noButtonTapped(_ sender: UIButton) {
               setAction(false)
         }
    
    func setAction(_ isYesSelected:Bool){
        if isYesSelected {
            yesButton.backgroundColor = MMPConstant.greenColor
            yesButton.tintColor = .white
            noButton.tintColor = MMPConstant.redColor
            noButton.backgroundColor = .clear
        } else {
            yesButton.backgroundColor = .clear
            yesButton.tintColor = MMPConstant.greenColor
            noButton.backgroundColor = MMPConstant.redColor
            noButton.tintColor = .white
        }
    }
    
}
