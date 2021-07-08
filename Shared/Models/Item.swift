//
//  Item.swift
//  Sample (iOS)
//
//  Created by Shydow Lee on 7/5/21.
//

import Foundation

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var timestamp: Date = Date()
    
    var user: User
    
}
