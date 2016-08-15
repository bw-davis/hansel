//
//  Photo.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//

import Foundation
import CoreData
import CoreDataService


class Photo: NSManagedObject, NamedEntity {

    class var entityName: String {
        get {
            return "Photo"
        }
    }

}
