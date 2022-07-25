//
//  Utility.swift
//  Task 1
//
//  Created by Chandrasheela Hotkar on 12/07/22.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title: String, msg : String){
        
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        present(alertVC, animated: false, completion: nil)
        
        
    }
}
