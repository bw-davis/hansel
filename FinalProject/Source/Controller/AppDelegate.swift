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
		return true
	}

	// MARK: Properties
	
}