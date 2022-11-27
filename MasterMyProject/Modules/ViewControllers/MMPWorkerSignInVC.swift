//
//  MMPWorkerSignInVC.swift
//  MasterMyProject
//
//  Created by Mac on 26/11/22.
//

import UIKit
import CoreLocation
import Alamofire
class MMPWorkerSignInVC: MMPBaseVC {
    @IBOutlet weak var workerLocationLabel: UILabel!
    @IBOutlet weak var workerDateLabel: UILabel!
    @IBOutlet weak var workerCurrentTimeLabel: UILabel!
    @IBOutlet weak var yesPPEButton: UIButton!
    @IBOutlet weak var noPPEButton: UIButton!
    @IBOutlet weak var yesOnSiteButton: UIButton!
    @IBOutlet weak var noOnSiteButton: UIButton!
    @IBOutlet weak var yesGoAhedButton: UIButton!
    @IBOutlet weak var noGoAhedButton: UIButton!
    @IBOutlet weak var yesAffectedButton: UIButton!
    @IBOutlet weak var noAffectedButton: UIButton!
    var projectId: String?
    var statusPPE = ""
    var onSiteStatus = ""
    var goAheadStatus = ""
    var affectedStatus = ""
    var lat = ""
    var long = "0.0"
    var dateTime = ""
    var locationManager:CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomizedBackBtn(navigationController: self.navigationController, navigationItem: self.navigationItem)
        navigationController?.isNavigationBarHidden = false
        title = "Sign In"
        locationManager = CLLocationManager()
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.requestAlwaysAuthorization()

