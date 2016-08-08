//
//  feedingProgramNamedEntityExtension.swift
//  FinalProject
//
//  Created by Mac Owner on 8/6/16.
//
//

import CoreDataService
import Foundation


extension FeedingProgram: NamedEntity {
    // MARK: Properties (Class, NamedEntity)
    class var entityName: String {
        get {
            return "FeedingProgram"
        }
    }
}
