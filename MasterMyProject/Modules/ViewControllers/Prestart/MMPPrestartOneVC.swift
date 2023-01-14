//
//  MMPPrestartOneVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 18/10/22.
//

import UIKit
import Alamofire

class MMPPrestartOneVC: MMPBaseVC {

    @IBOutlet weak var prestartOneTableView: UITableView!
    @IBOutlet weak var selectTextField: UITextField!
    var projectId = ""
    var plantTypeId = "1"
    var plant_id = ""
    var plantListArray = [[String:AnyObject]]()
    var prestartListArray = [[String:AnyObject]]()
    var prestartTwoListArray = [[String:AnyObject]]()
    var fluidLevelsArray = [[String:AnyObject]]()
    var fluidLevelsDict = [String:AnyObject]()
    var machineListMode : MMPMachinePrestartListModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "Prestart(1/2)"
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getPlantsList()
        getPrestartCheckList()
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        if !MMPUtilities.valiadateBlankText(text: selectTextField.text) {
            alertUser("Master My Project", message: "Please select machine type ")
            return
        }
        
        if prestartListArray.count == fluidLevelsArray.count {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPPrestartTwoVC") as! MMPPrestartTwoVC
        vc.prestartTwoListArray = prestartTwoListArray
        vc.fluidLevelsSelectedArray = fluidLevelsArray
        vc.plant_id = self.plant_id
        vc.projectId = self.projectId
        self.navigationController?.pushViewController(vc, animated: true)
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
extension MMPPrestartOneVC {
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
                  // print("checklist_response",response)
                    self.stopLoading()
                    self.prestartOneTableView.reloadData()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            if let resultObject = projectJSON["result_object"] as? [String: Any] {
                                self.prestartListArray = resultObject["Fluid Levels"] as? [[String:AnyObject]] ?? []
                                self.prestartTwoListArray = resultObject["Inspection List"] as? [[String:AnyObject]] ?? []
                            }
                            
                            self.prestartOneTableView.reloadData()
                        }
                    }
                    
//                    if let data = response.data {
//                        do {
//                           let wrapper = try JSONDecoder().decode(machineListMode.self, from: data)
//                           print(wrapper.all)
//                        } catch {
//                           print("Decoding error \(error.localizedDescription)")
//                        }
//                    }
                    
                  /*  if let data = response.data {
                       do {
                            let decoder = JSONDecoder()
                            decoder.keyDecodingStrategy = .convertFromSnakeCase
                            let result = try decoder.decode(MMPMachinePrestartListModel.self, from: data)
                            print(result)
                          // machineListMode?.resultObject.in
                        } catch { print(error) }
                    }*/
                        
                        
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

extension MMPPrestartOneVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectTextField.inputAccessoryView = toolbar
        selectTextField.inputView = plantListPicker
        if plantListArray.count > 0 {
                print(plantListArray.count)
                createPickerView()
            } else {
                selectTextField.resignFirstResponder()
                self.alertUser("Master My Project", message: "No Machine found!!")
            }
        }
}

extension MMPPrestartOneVC : UIPickerViewDataSource {
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
        plant_id = plantListArray[row]["id"] as? String ?? ""
    }
}
