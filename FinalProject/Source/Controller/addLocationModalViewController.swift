//
//  addLocationModalViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit

class addLocationsModalViewController: UIViewController {
    var selectedFeedingProgram: FeedingProgram?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Add Location"
    }
    
    var createdLocation: Location?
    @IBAction func savePressed(sender: UIBarButtonItem) {
        do {
            try createdLocation = LocationService.sharedLocationService.createLocation("Djibouti", longitude: 10, latitude: 10)
            //try LocationService.sharedLocationService.createLocation("Another Place", longitude: 30.0, latitude: 30.0)
        }
        catch let error {
            fatalError("Failed to add Location: \(error)")
        }
        performSegueWithIdentifier("UnwindSegue", sender: self)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindSegue" {
            let locationListViewController = segue.destinationViewController as! locationsViewController
            locationListViewController.createdLocation = createdLocation
        }
        
    }
}
