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
    private var date: NSDate
    var selectedKid: Kid?
    var createdRecord: FeedingRecord?
    
    @IBOutlet var weightTextFieldOutlet: UITextField!
    @IBOutlet var notesTextFieldOutlet: UITextField!
    
    @IBAction func saveButtonPressed(sender: UIButton) {
        appendNotes()
        guard let theWeight = weight else {
            let alertController = UIAlertController(title: "Save Failed", message: "The weight field is blank", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                // Dismiss is automatic
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        do {
            try createdRecord = FeedingRecordService.sharedFeedingRecordService.createFeedingRecord(theWeight, date: date, notes: notes, kid: selectedKid!){}
            
        }
        catch let error {
            fatalError("Failed to add Record: \(error)")
        }
        
        
        performSegueWithIdentifier("RecordUnwindSegue", sender: self)
    }
    private func appendNotes(){
        if let someKid = selectedKid {
            if let someNotes = notes {
                //let theDay = createdRecord?.day as! Day
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateStyle = .MediumStyle
                dateFormatter.timeStyle = .NoStyle
                let someDate = dateFormatter.stringFromDate(date)
                if someKid.notes == nil {
                    someKid.notes = someDate + ": " + someNotes + "\n"
                    //someKid.notes = "-\(theDay.dateTime!): " + someNotes + "\n"
                }
                else {
                    someKid.notes? += someDate + ": " + someNotes + "\n"
                    //someKid.notes? += "-\(theDay.dateTime!): " + someNotes + "\n"
                }
            }
            else {
                someKid.notes = nil
            }
        }
        //CoreDataService.sharedCoreDataService.saveRootContext({})
    }
    required init!(coder aDecoder: NSCoder) {
        let now = NSDate()
        date = now
        
        super.init(coder: aDecoder)
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
