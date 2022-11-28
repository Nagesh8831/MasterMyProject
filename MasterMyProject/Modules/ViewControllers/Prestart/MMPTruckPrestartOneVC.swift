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
    var projectId: String?
    var plantTypeId = "2"
    var categoryAArray = [[String:AnyObject]]()
    var categoryBArray = [[String:AnyObject]]()
    var categoryCArray = [[String:AnyObject]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Prestart(1/3)"
        setUpUI()
        navigationController?.isNavigationBarHidden = false
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        getPrestartCheckList()
    }
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPTruckPrestartTwoVC") as! MMPTruckPrestartTwoVC
        vc.categoryBArray = categoryBArray
        vc.categoryCArray = categoryCArray
        self.navigationController?.pushViewController(vc, animated: true)
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
