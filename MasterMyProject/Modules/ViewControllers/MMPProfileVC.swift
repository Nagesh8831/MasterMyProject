//
//  MMPProfileVC.swift
//  MasterMyProject
//
//  Created by KO158S8 on 12/10/22.
//

import UIKit

class MMPProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func logOutButtonAction(_ sender: UIButton) {
        logout()
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
extension MMPProfileVC {
    func logout(){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to sign out?", preferredStyle: .alert)
            let saveAction = UIAlertAction(title: "Yes", style: .default, handler: {
                alert -> Void in
                UserDefaults.standard.removeObject(forKey: "isLogin")
                UserDefaults.standard.synchronize()
                
                if #available(iOS 13.0, *) {
                    let scene = UIApplication.shared.connectedScenes.first
                    if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                        sd.makeRoot()
                    }
                } else {
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDelegate.makeRootViewController()
                }
            })
            let cancelAction = UIAlertAction(title: "No", style: .default, handler: {
                (action : UIAlertAction!) -> Void in
            })
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
