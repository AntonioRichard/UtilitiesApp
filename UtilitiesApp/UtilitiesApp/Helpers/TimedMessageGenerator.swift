//
//  TimedMessageGenerator.swift
//  UtilitiesApp
//
//  Created by Paul-Daniel DOBREA on 23.06.2022.
//

import Foundation

struct TimedMessageGenerator {

    private let hour = Calendar.current.component(.hour, from: Date())

    func getCurrentMessage(withName name: String) -> String {
        var message: String
        switch hour{
        case 6..<12: message = "Good morning, \(name)"
        case 12..<17: message = "Good afternoon, \(name)"
        case 17..<22: message = "Good evening, \(name)"
        default: message = "Good night, \(name)"
        }
        return message
    }

    static func currentMessage(forName name: String) -> String {
        let generator = TimedMessageGenerator()
        return generator.getCurrentMessage(withName: name)
    }
    
}
