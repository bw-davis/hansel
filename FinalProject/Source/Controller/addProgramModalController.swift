//
//  addProgramModalController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import CoreData
import CoreDataService


class addProgramModalController: UITableViewController, UITextFieldDelegate {
    //@IBOutlet var addProgTableViewOutlet: UITableView!
    
    private var name: String?
    private var country: String?
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        let theName = name
        let theCountry = country
        do {
            try FeedingProgramService.sharedProgramService.createFeedingProgram(theName!, country: theCountry!)
        }
        catch let error {
            fatalError("Failed to add FeedingProgram: \(error)")
        }
    }
    
    let caseArray: Array<Program> = [Program.Name, Program.Country]
   
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
                    newName = "Feeding Program"
                }
            
            name = newName
        }
        else {
            var newCountry = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range, withString: string)
            if newCountry.isEmpty {
                newCountry = "Some Country"
            }
            country = newCountry
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
        else {
            countryTextField.resignFirstResponder()
        }
        return false
    }
    
    enum Program: CustomStringConvertible{
        case Name
        case Country
        
        internal var description: String {
            get {
                let result: String
                switch self {
                case .Name:
                    result = "Name:"
                case .Country:
                    result = "Country:"
                }
                return result
            }
        }
        
    }
}
