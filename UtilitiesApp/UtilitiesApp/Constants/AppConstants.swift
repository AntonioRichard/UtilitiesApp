//
//  AppConstants.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 22.06.2022.
//

import Foundation

enum UserDefaultsKeys: String {
    case currentUser = "currentlyLoggedInUser"
    case allUsers = "allUsesList"
}

enum SignupErrorMessage: String {
    case emptyField = "Please fill every field"
    case invalidEmail = "Please enter a valid email address"
    case passwordMismatch = "Passwords don't match"
    case emailInUse = "Email is already in use"
}

enum LoginErrorMessage: String {
    case emptyField = "Please fill every field"
    case wrongPassword = "Wrong password"
    case userDoesNotExist = "User does not exist"
}
