//
//  Item+CoreData.swift
//  Sample
//
//  Created by Shydow Lee on 7/7/21.
//

import Foundation

extension ManagedItem {
    func transform() -> Item {
        return Item(id: self.id!, timestamp: self.timestamp!)
    }
    
    
}
