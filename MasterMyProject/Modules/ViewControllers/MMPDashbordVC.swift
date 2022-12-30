//
//  MMPDashbordVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 05/10/22.
//

import UIKit
import Alamofire
class MMPDashbordVC: MMPBaseVC {
    @IBOutlet weak var projectTitleLabel: UILabel!
    @IBOutlet weak var projectCountLabel: UILabel!
    @IBOutlet weak var timeTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var earnTitleLabel: UILabel!
    @IBOutlet weak var earnLabel: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var projectListTableView: UITableView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var workerNameLabel: UILabel!
    var projectArray = [[String:AnyObject]]()
    var workerDetails = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
       // self.showAlerViewController("Are you operating Machine?", imageName: "machine")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
        getAllProjects()
        getWorkerByUserId()
    }
    
    @IBAction func profileButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPProfileVC") as! MMPProfileVC
        vc.workerDetails = self.workerDetails
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
       // self.navigationController?.pushViewController(vc, animated: true)
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
extension MMPDashbordVC {
    
    func getAllProjects() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_ALL_PROJECT)
       // print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("project_response",response)
                    self.stopLoading()
                    self.projectListTableView.reloadData()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            self.projectArray = projectJSON["result_object"] as? [[String:AnyObject]] ?? []
                            self.projectCountLabel.text = "\(self.projectArray.count)"
                            if self.projectArray.count == 0 {
                                self.noDataLabel.isHidden = false
                                self.projectListTableView.isHidden = true
                                self.noDataLabel.text = message
                            } else {
                                self.noDataLabel.isHidden = true
                                self.projectListTableView.isHidden = false
                            }
                            self.projectListTableView.reloadData()
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
    
    func getWorkerByUserId() {
        let token = UserDefaults.standard.string(forKey: "userToken")
        let userId = UserDefaults.standard.string(forKey: "userId") ?? "0"
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_WORKER_BY_ID  + userId)
        print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                  //  print("worker_response",response)
                    self.stopLoading()
                    self.projectListTableView.reloadData()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                      //  let message = projectJSON["message"] as? String
                        if status == 200 {
                            guard let workerDetails = projectJSON["result_object"] as? [String:AnyObject] else {return}
                            self.workerDetails = workerDetails
                            guard let name = workerDetails["name"] else {return}
                            self.workerNameLabel.text = "Hello, \(name)"
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
