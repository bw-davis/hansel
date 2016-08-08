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
    @IBOutlet var tableViewOutlet: UITableView!
     private var fetchedResultsController: NSFetchedResultsController? = nil
    @IBAction func kidModalCancelled(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    @IBAction func kidModalFinished(sender: UIStoryboardSegue) {
        fetchedResultsController = KidService.sharedKidService.fetchedResultsControllerForKidsWithDelegate(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = KidService.sharedKidService.fetchedResultsControllerForKidsWithDelegate(self)
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController?.sections?.count ?? 0
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KidCell", forIndexPath: indexPath)
        
        let kid = fetchedResultsController?.objectAtIndexPath(indexPath) as! Kid
        cell.textLabel?.text = kid.name
        
        return cell
    }

}
