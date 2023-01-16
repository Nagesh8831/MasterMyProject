//
//  MMPDocketTwoVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 17/10/22.
//

import UIKit
import Alamofire
class MMPDocketTwoVC: MMPBaseVC {
    @IBOutlet weak var workDoneLabel: UILabel!
    @IBOutlet weak var plantLabel: UILabel!
    @IBOutlet weak var totalTimeTextField: UITextField!
    @IBOutlet weak var descriptionTextView:UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var jobOneImage: UIImageView!
    @IBOutlet weak var jobTwoImage: UIImageView!
    @IBOutlet weak var workDoneListTableView: UITableView!
    @IBOutlet weak var plantListTableView: UITableView!
    @IBOutlet weak var yesFreeFromAffectButton: UIButton!
    @IBOutlet weak var noFreeFromAffectButton: UIButton!
    var attachmentData = Data()
    var isSetImageOne = false
    var imgOne = UIImage()
    var imgTwo = UIImage()
    var projectId = ""
    var freeFromDrug = ""
    var workDoneListArray = [[String:AnyObject]]()
    var plantListArray = [[String:AnyObject]]()
    var workDoneIdList = [String]()
    var plantIdList = [String]()
    // var dateTime = ""
    var timeArray = ["1Hrs","2Hrs","3Hrs","4Hrs","5Hrs","6Hrs","7Hrs","8Hrs","9Hrs","10Hrs","11Hrs","12Hrs","13Hrs","14Hrs","15Hrs","16Hrs","17Hrs","18Hrs","19Hrs","20Hrs","21Hrs","22Hrs","23Hrs","24Hrs"]
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        title = "Doket"
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        let tapImageOne = UITapGestureRecognizer(target: self, action: #selector(imageOneTapped))
        let tapImageTwo = UITapGestureRecognizer(target: self, action: #selector(imageTwoTapped))
        jobOneImage.addGestureRecognizer(tapImageOne)
        jobTwoImage.addGestureRecognizer(tapImageTwo)
        jobTwoImage.isUserInteractionEnabled = true
        jobOneImage.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        workDoneListTableView.isHidden = true
        plantListTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getWorkDone()
        getPlantsList()
    }
    
    @objc func imageOneTapped(tapGestureRecognizer: UITapGestureRecognizer){
        showAlert()
        isSetImageOne = true
    }
    
    @objc func imageTwoTapped(tapGestureRecognizer: UITapGestureRecognizer){
        showAlert()
        isSetImageOne = false
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendButtonAction(_ sender: UIButton) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
//        self.navigationController?.pushViewController(vc, animated: true)
        addDocket()
    }
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        workDoneListTableView.isHidden = false
        plantListTableView.isHidden = true
    }
    
    @IBAction func addMoreButtonAction(_ sender: UIButton) {
        workDoneListTableView.isHidden = true
        plantListTableView.isHidden = false
    }
    
    @IBAction func yesNoButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 98:
            yesFreeFromAffectButton.backgroundColor = MMPConstant.greenColor
            yesFreeFromAffectButton.tintColor = .white
            noFreeFromAffectButton.tintColor = MMPConstant.redColor
            noFreeFromAffectButton.backgroundColor = .clear
            freeFromDrug = "Yes"
        case 99:
            yesFreeFromAffectButton.backgroundColor = .clear
            yesFreeFromAffectButton.tintColor = MMPConstant.greenColor
            noFreeFromAffectButton.backgroundColor = MMPConstant.redColor
            noFreeFromAffectButton.tintColor = .white
            freeFromDrug = "No"
        default:
            break
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

extension MMPDocketTwoVC {
    func getWorkDone() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let _headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_PROJECT_WORKS + projectId)
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
                            guard let projectDetails = projectJSON["result_object"] as? [[String:AnyObject]] else {return}
                           // self.productDetails = projectDetails
                            self.workDoneListArray = projectDetails
                            self.workDoneListTableView.reloadData()
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
    
