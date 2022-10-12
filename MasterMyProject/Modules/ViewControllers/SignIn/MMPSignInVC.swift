//
//  MMPSignInVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 05/10/22.
//

import UIKit

class MMPSignInVC: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        UserDefaults.standard.set(true, forKey: "isLogin")
        UserDefaults.standard.synchronize()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
@IBDesignable
public class GradientButton: UIButton {
    public override class var layerClass: AnyClass         { CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer             { layer as! CAGradientLayer }

    @IBInspectable public var startColor: UIColor = .white { didSet { updateColors() } }
    @IBInspectable public var endColor: UIColor = .red     { didSet { updateColors() } }

    // expose startPoint and endPoint to IB

    @IBInspectable public var startPoint: CGPoint {
        get { gradientLayer.startPoint }
        set { gradientLayer.startPoint = newValue }
    }

    @IBInspectable public var endPoint: CGPoint {
        get { gradientLayer.endPoint }
        set { gradientLayer.endPoint = newValue }
    }

    // while we're at it, let's expose a few more layer properties so we can easily adjust them in IB

    @IBInspectable public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    @IBInspectable public var borderWidth: CGFloat {
        get { layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable public var borderColor: UIColor? {
        get { layer.borderColor.flatMap { UIColor(cgColor: $0) } }
        set { layer.borderColor = newValue?.cgColor }
    }

    // init methods

    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        updateColors()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateColors()
    }
}

private extension GradientButton {
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
}
