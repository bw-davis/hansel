//
//  AppDelegate.swift
//  FinalProject
//
//  Created by Charles Augustine.
//
//


import UIKit
import Firebase


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
	func application(application: UIApplication,
	                 didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        
// start test code
        
                let myRootRef = FIRDatabase.database().reference()

                // Write data to Firebase
                myRootRef.setValue("Hi from Nathan :) I just set some data in the backend.")
                
                // Read data and react to changes
                myRootRef.observeEventType(.Value, withBlock: {
                    snapshot in
                    print("\(snapshot.key) -> \(snapshot.value)")
                })
        //        end test code
        
        
        
		return true
	}
}