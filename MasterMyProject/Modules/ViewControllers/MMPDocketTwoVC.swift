//
//  MMPDocketTwoVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 17/10/22.
//

import UIKit
import Alamofire
class MMPDocketTwoVC: MMPBaseVC {
    @IBOutlet weak var totalTimeTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var jobOneImage: UIImageView!
    @IBOutlet weak var jobTwoImage: UIImageView!
    @IBOutlet weak var workDoneListTableView: UITableView!
    var isSetImageOne = false
    var projectId = ""
    var workDoneListArray = [[String:AnyObject]]()
    var followerId = [String]()
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
    }
    override func viewWillAppear(_ animated: Bool) {
        getWorkDone()
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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        workDoneListTableView.isHidden = false
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
            } else {
                self?.jobTwoImage.image = image
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
        totalTimeTextField.inputAccessoryView = toolbar
        totalTimeTextField.inputView = plantListPicker
        createPickerView()
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
            return workDoneListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "workDoneTableViewCell", for: indexPath) as! workDoneTableViewCell

            if let name = workDoneListArray[indexPath.row]["activity"] as? String {
                cell.nameLabel.text = name
            }
            cell.checkBtn.tag = indexPath.row
            cell.checkBtn.addTarget(self, action: #selector(readMessage), for: .touchUpInside)
            
            cell.checkBtn.isSelected = false
        if followerId.contains((workDoneListArray[indexPath.row]["id"] as? String ?? "")) {
                cell.checkBtn.setImage(UIImage(named: "ic_check"), for: .normal)

            }else{
                 cell.checkBtn.setImage(UIImage(named: "uncheck"), for: .normal)
            }
        
        return cell
    }
    
    @objc func readMessage(sender:UIButton) {
        sender.isSelected = !sender.isSelected
        let point = sender.convert(CGPoint.zero, to: workDoneListTableView)
        let indxPath = workDoneListTableView.indexPathForRow(at: point)
        
        if followerId.contains((workDoneListArray[sender.tag]["id"] as? String)!) {
            //selectedRows.remove(at: selectedRows.index(of: indxPath!)!)
            if let fId = workDoneListArray[sender.tag]["id"] as? String   {
                for i in 0...followerId.count - 1 {
                    if fId == followerId[i] {
                        followerId.remove(at: i)
                        break
                    }
                }
                print("did deselect and the text is \(followerId)")
                print("total123",followerId.count)
                // isSelected_All = false
            }
        } else {
            // selectedRows.append(indxPath!)
            if   let id = workDoneListArray[sender.tag]["id"] as? String  {
                followerId.append(id)
                print("did select and the text is  \(followerId)")
                print("total123",followerId.count)
            }
        }
        
        workDoneListTableView.reloadRows(at: [indxPath!], with: .automatic)
    }
 
}

class workDoneTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
}
