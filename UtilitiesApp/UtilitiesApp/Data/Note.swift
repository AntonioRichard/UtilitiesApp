//
//  Note.swift
//  UtilitiesApp
//
//  Created by Antonio - Raul RICHARD on 25.05.2022.
//

import Foundation

class Note: Codable {
    var title: String = ""
    var content: String = ""
}

//MARK: - Equatable

extension Note: Equatable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        return lhs.title == rhs.title
    }
}
