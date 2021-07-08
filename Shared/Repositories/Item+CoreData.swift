//
//  Item+CoreData.swift
//  Sample
//
//  Created by Shydow Lee on 7/7/21.
//

import Foundation

extension ManagedItem {
    func getItem() -> Item {
        let id = self.id
        let timestamp = self.timestamp
        let user = self.user?.getUser()
        
        return Item(id: id!, timestamp: timestamp!, user: user!)
    }
}
