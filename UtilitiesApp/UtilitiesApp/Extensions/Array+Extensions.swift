//
//  Array+Extensions.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 22.06.2022.
//

import Foundation
import UIKit

extension Array where Element == User {

    mutating func addUserAndSave(user: User) {
        append(user)
        saveObjects(self, atKey: UserDefaultsKeys.allUsers.rawValue)
    }

}
