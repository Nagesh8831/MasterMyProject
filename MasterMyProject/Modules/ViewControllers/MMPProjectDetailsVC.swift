//
//  MMPProjectDetailsVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 12/10/22.
//

import UIKit
import Alamofire

class MMPProjectDetailsVC: MMPBaseVC {
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectClientNameLabel: UILabel!
    @IBOutlet weak var projectClientRepNameLabel: UILabel!
    @IBOutlet weak var projectClientRepNumberLabel: UILabel!
    @IBOutlet weak var projectDescription: UITextView!
    var projectId: String?
    var productDetails = [String:AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProjectByUserId()
    }

    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
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

extension MMPProjectDetailsVC {
    func getProjectByUserId() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let _headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_PROJECT_BY_USERID + (projectId ?? ""))
        print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: _headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("project_response",response)
                    self.stopLoading()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            guard let projectDetails = projectJSON["result_object"] as? [String:AnyObject] else {return}
                           // self.productDetails = projectDetails
                            self.title = projectDetails["pro_name"] as? String
                            self.projectNameLabel.text = projectDetails["pro_name"] as? String
                            self.projectClientNameLabel.text = projectDetails["client_name"] as? String
                            self.projectClientRepNameLabel.text = projectDetails["rep_name"] as? String
                            self.projectClientRepNumberLabel.text = projectDetails["rep_contact"] as? String
                            self.projectDescription.text = projectDetails["pro_desc"] as? String
//                            if self.projectArray.count == 0 {
//                                self.noDataLabel.isHidden = false
//                                self.projectListTableView.isHidden = true
//                                self.noDataLabel.text = message
//                            } else {
//                                self.noDataLabel.isHidden = true
//                                self.projectListTableView.isHidden = false
//                            }
                           
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