    func getPlantsList() {
        startLoading()
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        let projectIdConstant = MMPConstant.PROJECTID_CONSTAT + projectId
        let urlResponce = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.GET_PLANTS + "0" + projectIdConstant)
        print(urlResponce)
        AF.request( urlResponce,method: .get ,parameters: nil,encoding:
            JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("plantlist_response",response)
                    self.stopLoading()
                    if let projectJSON = value as? [String: Any] {
                        let status = projectJSON["status_code"] as? Int
                        let message = projectJSON["message"] as? String
                        if status == 200 {
                            self.plantListArray = projectJSON["result_object"] as? [[String: AnyObject]] ?? []
                            self.plantListTableView.reloadData()
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
    
    func addDocket() {
        let token = UserDefaults.standard.string(forKey: "userToken")
            let boundary = generateBoundaryString()
            let headers: HTTPHeaders = ["content-type": "multipart/form-data; boundary=\(boundary)",
                "cache-control": "no-cache",
                "Authorization": "Bearer \(token ?? "")",]
            let urlResponce = String(format: "%@%@",MMPConstant.baseURL, MMPConstant.ADD_DOCKET)
                   //print(urlResponce)
         let param = [
              "pro_id" : projectId as AnyObject,
              "pro_activity_id": workDoneIdList as AnyObject,
              "description": "sdsfdsdfs" as AnyObject,//descriptionTextView.text as AnyObject,
              "total_time" : totalTimeTextField.text as AnyObject,
              "free_frm_acl_drg_ftgr": freeFromDrug as AnyObject,
              "datetime" : getCurrentDateTime() as AnyObject,
              "plant_id" : plantIdList as AnyObject
              ] as [String : AnyObject]
            print(param)
            startLoading()
        
        AF.upload(
                    multipartFormData: { multipartFormData in
                        multipartFormData.append(self.imgOne.jpegData(compressionQuality: 0.5)!, withName: "job_per_photo1" , fileName: "file.jpeg", mimeType: "image/jpeg")
                        multipartFormData.append(self.imgOne.jpegData(compressionQuality: 0.5)!, withName: "job_per_photo2" , fileName: "file.jpeg", mimeType: "image/jpeg")
                        multipartFormData.append(self.imgOne.jpegData(compressionQuality: 0.5)!, withName: "signature" , fileName: "file.jpeg", mimeType: "image/jpeg")
                },
                    to: urlResponce, method: .post , headers: headers)
                    .response { resp in
                        print("resp.result",resp.result)
                        self.stopLoading()
                        if let status = resp.response?.statusCode {
                                         switch(status){
                                         case 200:
                                            print(resp.result)
                                                     let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
                                                     self.navigationController?.pushViewController(vc, animated: true)
                                            do{
                                                if let json = resp.data {
                                                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{

                                                        print(jsonData)
                                                        if let issueAgenda = jsonData["pro_id"] as? String  {
                                                           print("issueAgenda",issueAgenda)
                                                        }
                                                    }
                                                }
                                            }catch {
                                                //print(error.localizedDescription)
                                            }

                                         default:
                                             //print("error with response status: \(status)")
                                             do{
                                                 if let json = resp.data {
                                                     if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                                                         //print(jsonData)
                                            // self.alert(jsonData["message"] as! String, message: "")
                                                        self.alertUser(jsonData["message"] as! String, message: "")
                                                     }
                                                 }
                                             }catch {
                                                 print(error.localizedDescription)
                                             }
                                         }
                                     }
                    

                }
        /*
       // let image = UIImage(named: "your image") // Change me
                    let imageData = imgOne.jpegData(compressionQuality: 1.0)!
                  //  let imageKey = "job_per_photo1" // Change me
                   // let urlString = "https://yourserver.com/yourendpoint/" // Change me
                    //let params: [String: Any]? = [:] // Change me. Your POST params here
//                    let headers: HTTPHeaders = [
//                        // Change me. Your headers here.
//                    ]
                    AF.upload(multipartFormData: { multiPart in
                        for (key, value) in (param) {
                            if let arrayObj = value as? [Any] {
                                for index in 0..<arrayObj.count {
                                    multiPart.append("\(arrayObj[index])".data(using: .utf8)!, withName: "\(key)[\(index)]")
                                }
                            } else {
                                multiPart.append("\(value)".data(using: .utf8)!, withName: key)
                            }
                        }
                        multiPart.append(imageData, withName: "job_per_photo1", fileName: "file.jpg", mimeType: "image/jpg")
                        multiPart.append(imageData, withName: "job_per_photo2", fileName: "file.jpg", mimeType: "image/jpg")
                        multiPart.append(imageData, withName: "signature", fileName: "file.jpg", mimeType: "image/jpg")
                    }, to: urlResponce, headers: headers).responseJSON { response in
                        switch response.result {
                        case .success(_):
                            if let dictionary = response.value as? [String:Any] {
                                print("success", dictionary)
                            } else {
                                print("error")
                            }
                        case .failure(let error):
                            print("error", error.localizedDescription)
                        }
                    }*/
//        AF.upload(multipartFormData: { (multiFormData) in
//                for (key, value) in param {
//                    multiFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
//                }
//            }, to: urlResponce).responseJSON { response in
//                switch response.result {
//                case .success(let JSON):
//                    print("response is :\(response)")
//
//                case .failure(_):
//                    print("fail")
//                }
//            }
        
        
             /* AF.upload(multipartFormData: { (multipartFormData) in
                  
                  for (key, value) in param {
                               multipartFormData.append((value as! AnyObject).data(using: String.Encoding.utf8)!, withName: key)
                           }
                               
                  multipartFormData.append(self.attachmentData, withName: "job_per_photo1", fileName: "Vote.png", mimeType: "image/png")
                }, to: urlResponce, usingThreshold: UInt64.init(), method: .post, headers: headers).response{ response in
                    //print("Agenda_response",response)
               // debugprint(response)
                self.stopLoading()
                        if let status = response.response?.statusCode {
                                         switch(status){
                                         case 200:
                                            //print(response.result)
                                            do{
                                                if let json = response.data {
                                                    if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{

                                                        print(jsonData)
//                                                        if let issueAgenda = jsonData["issueAgenda"] as? [String:AnyObject] , let agendaid = issueAgenda["id"]  as? Int  {
//                                                            self.id = agendaid
//                                                        }
                                                    }
                                                }
                                            }catch {
                                                //print(error.localizedDescription)
                                            }
//                                             self.navigationController?.popViewController(animated: true)
                                         default:
                                             //print("error with response status: \(status)")
                                             do{
                                                 if let json = response.data {
                                                     if let jsonData = try JSONSerialization.jsonObject(with: json, options: .allowFragments) as? [String:AnyObject]{
                                                         //print(jsonData)
                                            // self.alert(jsonData["message"] as! String, message: "")
                                                        self.alertUser(jsonData["message"] as! String, message: "")
                                                     }
                                                 }
                                             }catch {
                                                 //print(error.localizedDescription)
                                             }
                                         }
                                     }
                
        }*/
    }
    
    func generateBoundaryString() -> String {
          return "Boundary-\(UUID().uuidString)"
      }
}

extension MMPDocketTwoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //Show alert to selected the media source type.
    func showAlert() {
        let alert = UIAlertController(title: "Camera Access Required", message: "'Master My Project' would like to access the camera", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //get image from source type
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        //Check is source type available
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    //MARK:- UIImagePickerViewDelegate.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //Setting image to your image view
            if self?.isSetImageOne == true{
                self?.jobOneImage.image = image
                self?.imgOne = image
                self?.attachmentData = image.jpegData(compressionQuality: 0.2)!
            } else {
                self?.jobTwoImage.image = image
               // self?.attachmentData = image.jpegData(compressionQuality: 0.2)!
            }
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.goToVerficationVC()
//            print("call verification")
//        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension MMPDocketTwoVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        workDoneListTableView.isHidden = true
        plantListTableView.isHidden = true
        totalTimeTextField.inputAccessoryView = toolbar
        totalTimeTextField.inputView = plantListPicker
        createPickerView()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension MMPDocketTwoVC : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeArray.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeArray[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        totalTimeTextField.text = timeArray[row]
    }
}

extension MMPDocketTwoVC : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == workDoneListTableView ? workDoneListArray.count : plantListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        if tableView == workDoneListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "workDoneTableViewCell", for: indexPath) as! workDoneTableViewCell
            returnCell = cell
            if let name = workDoneListArray[indexPath.row]["activity"] as? String {
                cell.nameLabel.text = name
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(workDoneButtonCLick), for: .touchUpInside)
            
            cell.checkBtn.isSelected = false
        if workDoneIdList.contains((workDoneListArray[indexPath.row]["id"] as? String ?? "")) {
                cell.checkBtn.setImage(UIImage(named: "ic_check"), for: .normal)

            }else{
                 cell.checkBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }
        }
        
