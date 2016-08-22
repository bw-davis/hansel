//
//  addKidModalViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import MobileCoreServices

class addKidModalViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var name: String?
    private var lastName: String?
    private var age: Double?
    private var height: Double?
    private var weight: Double?
    private var picture: UIImage?
    private var createdKid: Kid?
    
    var selectedLocation: Location!
    
    @IBOutlet var addImageLabelOutlet: UILabel!
    @IBOutlet var addImageButtonOutlet: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var imageViewOutlet: UIImageView!
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        guard let theName = name, let theLastName = lastName, let theAge = age, let theHeight = height, let theWeight = weight/*, let thePicture = picture*/ else {
            let alertController = UIAlertController(title: "Save Failed", message: "One or more fields are blank.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                // Dismiss is automatic
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        if let thePicture = picture {
            do {
                try createdKid = KidService.sharedKidService.createKid(theName, lastName: theLastName, age: theAge, height: theHeight, weight: theWeight, picture: thePicture, location: selectedLocation){}
            }
            catch let error {
                fatalError("Failed to add Kid: \(error)")
            }
        }
        else {
            do {
                try createdKid = KidService.sharedKidService.createKid(theName, lastName: theLastName, age: theAge, height: theHeight, weight: theWeight, picture: nil, location: selectedLocation){}
            }
            catch let error {
                fatalError("Failed to add Kid: \(error)")
            }
        }
        performSegueWithIdentifier("KidUnwindSegue", sender: self)
    }
    @IBAction func addPhoto(sender: UIButton) {
        if picture == nil {
            let alertController = UIAlertController(title: nil, message: "Pick Image Source", preferredStyle: .ActionSheet)
            
            let checkSourceType = { (sourceType: UIImagePickerControllerSourceType, buttonText: String) -> Void in
                if UIImagePickerController.isSourceTypeAvailable(sourceType) {
                    alertController.addAction(UIAlertAction(title: buttonText, style: .Default, handler: self.imagePickerControllerSourceTypeActionHandlerForSourceType(sourceType)))
                }
            }
            checkSourceType(.Camera, "Camera")
            checkSourceType(.PhotoLibrary, "Photo Library")
            checkSourceType(.SavedPhotosAlbum, "Saved Photos Album")
            
            if !alertController.actions.isEmpty {
                alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    private func imagePickerControllerSourceTypeActionHandlerForSourceType(sourceType: UIImagePickerControllerSourceType) -> (action: UIAlertAction) -> Void {
        return { (action) in
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            imagePickerController.mediaTypes = [kUTTypeImage as String]
            imagePickerController.allowsEditing = true
            
            self.presentViewController(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            picture = image
        }
        else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            picture = image
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var data: String
        switch textField {
        case nameTextField:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                name = nil
            }
            else {
                name = data
            }
        case lastNameTextField:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                lastName = nil
            }
            else {
                lastName = data
            }
        case ageTextField:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                age = nil
            }
            else {
                age = Double(data)
            }
        case heightTextField:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                height = nil
            }
            else {
                height = Double(data)
            }
        case weightTextField:
            data = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if data.isEmpty {
                weight = nil
            }
            else {
                weight = Double(data)
            }
        default:
            name = nil
            age = nil
            height = nil
            weight = nil
        }
                return true
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == nameTextField {
            nameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        }
        else if textField == lastNameTextField {
            lastNameTextField.resignFirstResponder()
            ageTextField.becomeFirstResponder()
        }
        else if textField == ageTextField {
            ageTextField.resignFirstResponder()
            heightTextField.becomeFirstResponder()
        }
        else if textField == heightTextField {
            heightTextField.resignFirstResponder()
            weightTextField.becomeFirstResponder()
        }
        else if textField ==  weightTextField {
            weightTextField.resignFirstResponder()
        }
        return false
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KidUnwindSegue" {
            let kidListViewController = segue.destinationViewController as! kidsViewController
            kidListViewController.createdKid = createdKid
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        addImageLabelOutlet.hidden = false
        if let somePicture = picture {
            imageViewOutlet.image = somePicture
            addImageLabelOutlet.hidden = true
            addImageButtonOutlet.hidden = true
        }
        
    }
}
