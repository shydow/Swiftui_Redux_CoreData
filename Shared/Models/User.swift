//
//  User.swift
//  Sample
//
//  Created by Shydow Lee on 7/7/21.
//

import Foundation

struct User {
    var id: String = UUID().uuidString
    var name: String
    
    static let sampleUsers: [User] = [ User(name: "1"), User(name: "2"), User(name: "3")]
    static func create() -> User {
        let user = sampleUsers[Int.random(in: 0..<3)]
        return user
    }
}
