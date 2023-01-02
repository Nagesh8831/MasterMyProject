//
//  MMPDocketTwoVC.swift
//  MasterMyProject
//
//  Created by Nagesh on 17/10/22.
//

import UIKit

class MMPDocketTwoVC: MMPBaseVC {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var jobOneImage: UIImageView!
    @IBOutlet weak var jobTwoImage: UIImageView!
    var isSetImageOne = false
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
