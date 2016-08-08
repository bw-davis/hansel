//
//  FeedingProgramController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import CoreData
import CoreDataService

class FeedingProgramController: UIViewController, UITableViewDataSource, NSFetchedResultsControllerDelegate  {
    private var fetchedResultsController: NSFetchedResultsController? = nil
    @IBOutlet var tableViewOutlet: UITableView!
    @IBAction func programModalCancelled(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    @IBAction func programModalFinished(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = FeedingProgramService.sharedProgramService.fetchedResultsControllerForProgramsWithDelegate(self)
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedingProgramCell", forIndexPath: indexPath)
        
        let program = fetchedResultsController?.objectAtIndexPath(indexPath) as! FeedingProgram
        cell.textLabel?.text = program.name
        
        return cell
    }
}
