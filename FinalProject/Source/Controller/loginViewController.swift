//
//  loginViewController.swift
//  FinalProject
//
//  Created by Nathan Nichols on 10/3/16.
//
//

import UIKit

private let AccountPasswordKey = "AccountPasswordKey"


class loginViewController: UIViewController {
    
    func viewDidAppear() {
        //super.viewDidAppear()
        callAlert()
    }
    
    // MARK: Private
    private func callAlert() {
        
        let alertController = UIAlertController(title: "Please Login", message: "Enter your password", preferredStyle: .Alert)
        /*alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.secureTextEntry = true
            textField.placeholder = "Password"
            textField.autocapitalizationType = .None
            textField.autocorrectionType = .No
        }*/
        alertController.view.setNeedsLayout()
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Done", style: .Default, handler: { (action) in
            if let password = alertController.textFields?.first?.text where !password.isEmpty {
                self.storePassword(password, inKeychain: self.secureSwitch.on)
            }
            /*else {
             self.clearPassword()
             }*/
        }))
        print("I'm getting here!!!")
        self.presentViewController(alertController, animated: true, completion: nil)
        performSegueWithIdentifier("showFirstScreen", sender: self)
    }
    
    private func storePassword(password: String, inKeychain: Bool) {
        print("Simulator location: \(NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first)")
        
        if inKeychain {
            print("Storing password in the keychain.")
            if let passwordData = (password as NSString).dataUsingEncoding(NSUTF8StringEncoding) {
                KeychainService.sharedKeychainService.updatePasswordItemForAccount(AccountPasswordKey, withData: passwordData)
            }
            else {
                let alertController = UIAlertController(title: "Error storing password in keychain", message: nil, preferredStyle: .Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else {
            NSUserDefaults.standardUserDefaults().setObject(password, forKey: AccountPasswordKey)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    @IBOutlet private weak var secureSwitch: UISwitch!
}