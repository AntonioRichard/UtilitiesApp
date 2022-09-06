//
//  UserEntity+CoreDataClass.swift
//  
//
//  Created by Paul-Daniel DOBREA on 29.06.2022.
//
//

import Foundation
import CoreData

@objc(UserEntity)
public class UserEntity: NSManagedObject {

    class func addNewUser(age: Double, name: String, email: String, password: String) {
        guard let user = NSEntityDescription.insertNewObject(forEntityName: "UserEntity", into: CoreDataManager.shared.context) as? UserEntity else { return }
        user.age = age
        user.name = name
        user.email = email
        user.password = password
    }

    class func allUsers() -> [UserEntity] {
        let fetchRequest: NSFetchRequest<UserEntity>
        fetchRequest = UserEntity.fetchRequest()
        let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let ageSortDescriptor = NSSortDescriptor(key: "age", ascending: true)
        fetchRequest.sortDescriptors = [ageSortDescriptor, nameSortDescriptor]
        var objects = [UserEntity]()
        do {
            objects = try CoreDataManager.shared.context.fetch(fetchRequest)
        } catch {}
        return objects
    }

    class func deleteAll() {
        let users = allUsers()
        for user in users {
            CoreDataManager.shared.context.delete(user)
        }
        CoreDataManager.shared.saveContext()
    }

    class func getUser(withName name: String) -> UserEntity? {
        var user: UserEntity?
        let fetchRequest: NSFetchRequest<UserEntity>
        fetchRequest = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let objects = try CoreDataManager.shared.context.fetch(fetchRequest)
            user = objects.first
        } catch {}
        return user
    }

}
