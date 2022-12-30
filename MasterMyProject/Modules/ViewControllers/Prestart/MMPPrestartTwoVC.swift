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
    var projectId = ""
    var prestartTwoListArray = [[String:AnyObject]]()
    var fluidLevelsSelectedArray = [[String:AnyObject]]()
    var inspectionListSelectedArray = [[String:AnyObject]]()
    var inspectionListDict = [String:AnyObject]()
    var plant_id = ""
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
        if prestartTwoListArray.count == inspectionListSelectedArray.count {
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
extension MMPPrestartTwoVC {
    func addPrestart() {
      //  guard validateData() else { return }
        let parameters = ["pro_id": projectId,
                          "plant_type_id": "1",
                          "plant_id": plant_id,
                          "datetime":"2022-12-11 12:50:00",
                          "Fluid Levels": fluidLevelsSelectedArray,
                          "Inspection List": inspectionListSelectedArray
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
//                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
//                            vc.isFromPrestart = true
//                            self.navigationController?.pushViewController(vc, animated: true)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPAlertVC") as!MMPAlertVC
                            let navController = UINavigationController(rootViewController: vc) //Add navigation controller
                            navController.modalTransitionStyle = .crossDissolve
                            navController.modalPresentationStyle = .overCurrentContext
                            vc.delegate = self
                            vc.titleString = "Are you operating Machine?"
                            vc.imageString = "machine"
                            vc.projectId = self.projectId
                            vc.isFromPrestartTwo = true
                            self.present(navController, animated: true)
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

extension MMPPrestartTwoVC : SelectActionControllerDelegate {
    func machineViewDismissed() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPPrestartOneVC") as! MMPPrestartOneVC
         vc.projectId = projectId
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func truckViewDismissed() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartOneVC") as! MMPTruckPrestartOneVC
        vc.projectId = projectId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
