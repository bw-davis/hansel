//
//  kidDetailViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 8/9/16.
//
//

import UIKit
import CoreData
import CoreDataService
import MobileCoreServices

class kidDetailViewController: UITableViewController,  NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private var fetchedResultsController: NSFetchedResultsController? = nil
    private var picture: UIImage?
    var selectedKid: Kid?
    
    @IBOutlet var ageLabelOutlet: UILabel!
    @IBOutlet var heightLabelOutlet: UILabel!
    @IBOutlet var weightLabelOutlet: UILabel!
    @IBOutlet var notesLabelOutlet: UITextView!
    @IBOutlet var imageViewOutlet: UIImageView!
    @IBOutlet var tableViewOutlet: UITableView!
    
    @IBAction func addRecordCancelled(sender: UIStoryboardSegue) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let someKid = selectedKid {
            navigationItem.title = "\(someKid.firstName!) \(someKid.lastName!)"
            ageLabelOutlet.text = "\(someKid.age!)"
            heightLabelOutlet.text = "\(someKid.height!)"
            weightLabelOutlet.text = "\(Double(someKid.weight!))"
            
            if let someNotes = selectedKid?.notes {
                notesLabelOutlet.hidden = false
                notesLabelOutlet.text = someNotes
            }
            else {
                notesLabelOutlet.hidden = true
            }
            if let picture = someKid.firstPhoto as? Photo {
                imageViewOutlet.image = UIImage(data: picture.data!, scale: 1.0)
            }
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddRecordSegue" {
            let navViewController = segue.destinationViewController as! UINavigationController
            let recordViewController = navViewController.topViewController as! addRecordTableViewController
            recordViewController.selectedKid = selectedKid
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableViewOutlet.reloadData()
    }
    
    
}
