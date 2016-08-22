//
//  kidsViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import CoreData
import CoreDataService

class kidsViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
    private var fetchedResultsController: NSFetchedResultsController? = nil
    var selectedLocation: Location?
    var createdKid: Kid?
    
    @IBOutlet var tableViewOutlet: UITableView!
    @IBAction func kidModalCancelled(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResultsController()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableViewOutlet.indexPathForSelectedRow {
            tableViewOutlet.deselectRowAtIndexPath(selectedIndexPath, animated: false)
        }
    }
    private func setupResultsController() {
        if let someLocation = selectedLocation, let resultsController = KidService.sharedKidService.fetchedResultsControllerForKidsWithDelegate(self, location: someLocation) {
            
            fetchedResultsController = resultsController
        }
        else {
            print("Setting up the results controller didn't work...")
            fetchedResultsController = nil
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KidCell", forIndexPath: indexPath) as! kidTableViewCell
        
        let kid = fetchedResultsController?.objectAtIndexPath(indexPath) as! Kid
        cell.kidNameLabelOutlet?.text = " \(kid.firstName!)  \(kid.lastName!)"
        if let somePicture = kid.firstPhoto as? Photo {
            cell.kidImageOutlet?.image = UIImage(data: somePicture.data!, scale: 1.0)
        }
        
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KidDetailSegue" {
            if let indexPath = tableViewOutlet.indexPathForSelectedRow, let selectedKid = fetchedResultsController?.objectAtIndexPath(indexPath) as? Kid {
                let kidDetailController = segue.destinationViewController as! kidDetailViewController
                kidDetailController.selectedKid = selectedKid
                
                tableViewOutlet.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
        else if segue.identifier == "AddKidSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addKidViewController = navigationController.topViewController as! addKidModalViewController
            addKidViewController.selectedLocation = selectedLocation
        }
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableViewOutlet.reloadData()
    }
}
