//
//  User+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by QDSG on 2019/5/5.
//  Copyright © 2019 unitTao. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var first: String?
    @NSManaged public var last: String?
    @NSManaged public var uuid: String?
    @NSManaged public var notes: NSSet?

}
