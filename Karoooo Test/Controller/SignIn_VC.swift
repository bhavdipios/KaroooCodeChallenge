//
//  SignIn_VC.swift
//  Karoooo Test
//
//  Created by Sevenbits on 27/08/22.
//

import UIKit
import TransitionButton

class SignIn_VC: UIViewController {
    
    @IBOutlet var viewBack: UIView!
    @IBOutlet var viewPhone: UIView!
    @IBOutlet var txtUser: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtPhone: UITextField!
    @IBOutlet var btnSignIn: TransitionButton!
    @IBOutlet var lblCountryCode: UILabel!
    @IBOutlet var imgCountry: UIImageView!
    
    
    var strSelectedCountry = "+1"

    var db:DBHelper = DBHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Add text filed border & sert default value
        viewBack.dropShadow(color: .gray, opacity: 0.4, offSet: CGSize.init(width: 5, height: 5), radius: 100, scale: true)
        viewBack.layer.cornerRadius = 15
        txtUser.setborder()
        txtPassword.setborder()
        txtUser.setLeftPaddingPoints(40, imgname: "user_icon")
        txtPassword.setLeftPaddingPoints(40, imgname: "password_icon")
        viewPhone.setborderView()
        btnSignIn.setborderButton()
        lblCountryCode.text = strSelectedCountry
        imgCountry.image = UIImage(named: "DefaultUS")
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.UpdateLocation(_:)),
                                               name: .didFetchLocationNotification, object:nil)
        
 
    }
    
    //MARK: Update Current Country Details
    @objc
    private func UpdateLocation(_ notification: Notification) {
        guard let countryResponseModel = notification.object as? CountriesResponseModelElement else { return }
        lblCountryCode.text = countryResponseModel.dialCode
        strSelectedCountry = countryResponseModel.dialCode
        imgCountry.setImage(with: countryResponseModel.filePath)
        NotificationCenter.default.removeObserver(self, name: .didFetchLocationNotification, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OpenCountry" {
            guard let countryVC = segue.destination as? CountryCodeVC else { return }
            countryVC.delegate = self
        }
    }
    
    // MARK: - IBAction
  
    @IBAction func btnSignIn(_ button: TransitionButton) {
 
            button.startAnimation() // 2: Then start the animation when the user tap the button
            let qualityOfServiceClass = DispatchQoS.QoSClass.background
            let backgroundQueue = DispatchQueue.global(qos: qualityOfServiceClass)
            backgroundQueue.async(execute: {
                
                sleep(4) // 3: Do your networking task or background work here.
                
                DispatchQueue.main.async(execute: { [self] () -> Void in
                   
                    // Implement validation logic for the logic the user
                    let isValid = self.db.isValidUser(email: self.txtUser.text!, password: self.txtPassword.text!, phone: strSelectedCountry + self.txtPhone.text!)
                    
                    if(isEmpty(value: self.txtUser.text ?? "")){
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                        })
                        let alert = UIAlertController(title: "Alert", message: "Please enter email", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else if(isEmpty(value: self.txtPassword.text ?? "")){
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                        })
                        let alert = UIAlertController(title: "Alert", message: "Please enter password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else if(isEmpty(value: self.txtPhone.text ?? "")){
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                            
                        })
                        let alert = UIAlertController(title: "Alert", message: "Please enter phone", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else if(isValidEmailAddress(value: self.txtUser.text ?? "") == false){
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                        })
                        let alert = UIAlertController(title: "Alert", message: "Please enter valid email", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else if (isValidPhone(value: (self.strSelectedCountry + self.txtPhone.text!) ) == false) {
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                        })
                        let alert = UIAlertController(title: "Alert", message: "Please enter valid phone", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                    }else if isValid == false {
                        button.stopAnimation(animationStyle: .shake, completion: {
                            button.setborderButton()
                            button.setTitle("Sign In", for: .normal)
                        })
                        let alert = UIAlertController(title: "Alert", message: "Invalid email or password", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                        }))
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        button.stopAnimation(animationStyle: .expand, completion: {
                            let vc = self.storyboard!.instantiateViewController(withIdentifier: "UserList_VC") as! UserList_VC
                            
                            self.navigationController?.pushViewController(vc, animated: false)
                        })
                    }
                    
                    
                    
                })
            })
                
    }
    

}
//MARK: CountryCodeDelegate
extension SignIn_VC: CountryCodeDelegate {

    func didselectCounty(model: CountriesResponseModelElement) {
        lblCountryCode.text = model.dialCode
        imgCountry.setImage(with: model.filePath)
        strSelectedCountry = model.dialCode
    }

}
