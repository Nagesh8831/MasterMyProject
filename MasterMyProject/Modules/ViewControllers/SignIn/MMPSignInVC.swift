//
//  MMPSignInVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 05/10/22.
//

import UIKit
import Alamofire
class MMPSignInVC: MMPBaseVC {
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
        userLogin(emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    @IBAction func forgotPasswordButtonAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Forgot Password?", message: "Please enter your registered email", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Submit", style: .default, handler: {
            alert -> Void in
            
            let firstTextField = alertController.textFields![0] as UITextField
            
            print("firstName \(firstTextField.text!)")
            if !MMPUtilities.isValidEmail(emaild: firstTextField.text!) {
                self.alertUser("Email", message: "Please Enter valid Email")
            } else {
            self.forgotPassword(firstTextField.text ?? "")
            }
           // self.forgotPassword(firstTextField.text ?? "")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
            (action : UIAlertAction!) -> Void in
            
        })
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Your email"
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
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
    func userLogin(_ emailId:String, password:String){
        guard validateData() else { return }
        let parameters = ["email": emailId,
                          "password": password
        ]
        startLoading()
        print(parameters)
        //let url = "http://52.63.247.85/mastermyproject/restapi"
        let urlRequest = "http://52.63.247.85/mastermyproject/restapi/workers/login"
        //let urlRequest = String (format: "%@%@%@", MMPConstant.baseURL,MMPConstant.USER_LOGIN)
        print(urlRequest)
        AF.request( urlRequest,method: .post ,parameters: parameters,encoding:
                        JSONEncoding.default, headers: nil)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                self.stopLoading()
                print("login_response",response)
                if let loginJSON = value as? [String: Any] {
                    if let statusCode = loginJSON["status_code"] as? Int,let meesage = loginJSON["message"] as? String{
                        print(statusCode)
                        if statusCode == 200 {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
                            if let resultObject = loginJSON["result_object"] as? [String: Any], let token = resultObject["token"] as? String, let id = resultObject["id"] as? String {
                                UserDefaults.standard.set(token, forKey: "userToken")
                                UserDefaults.standard.set(id, forKey: "userId")
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                UserDefaults.standard.synchronize()
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else if statusCode == 403 {
                            self.alertUser("Error", message: meesage)
                        }
                    }
                }
            case .failure(let error):
                print("error",error)
                self.stopLoading()
                DispatchQueue.main.async {
                    //self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func forgotPassword(_ email : String){
         let parameters = ["email": email
         ]
         startLoading()
         print(parameters)
         //let url = "http://52.63.247.85/mastermyproject/restapi"
         let urlRequest = "http://52.63.247.85/mastermyproject/restapi/workers/forgotpass"
         //let urlRequest = String (format: "%@%@%@", MMPConstant.baseURL,MMPConstant.FORGOT_PASSWORD)
         print(urlRequest)
        let token = UserDefaults.standard.string(forKey: "userToken")
       // value(forKey: "userToken") as! String
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                    "Content-Type": "application/json"]
         AF.request( urlRequest,method: .post ,parameters: parameters,encoding:
             JSONEncoding.default, headers: headers)
             .responseJSON { response in
                 switch response.result {
                 case .success(let value):
                    self.stopLoading()
                     print("forgotPassword_response",response)
                     if let loginJSON = value as? [String: Any] {
                         if let statusCode = loginJSON["statusCode"] as? Int {
                             print(statusCode)
                         }
                     }
                 case .failure(let error):
                     print("forgotPassword_response",error)
                     self.stopLoading()
                     DispatchQueue.main.async {
                         //self.present(alert, animated: true, completion: nil)
                     }
                 }
                 
         }
     }
}

extension MMPSignInVC {
    func validateData() -> Bool {
        if !MMPUtilities.valiadateBlankText(text: emailTextField.text) {
            alertUser("Master My Project", message: "Please enter email address")
            return false
        }
        if !MMPUtilities.valiadateBlankText(text: passwordTextField.text) {
            alertUser("Master My Project", message: "Please enter password")
            return false
        }

        return true
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
