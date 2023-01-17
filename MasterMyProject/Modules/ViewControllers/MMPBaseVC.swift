//
//  MMPBaseVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 13/10/22.
//

import UIKit
import KRProgressHUD
class MMPBaseVC: UIViewController, UIPickerViewDelegate {
    let plantListPicker = UIPickerView()
    let toolbar = UIToolbar()
    var selectedImage = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
    
    func addCustomizedBackBtn(navigationController: UINavigationController?, navigationItem: UINavigationItem?) {
        navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backArrow")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backArrow")
        navigationItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

    }
    
    func showAlerViewController(_ message: String, imageName: String, projectId: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPAlertVC") as!MMPAlertVC
        let navController = UINavigationController(rootViewController: vc) //Add navigation controller
        navController.modalTransitionStyle = .crossDissolve
        navController.modalPresentationStyle = .overCurrentContext
        vc.titleString = message
        vc.imageString = imageName
        vc.projectId = projectId
        self.present(navController, animated: true)
    }
    
    func getTopMostViewController() -> UIViewController? {
        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
        while let presentedViewController = topMostViewController?.presentedViewController {
            topMostViewController = presentedViewController
        }
        return topMostViewController
    }
    
    func noInternetPopUp() {
        if !NetStatus.shared.isConnected || !NetStatus.shared.isConnectedToWIFI {
            alertUser("Error", message: "Internet service not available. Please check your internet service and try again at a later time.")
            return
        }
    }
    
    func alertUser(_ title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func getCurrentDateTime()-> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: date)
        
    }
    func startLoading(){
        KRProgressHUD.show()
        KRProgressHUD.set(activityIndicatorViewColors: [MMPConstant.blueColor])
    }
    
    func stopLoading(){
        KRProgressHUD.dismiss()
    }
    
    func createPickerView() {
        plantListPicker.delegate = self
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(action));
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
    }
    
    @objc func action() {
        view.endEditing(true)
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