           if CLLocationManager.locationServicesEnabled(){
               locationManager.startUpdatingLocation()
           }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        printTimestamp()
    }
    
    @IBAction func questinsButtonAction(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            yesPPEButton.backgroundColor = MMPConstant.greenColor
            yesPPEButton.tintColor = .white
            noPPEButton.tintColor = MMPConstant.redColor
            noPPEButton.backgroundColor = .clear
            statusPPE = "Yes"
        case 2:
            yesPPEButton.backgroundColor = .clear
            yesPPEButton.tintColor = MMPConstant.greenColor
            noPPEButton.backgroundColor = MMPConstant.redColor
            noPPEButton.tintColor = .white
            statusPPE = "No"
        case 3:
            yesOnSiteButton.backgroundColor = MMPConstant.greenColor
            yesOnSiteButton.tintColor = .white
            noOnSiteButton.tintColor = MMPConstant.redColor
            noOnSiteButton.backgroundColor = .clear
            onSiteStatus = "Yes"
        case 4:
            yesOnSiteButton.backgroundColor = .clear
            yesOnSiteButton.tintColor = MMPConstant.greenColor
            noOnSiteButton.backgroundColor = MMPConstant.redColor
            noOnSiteButton.tintColor = .white
            onSiteStatus = "No"
        case 5:
            yesGoAhedButton.backgroundColor = MMPConstant.greenColor
            yesGoAhedButton.tintColor = .white
            noGoAhedButton.tintColor = MMPConstant.redColor
            noGoAhedButton.backgroundColor = .clear
            goAheadStatus = "Yes"
        case 6:
            yesGoAhedButton.backgroundColor = .clear
            yesGoAhedButton.tintColor = MMPConstant.greenColor
            noGoAhedButton.backgroundColor = MMPConstant.redColor
            noGoAhedButton.tintColor = .white
            goAheadStatus = "No"
        case 7:
            yesAffectedButton.backgroundColor = MMPConstant.greenColor
            yesAffectedButton.tintColor = .white
            noAffectedButton.tintColor = MMPConstant.redColor
            noAffectedButton.backgroundColor = .clear
            affectedStatus = "Yes"
        case 8:
            yesAffectedButton.backgroundColor = .clear
            yesAffectedButton.tintColor = MMPConstant.greenColor
            noAffectedButton.backgroundColor = MMPConstant.redColor
            noAffectedButton.tintColor = .white
            affectedStatus = "No"
        default:
            break
        }
        }
    
    @IBAction func projectSignInAction(_ sender: Any) {
        projectSignIn()
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

extension MMPWorkerSignInVC {
    func projectSignIn(){
        guard validateData() else { return }
        let parameters = ["pro_id": projectId ?? "",
                          "que_1": statusPPE,
                          "que_2": onSiteStatus,
                          "que_3": goAheadStatus,
                          "que_4": affectedStatus,
                          "latitude": lat,
                          "longitude": long,
                          "datetime" :dateTime
        ]
        let token = UserDefaults.standard.string(forKey: "userToken")
        let headers : HTTPHeaders = ["Authorization": "Bearer \(token ?? "")",
                                      "Content-Type": "application/json"]
        startLoading()
        print(parameters)
        //let url = "http://52.63.247.85/mastermyproject/restapi"
        let urlRequest = String(format: "%@%@",MMPConstant.baseURL,MMPConstant.PROJECT_SIGN_IN)
       // let urlRequest = "http://52.63.247.85/mastermyproject/restapi/projects/signin"
      //  let urlRequest = String (format: "%@%@%@", MMPConstant.baseURL,MMPConstant.PROJECT_SIGN_IN)
        print(urlRequest)
        AF.request( urlRequest,method: .post ,parameters: parameters,encoding:
                        JSONEncoding.default, headers: headers)
        .responseJSON { response in
            switch response.result {
            case .success(let value):
                self.stopLoading()
                print("projectSignIn_response",response)
                if let loginJSON = value as? [String: Any] {
                    if let statusCode = loginJSON["status_code"] as? Int,let meesage = loginJSON["message"] as? String{
                        print(statusCode)
                        if statusCode == 200 {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MMPDashbordVC") as! MMPDashbordVC
                            if let resultObject = loginJSON["result_object"] as? [String: Any], let token = resultObject["token"] as? String, let id = resultObject["id"] as? String {
                                UserDefaults.standard.set(token, forKey: "userToken")
                                UserDefaults.standard.set(id, forKey: "userId")
                                UserDefaults.standard.set(true, forKey: "isLogin")
                                UserDefaults.standard.synchronize()
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                        } else if statusCode == 403 {
                            self.alertUser("Error", message: meesage)
                        }
                    }
                }
            case .failure(let error):
                print("error",error)
                self.stopLoading()
                DispatchQueue.main.async {
                    //self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func printTimestamp() {
        let currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
        let currentDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.dateTime = df.string(from: date)
        self.workerDateLabel.text = currentDate
        self.workerCurrentTimeLabel.text = currentTime
        
    }
    func validateData() -> Bool {
        if !MMPUtilities.valiadateBlankText(text: statusPPE) || !MMPUtilities.valiadateBlankText(text: onSiteStatus) || !MMPUtilities.valiadateBlankText(text: goAheadStatus) || !MMPUtilities.valiadateBlankText(text: affectedStatus) {
            alertUser("Master My Project", message: "Please select all field")
            return false
        }

        return true
    }
}

extension MMPWorkerSignInVC : CLLocationManagerDelegate {
    //MARK: - location delegate methods
    func geocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?, Error?) -> ())  {
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { completion($0?.first, $1) }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation :CLLocation = locations[0] as CLLocation
        self.lat = "\(userLocation.coordinate.latitude)"
        self.long = "\(userLocation.coordinate.longitude)"
      //  print("user latitude = \(userLocation.coordinate.latitude)")
      //  print("user longitude = \(userLocation.coordinate.longitude)")
            //Access the last object from locations to get perfect current location
            if let location = locations.last {

                let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)

                geocode(latitude: myLocation.latitude, longitude: myLocation.longitude) { placemark, error in
                    guard let placemark = placemark, error == nil else { return }
                    // you should always update your UI in the main thread
                    DispatchQueue.main.async {
                        //  update UI here
                       /* print("address1:", placemark.thoroughfare ?? "")
                        print("address2:", placemark.subThoroughfare ?? "")
                        print("city:",     placemark.locality ?? "")
                        print("state:",    placemark.administrativeArea ?? "")
                        print("zip code:", placemark.postalCode ?? "")
                        print("country:",  placemark.country ?? "")*/
                      //  self.workerLocationLabel.text = "\(placemark.thoroughfare ?? ""), \(placemark.locality ?? ""), \(placemark.country ?? "")"
                        self.workerLocationLabel.text = "\(placemark.locality ?? ""), \(placemark.administrativeArea ?? ""), \(placemark.country ?? "")"
                    }
                }
            }
            manager.stopUpdatingLocation()

        }
func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print("Error \(error)")
}
}
