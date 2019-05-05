//
//  Note+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var title: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var updatedAt: NSDate?
    @NSManaged public var user: User?

}
