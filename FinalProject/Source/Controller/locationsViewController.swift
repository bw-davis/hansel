//
//  locationsViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import CoreData
import CoreDataService

class locationsViewController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    private var fetchedResultsController: NSFetchedResultsController? = nil
    var selectedFeedingProgram: FeedingProgram?
    var createdLocation: Location? 
    
    @IBOutlet var tableViewOutlet: UITableView!
    @IBAction func locationModalCancelled(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupResultsController()
       
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let feedingProgram = selectedFeedingProgram {
            navigationItem.title = "\(feedingProgram.name!) Locations"
            if let location = createdLocation {
                print("The Locations name is: \(createdLocation?.name)")
                print("The Feeding Programs name is: \(selectedFeedingProgram!.name)")
                location.feedingProgram = feedingProgram
            }
        }
        if let selectedIndexPath = tableViewOutlet.indexPathForSelectedRow {
            tableViewOutlet.deselectRowAtIndexPath(selectedIndexPath, animated: false)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "KidListSegue" {
            if let indexPath = tableViewOutlet.indexPathForSelectedRow, let selectedLocation = fetchedResultsController?.objectAtIndexPath(indexPath) as? Location {
                let kidListViewController = segue.destinationViewController as! kidsViewController
                kidListViewController.selectedLocation = selectedLocation
                
                tableViewOutlet.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
        else if segue.identifier == "AddLocationSegue" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let addLocationViewController = navigationController.topViewController as! addLocationsModalViewController
            addLocationViewController.selectedFeedingProgram = selectedFeedingProgram
        }
    }
    
    private func setupResultsController() {
        if let someProgram = selectedFeedingProgram, let resultsController = LocationService.sharedLocationService.fetchedResultsControllerForLocationWithDelegate(self, feedingProgram: someProgram) {
            fetchedResultsController = resultsController
        }
        else {
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
        let cell = tableView.dequeueReusableCellWithIdentifier("LocationNameCell", forIndexPath: indexPath)
        
        let location = fetchedResultsController?.objectAtIndexPath(indexPath) as! Location
        cell.textLabel?.text = location.name
        
        return cell
    }
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableViewOutlet.reloadData()
    }


}
