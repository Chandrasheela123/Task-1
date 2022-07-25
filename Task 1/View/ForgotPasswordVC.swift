//
//  ForgotPasswordVC.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 15/07/22.
//

import UIKit
import FirebaseAuth

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.emailTxt.bottomBorderLine(color: .gray, width: 1.0)
       
    }
    
    @IBAction func sendLinkBtn(_ sender: Any) {
        
        let email = emailTxt.text ?? ""

        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: emailTxt.text!) { (err) in
            if let error = err {
                
                if !email.validEmail(email)
                {
                
                self.showAlert(title: "Error", msg: error.localizedDescription)
                
            }
        }
            
            
            self.showAlert(title: "Email sent", msg: "Check your email and click on link to reset password")
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
    
    func bottomBorderLine(color : UIColor, width: CGFloat) {
        let bottomBorderLine = CALayer()
        bottomBorderLine.backgroundColor = color.cgColor
        bottomBorderLine.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        
        self.layer.addSublayer(bottomBorderLine)
    }
}

extension String {
    
       
    func validEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
