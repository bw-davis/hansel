//
//  addLocationModalViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit
import CoreData
import CoreDataService
import MapKit
import CoreLocation

class addLocationsModalViewController: UIViewController, MKMapViewDelegate, NSFetchedResultsControllerDelegate, CLLocationManagerDelegate, UISearchBarDelegate, UITextFieldDelegate {
    var selectedFeedingProgram: FeedingProgram!
    var createdLocation: Location?
    var theLongitude: Double?
    var theLatitude: Double?
    var theName: String?
    var searchController: UISearchController!
    var annotation: MKAnnotation!
    var localSearchRequest: MKLocalSearchRequest!
    var localSearch: MKLocalSearch!
    var localSearchResponse: MKLocalSearchResponse!
    var error: NSError!
    var pointAnnotation: MKPointAnnotation!
    var pinAnnotationView: MKPinAnnotationView!
    let locationManager = CLLocationManager()
    
    @IBOutlet var mapViewOutlet: MKMapView!
    @IBOutlet var nameTextFieldOutlet: UITextField!
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        guard let someName = theName, let someLongitude = theLongitude, let someLatitude = theLatitude else {
            let alertController = UIAlertController(title: "Save Failed", message: "One or more fields are blank.", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) in
                // Dismiss is automatic
            }))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        do {
            try createdLocation = LocationService.sharedLocationService.createLocation(someName, longitude: someLongitude, latitude: someLatitude, feedingProgram: selectedFeedingProgram)
        }
        catch let error {
            fatalError("Failed to add Location: \(error)")
        }
        performSegueWithIdentifier("UnwindSegue", sender: self)
    }
    @IBAction func presentSearchBar(sender: UIButton){
        searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        presentViewController(searchController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapViewOutlet.showsUserLocation = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Add Location"
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        if mapViewOutlet.annotations.count != 0{
            annotation = mapViewOutlet.annotations[0]
            mapViewOutlet.removeAnnotation(annotation)
        }
        localSearchRequest = MKLocalSearchRequest()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        localSearch = MKLocalSearch(request: localSearchRequest)
/**************************************************
 **NEED TO REMEMBER TO FIX THE SELF IN THIS CLOSURE
 *************************************************/
        localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
            
            if localSearchResponse == nil{
                let alertController = UIAlertController(title: nil, message: "Place Not Found", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                return
            }
            self.pointAnnotation = MKPointAnnotation()
        
            self.pointAnnotation.title = searchBar.text
            self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
            
            
            self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
            self.mapViewOutlet.centerCoordinate = self.pointAnnotation.coordinate
            self.mapViewOutlet.addAnnotation(self.pinAnnotationView.annotation!)
            self.theLatitude = self.pointAnnotation.coordinate.latitude
            self.theLongitude = self.pointAnnotation.coordinate.longitude
        }
    }
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == nameTextFieldOutlet {
            var newName = (textField.text ?? "" as NSString).stringByReplacingCharactersInRange(range,  withString: string)
            if newName.isEmpty {
                newName = "Random Location"
            }
            theName = newName
        }
        return true
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        mapViewOutlet.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Location Manager Error: " + error.localizedDescription)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindSegue" {
            let locationListViewController = segue.destinationViewController as! locationsViewController
            locationListViewController.createdLocation = createdLocation
        }
        
    }
}
