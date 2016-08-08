//
//  addKidModalViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit

class addKidModalViewController: UITableViewController, UITextFieldDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    private var name: String?
    private var age: Double?
    private var height: Double?
    private var weight: Double?
    let caseArray: Array<KidInfo> = [KidInfo.Name, KidInfo.Age, KidInfo.Height, KidInfo.Weight]
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        let theName = name
        let theAge = age
        let theHeight = height
        let theWeight = weight
        do {
            try KidService.sharedKidService.createKid(theName!, age: theAge!, height: theHeight!, weight: theWeight!)
        }
        catch let error {
            fatalError("Failed to add Kid: \(error)")
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        nameTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
                super.viewWillDisappear(animated)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextField {
            var newName = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if newName.isEmpty {
                newName = "A Random Kid"
            }
            name = newName
        }
        else if textField == ageTextField {
            var newAge = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if newAge.isEmpty {
                newAge = "12"
            }
            age = Double(newAge)
        }
        else if textField == heightTextField {
            var newHeight = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if newHeight.isEmpty {
                newHeight = "50"
            }
            height = Double(newHeight)
        }
        else {
            var newWeight = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if newWeight.isEmpty {
                newWeight = "100"
            }
            weight = Double(newWeight)
        }
        return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
        }
        else if textField == ageTextField {
            ageTextField.resignFirstResponder()
        }
        else if textField == heightTextField {
            heightTextField.resignFirstResponder()
        }
        else {
            weightTextField.resignFirstResponder()
        }
        return false
    }
    
    enum KidInfo: CustomStringConvertible{
        case Name
        case Age
        case Height
        case Weight
        
        internal var description: String {
            get {
                let result: String
                switch self {
                case .Age:
                    result = "Age:"
                case .Height:
                    result = "Height:"
                case .Name:
                    result = "Name:"
                case .Weight:
                    result = "Weight:"
                }
                return result
            }
        }
    }
}
