//
//  HomePageVC.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 13/07/22.
//

import UIKit
import FirebaseAuth

class HomePageVC: UIViewController {
    
  
    @IBOutlet weak var lbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func signout(){
        
        UserDefaults.standard.set(false, forKey: "IsUserLoggedIn")
       // self.navigationController?.popToRootViewController(animated: true)
        let vc = storyboard?.instantiateViewController(withIdentifier: "login") as! ViewController
        show(vc, sender: self)
        
        
    }
    
    @IBAction func signOutBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (_) in
            self.signout()
            
        }))
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        present(alert,animated: true, completion: nil)
        
        
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
