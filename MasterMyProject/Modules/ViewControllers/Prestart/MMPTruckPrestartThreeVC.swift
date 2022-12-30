//
//  MMPTruckPrestartThreeVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit
import Alamofire
class MMPTruckPrestartThreeVC: MMPBaseVC {
    @IBOutlet weak var prestartTwoTableView: UITableView!
    var projectId = ""
    var categoryCArray = [[String:AnyObject]]()
    var categoryASelectedArray = [[String:AnyObject]]()
    var categoryBSelectedArray = [[String:AnyObject]]()
    var categoryCSelectedArray = [[String:AnyObject]]()
    var categoryCDict = [String:AnyObject]()
    
    var plant_id = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(3/3)"
        setUpUI()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPSignInSucessAlertVC") as!MMPSignInSucessAlertVC
//        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
//        navController.modalTransitionStyle = .crossDissolve
//        navController.modalPresentationStyle = .overCurrentContext
//        self.present(navController, animated: true, completion: nil)
        if categoryCArray.count == categoryCSelectedArray.count {
            addPrestart()
        } else {
            alertUser("Error", message: "Please select correct answers for all questions")
        }
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

extension MMPTruckPrestartThreeVC {
    func addPrestart() {
       // guard validateData() else { return }
        let parameters = ["pro_id": projectId,
                          "plant_type_id": "2",
                          "plant_id": plant_id,
                          "datetime":"2022-12-11 12:50:00",
                          "Category A": categoryASelectedArray,
                          "Category B": categoryBSelectedArray,
                          "Category C": categoryCSelectedArray
        ] as? [String : AnyObject]
        startLoading()
        print(parameters)
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        //let urlRequest = String (format: "%@%@%@", MMPConstant.baseURL,MMPConstant.ADD_MACHINE_PRESTART)
        let urlRequest = "http://52.63.247.85/mastermyproject/restapi/projects/addprestart"
        print(urlRequest)
        AF.request( urlRequest,method: .post ,parameters: parameters,encoding:
                        JSONEncoding.default, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                self.stopLoading()
                print("login_response",response)
                if let loginJSON = value as? [String: Any] {
                    if let statusCode = loginJSON["status_code"] as? Int,let meesage = loginJSON["message"] as? String{
                        print(statusCode)
                        if statusCode == 201 {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
                            vc.projectId = self.projectId
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
