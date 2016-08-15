//
//  addRecordTableViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 8/14/16.
//
//

import UIKit
import CoreData
import CoreDataService

class addRecordTableViewController: UITableViewController, UITextFieldDelegate {
    
    private var weight: Double?
    private var notes: String?
    var selectedKid: Kid?
    
    @IBOutlet var weightTextFieldOutlet: UITextField!
    @IBOutlet var notesTextFieldOutlet: UITextField!
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var data: String
        switch textField {
        case weightTextFieldOutlet:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                weight = nil
            }
            else {
                weight = Double(data)
            }
        case notesTextFieldOutlet:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                notes = nil
            }
            else {
                notes = data
            }
        default:
            weight = nil
            notes = nil
        
        }
        return true
    }
}
