//
//  SignUpVC.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 12/07/22.
//

import UIKit
import FirebaseAuth

class SignUpVC: UIViewController {
    
    let credential = LoginVM()

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        let email = UIImage(named: "email1")!
//        addleftimage(textfield: usernameTxt, img: email)
//        
//        let password = UIImage(named: "password")!
//        addleftimage(textfield: passwordTxt, img: password)
    }
    
//    func addleftimage(textfield: UITextField, img: UIImage) {
//
//        let leftimg = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 5, height: 20))
//        leftimg.image = img
//        textfield.leftView = leftimg
//        textfield.leftViewMode = .always
//    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.usernameTxt.addBottomLine(color: .gray, width: 1.0)
        self.passwordTxt.addBottomLine(color: .gray, width: 1.0)
        self.emailTxt.addBottomLine(color: .gray, width: 1.0)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
        
        let username = usernameTxt.text ?? ""
        let password = passwordTxt.text ?? ""
        let email = emailTxt.text ?? ""
        
        
        if !email.isValidEmail(email){
            
            showAlert(title: "Please enter valid email id", msg: "")
        }
        
        else if !password.isValidPassword(){
            
            showAlert(title: "Please enter valid password", msg: "Your password must be at least 8 characters long, contain at least one number,special charecter and have a combination of uppercase ,lowercase letters")
        }
        
        else
        {
            
            Auth.auth().createUser(withEmail: email, password: password) { result, err in
                if err == nil {
                    print("No error")
                    
                    
                    self.credential.saveDetails(email: email, password: username)
                    //DBUtility.instance.saveUserDetails(email: email, username: username)
                }
            }
            
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
            show(vc, sender: self)
            
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

extension UIView {
    
    func addBottomLine(color : UIColor, width: CGFloat) {
        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        
        self.layer.addSublayer(bottomBorderLine)
    }
}

extension String {
    
       
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isValidPassword() -> Bool {
        
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
    

}
