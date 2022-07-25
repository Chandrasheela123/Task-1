//
//  ViewController.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 12/07/22.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    
    let uerDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if NetworkMonitor.shared.isConnected  {
            
            print("you are connected")
            //showAlert(title: "You are connected to internet", msg: "")
        }
        else
        {
            print("you are connecting......")
            //showAlert(title: "Check your internet connection", msg: "")
        }
        
        if UserDefaults.standard.bool(forKey: "IsUserLoggedIn") == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomePageVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.usernameTxt.addBottomBorderLine(color: .gray, width: 1.0)
        self.passwordTxt.addBottomBorderLine(color: .gray, width: 1.0)
    }

    @IBAction func signUpBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpVC
        show(vc, sender: self)
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let username = usernameTxt.text ?? ""
        let password = passwordTxt.text ?? ""
        
        Auth.auth().signIn(withEmail: username, password: password)
        
        { [self] res, err in
        
            if err != nil {
                if username.isEmpty == true && password.isEmpty == true
                {
                self.showAlert(title: "", msg: "Enter Login Details")
                }
                else if username.isEmpty == false && password.isEmpty == true
                {
                    self.showAlert(title: "", msg: "Enter your password")
                }
                else if username.isEmpty == true && password.isEmpty == false
                {
                    self.showAlert(title: "", msg: "Enter your email")
                }
                else
                {
                    self.showAlert(title: "", msg: "User not found")
                }
            }
            else
            {
                if username.isEmpty == false && password.isEmpty == false {
                    
                    UserDefaults.standard.set(true, forKey: "IsUserLoggedIn")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "home") as! HomePageVC
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("User logged in...")
                   
                    
                }
            }
        }
    }
    @IBAction func login(_ sender: Any) {
        
    }
}

extension UIView {
    
    func addBottomBorderLine(color : UIColor, width: CGFloat) {
        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        
        self.layer.addSublayer(bottomBorderLine)
    }
}

