//
//  kidsViewController.swift
//  FinalProject
//
//  Created by Mac Owner on 7/31/16.
//
//

import UIKit

class kidsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableViewOutlet: UITableView!
    @IBAction func kidModalCancelled(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    @IBAction func kidModalFinished(sender: UIStoryboardSegue) {
        // Intentionally left blank
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("KidCell", forIndexPath: indexPath)
        cell.textLabel?.text = "A Kid"
        
        return cell
    }
}