        if tableView == plantListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "plantTableViewCell", for: indexPath) as! plantTableViewCell
            returnCell = cell
            if let name = plantListArray[indexPath.row]["plant_name"] as? String {
                cell.nameLabel.text = name
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(platTypeButtonClick), for: .touchUpInside)
            
            cell.checkBtn.isSelected = false
        if plantIdList.contains((plantListArray[indexPath.row]["id"] as? String ?? "")) {
                cell.checkBtn.setImage(UIImage(named: "ic_check"), for: .normal)

            }else{
                 cell.checkBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }
        }
        return returnCell
    }
    
    @objc func workDoneButtonCLick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        let point = sender.convert(CGPoint.zero, to: workDoneListTableView)
        let indxPath = workDoneListTableView.indexPathForRow(at: point)
        
        if workDoneIdList.contains((workDoneListArray[sender.tag]["id"] as? String)!) {
            //selectedRows.remove(at: selectedRows.index(of: indxPath!)!)
            if let fId = workDoneListArray[sender.tag]["id"] as? String   {
                for i in 0...workDoneIdList.count - 1 {
                    if fId == workDoneIdList[i] {
                        workDoneIdList.remove(at: i)
                        break
                    }
                }
                print("did deselect and the text is \(workDoneIdList)")
                print("total123",workDoneIdList.count)
                // isSelected_All = false
            }
        } else {
            // selectedRows.append(indxPath!)
            if   let id = workDoneListArray[sender.tag]["id"] as? String  {
                workDoneIdList.append(id)
                print("did select and the text is  \(workDoneIdList)")
                print("total123",workDoneIdList.count)
            }
        }
        workDoneLabel.text = workDoneIdList.joined(separator: ",")
        workDoneListTableView.reloadRows(at: [indxPath!], with: .automatic)
    }
 
    @objc func platTypeButtonClick(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        let point = sender.convert(CGPoint.zero, to: plantListTableView)
        let indxPath = plantListTableView.indexPathForRow(at: point)
        
        if plantIdList.contains((plantListArray[sender.tag]["id"] as? String)!) {
            //selectedRows.remove(at: selectedRows.index(of: indxPath!)!)
            if let fId = plantListArray[sender.tag]["id"] as? String   {
                for i in 0...plantIdList.count - 1 {
                    if fId == plantIdList[i] {
                        plantIdList.remove(at: i)
                        break
                    }
                }
                print("did deselect and the text is \(plantIdList)")
                print("total123",plantIdList.count)
                // isSelected_All = false
            }
        } else {
            // selectedRows.append(indxPath!)
            if   let id = plantListArray[sender.tag]["id"] as? String  {
                plantIdList.append(id)
                print("did select and the text is  \(plantIdList)")
                print("total123",plantIdList.count)
            }
        }
        plantLabel.text = plantIdList.joined(separator: ",")
        plantListTableView.reloadRows(at: [indxPath!], with: .automatic)
    }
    
}

class workDoneTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
}

class plantTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
}
