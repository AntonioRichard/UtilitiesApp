//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Paul-Daniel DOBREA on 29.06.2022.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var age: Double
    @NSManaged public var name: String
    @NSManaged public var email: String
    @NSManaged public var password: String

}
