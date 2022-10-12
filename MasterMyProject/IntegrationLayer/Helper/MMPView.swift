//
//  MMPView.swift
//  MasterMyProject
//
//  Created by Nagesh on 12/10/22.
//

import Foundation
import UIKit

@IBDesignable class MMPView: UIView {
    
    override init (frame: CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

@IBDesignable class FFRingView: UIView {
    @IBInspectable var radius: CGFloat = 20 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var lineWidth: CGFloat = 2 {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var fillColor: UIColor = .clear {
        didSet {
            setupView()
        }
    }
    
    @IBInspectable var strokeColor: UIColor = .red {
        didSet {
            setupView()
        }
    }
    
    func setupView() {
        
    }
    
    override func draw(_ rect: CGRect) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.width/2,y: frame.height/2), radius: radius, startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        //change the fill color
        shapeLayer.fillColor = fillColor.cgColor
        //you can change the stroke color
        shapeLayer.strokeColor = strokeColor.cgColor
        //you can change the line width
        shapeLayer.lineWidth = lineWidth
        layer.addSublayer(shapeLayer)
    }
}


@IBDesignable class FFImageView: UIImageView {
    
    override init (frame: CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}

@IBDesignable class MMPShadowView: MMPView {
    
    override init (frame: CGRect) {
        super.init(frame : frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews () {
        super.layoutSubviews()
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowPath = shadowPath.cgPath
    }
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
}

@IBDesignable class MMPGradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear
    @IBInspectable var cornerRadius: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: frame.size.width,
                                height: frame.size.height)
        gradient.locations = [0, 1]
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        gradient.cornerRadius = cornerRadius
        layer.addSublayer(gradient)
        clipsToBounds = true
        layer.masksToBounds = true
    }
}

@IBDesignable class MMPTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        //bottomLine.backgroundColor = PPConstants.separatorColor.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.black {
        didSet {
            
            layer.borderColor = borderColor.cgColor
            borderStyle = UITextField.BorderStyle.none
            layer.masksToBounds = false
            layer.cornerRadius = 5.0;
            layer.backgroundColor = UIColor.white.cgColor
            layer.borderColor = UIColor.clear.cgColor
            layer.shadowColor = borderColor.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowOpacity = 0.15
            layer.shadowRadius = 4.0
            
        }
    }
}
