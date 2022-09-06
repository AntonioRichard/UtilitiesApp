//
//  User.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 18.05.2022.
//

import Foundation
import UIKit

class User: Codable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
}

//MARK: - Equatable

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }
}

//MARK: - Getters

extension User {

    static var current: User? {
        return loadObject(fromUserDefaultsKey: UserDefaultsKeys.currentUser.rawValue)
    }

    static var allUsers: [User] {
        return loadObjects(fromUserDefaultsKey: UserDefaultsKeys.allUsers.rawValue)
    }
}

//MARK: - Validators

extension User {

    func isDuplicate() -> Bool {
        return User.allUsers.contains(self)
    }
    
    func retrieveName() {
        if let foundUser = User.allUsers.first(where: { user in
            user == self
        }){
            self.name = foundUser.name
        }
    }

    func credentialsAreValid() -> Bool {
        let users = User.allUsers
        let filteredUsers = users.filter { user in
            return user.email == email && user.password == password
        }
        return filteredUsers.first != nil
    }
}

//MARK: - Data management

extension User {

    func save(addToAllUsers: Bool) {
        saveObject(self, atKey: UserDefaultsKeys.currentUser.rawValue)
        if addToAllUsers {
            var array = User.allUsers
            array.addUserAndSave(user: self)
        }
    }

    static func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.currentUser.rawValue)
    }
}

//MARK: - Notes functionality

extension User {

    var notesKey: String{
        return "notes_" + self.email
    }

    var currentUserNotes: [Note] {
        get{
        var notes = [Note]()
        if let notesData = UserDefaults.standard.value(forKey: notesKey) as? Data {
            do {
                let objects = try JSONDecoder().decode([Note].self, from: notesData)
                notes = objects
            } catch {}
        }
        return notes
        }
        set {
            // remove note ? ? ? ? ? ?
        }
    }

    func addNote(_ note: Note){
        var currentNotes = currentUserNotes

        if let index = currentNotes.firstIndex(of: note){
            currentNotes[index] = note
        }else{
            currentNotes.append(note)
        }
        do {
            let noteData = try JSONEncoder().encode(currentNotes)
            UserDefaults.standard.set(noteData, forKey: notesKey)
        } catch {}
    }

}
