//
//  MMPTruckPrestartOneVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit
import Alamofire
class MMPTruckPrestartOneVC: MMPBaseVC {
    @IBOutlet weak var prestartOneTableView: UITableView!
    @IBOutlet weak var selectTextField: UITextField!
    var projectId = ""
    var plantTypeId = "2"
    var plant_id = ""
    var categoryAArray = [[String:AnyObject]]()
    var categoryBArray = [[String:AnyObject]]()
    var categoryCArray = [[String:AnyObject]]()
    var plantListArray = [[String:AnyObject]]()
    var categoryASelectedArray = [[String:AnyObject]]()
    var categoryADict = [String:AnyObject]()
    var isFromPrestart = false
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(1/3)"
        setUpUI()
        navigationController?.isNavigationBarHidden = false
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
            showTruckAlert()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPlantsList()
        getPrestartCheckList()
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartTwoVC") as! MMPTruckPrestartTwoVC
        vc.categoryBArray = categoryBArray
        vc.categoryCArray = categoryCArray
        vc.categoryASelectedArray = self.categoryASelectedArray
        vc.projectId = self.projectId
        vc.plant_id = self.plant_id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTruckAlert(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckAlertVC") as!MMPTruckAlertVC
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        vc.isFromPrestart = isFromPrestart
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        self.present(navController, animated: true)
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

extension MMPTruckPrestartOneVC {
    
    func getPlantsList() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let projectIdConstant = MMPConstant.PROJECTID_CONSTAT + (projectId ?? "")
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_PLANTS + plantTypeId + projectIdConstant)
        print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("plantlist_response",response)
                    self.stopLoading()
                    self.prestartOneTableView.reloadData()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            self.plantListArray = projectJSON["result_object"] as? [[String: AnyObject]] ?? []
                        }
                    }
                case .failure(let error):
                    print(error)
                    self.stopLoading()
                    DispatchQueue.main.async {
                        //self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
    
    func getPrestartCheckList() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_PRESTART_CHECK_LIST + plantTypeId)
        print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("checklist_response",response)
                    self.stopLoading()
                    self.prestartOneTableView.reloadData()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            if let resultObject = projectJSON["result_object"] as? [String: Any] {
                                self.categoryAArray = resultObject["Category A"] as? [[String:AnyObject]] ?? []
                                self.categoryBArray = resultObject["Category B"] as? [[String:AnyObject]] ?? []
                                self.categoryCArray = resultObject["Category C"] as? [[String:AnyObject]] ?? []
                            }
                            
                            self.prestartOneTableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
                    self.stopLoading()
                    DispatchQueue.main.async {
                        //self.present(alert, animated: true, completion: nil)
                    }
                }
        }
    }
}

extension MMPTruckPrestartOneVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectTextField.inputAccessoryView = toolbar
        selectTextField.inputView = plantListPicker
        if plantListArray.count > 0 {
                print(plantListArray.count)
                createPickerView()
        } else {
            selectTextField.resignFirstResponder()
            self.alertUser("Master My Project", message: "No Trucks found!!")
        }
    }
}

extension MMPTruckPrestartOneVC : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return plantListArray.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plantListArray[row]["plant_name"] as? String
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectTextField.text = plantListArray[row]["plant_name"] as? String
        self.plant_id = plantListArray[row]["id"] as? String ?? ""
    }
}
