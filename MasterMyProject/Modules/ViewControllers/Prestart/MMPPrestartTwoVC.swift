//
//  MMPPrestartTwoVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit
import Alamofire
class MMPPrestartTwoVC: MMPBaseVC {
   // @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var prestartTwoTableView: UITableView!
    var projectId: String?
    var prestartTwoListArray = [[String:AnyObject]]()
    var fluidLevelsSelectedArray = [[String:AnyObject]]()
    var inspectionListSelectedArray = [[String:AnyObject]]()
    var inspectionListDict = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(2/2)"
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        print("fluidLevelsSelectedArray",fluidLevelsSelectedArray)
        // Do any additional setup after loading the view.
    }
    
    /*override func viewDidAppear(_ animated: Bool) {
       scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+300)
    }*/
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
        vc.isFromPrestart = true
        self.navigationController?.pushViewController(vc, animated: true)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckAlertVC") as!MMPTruckAlertVC
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .overCurrentContext
//        self.present(vc, animated: true)
        //self.getTopMostViewController()?.present(vc, animated: true)
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
extension MMPPrestartTwoVC {
    func addPrestart() {
       // guard validateData() else { return }
        let parameters = ["pro_id": "1",
                          "plant_type_id": "1",
                          "datetime":"2022-12-11 12:50:00",
                          "Fluid Levels": [],
                          "Inspection List": []
        ] as [String : Any]
        startLoading()
        print(parameters)
 
        let urlRequest = String (format: "%@%@%@", MMPConstant.baseURL,MMPConstant.ADD_MACHINE_PRESTART)
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
}
