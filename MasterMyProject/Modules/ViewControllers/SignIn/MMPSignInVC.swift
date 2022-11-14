//
//  MMPSignInVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 05/10/22.
//

import UIKit
import Alamofire
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
        userLogin("nagesh.rangapure8891@gmail.com")
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

extension MMPSignInVC {
    func userLogin(_ emailId:String){
       // guard validateData() else { return }
        let parameters = ["email": emailId,
                          "password": "admin"
        ]
      //  startLoading()
        print(parameters)
        //let url = "http://52.63.247.85/mastermyproject/restapi"
        let urlResponce = "http://52.63.247.85/mastermyproject/restapi/users/login"
        print(urlResponce)
        AF.request( urlResponce,method: .post ,parameters: parameters,encoding:
            JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                   // self.stopLoading()
                    print("login_response",response)
                    if let loginJSON = value as? [String: Any] {
                        if let statusCode = loginJSON["statusCode"] as? Int {
                            print(statusCode)
                            //let message = loginJSON["statusMessage"] as? String
//                            if statusCode == 200{
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FFOtpViewController") as! FFOtpViewController
//                                vc.isFromSignUp = false
//                                vc.registerEmail = emailId
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }else if statusCode == 400{
//                                self.alertUser("50Fifty", message: message!)
//                            } else if statusCode == 404{
//                                self.alertUser("50Fifty", message: "User Not Found")
//                            } else if statusCode == 500{
//                                self.alertUser("50Fifty", message: "User Not Found")
//                            }
                        }
                        if let resultObject = loginJSON["resultObject"] as? [String: Any], let token = resultObject["token"] as? String, let id = resultObject["id"] as? String, let statusCode = loginJSON["statusCode"] as? Int {
                            UserDefaults.standard.set(token, forKey: "userToken")
                            UserDefaults.standard.set(id, forKey: "userId")
                            UserDefaults.standard.synchronize()
                            if statusCode == 200 {
                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                UserDefaults.standard.synchronize()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                            
                            print(token)
                            print(id)
                        }
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        //self.present(alert, animated: true, completion: nil)
                    }
                }
                
        }
    }
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
