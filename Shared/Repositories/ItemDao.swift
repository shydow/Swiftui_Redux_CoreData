//
//  ItemDao.swift
//  Sample
//
//  Created by Shydow Lee on 7/5/21.
//

import Foundation
import CoreData

struct ItemDao: CoreDataWrapper {
    typealias M = Item
    
    typealias E = ManagedItem
    
    static let shared = ItemDao()
    
    private init() { }
    
    static func transform(from entity: ManagedItem) -> Item {
        let user = User(id: (entity.user?.id)!, name: (entity.user?.name)!)
        
        return Item(id: entity.id!, timestamp: entity.timestamp!, user: user)
    }
    
    static func transform(from model: Item, context: NSManagedObjectContext) -> ManagedItem {
        let mUser = ManagedUser(context: context)
        mUser.id = model.user.id
        mUser.name = model.user.name
        
        let mItem = ManagedItem(context: context)
        mItem.id = model.id
        mItem.timestamp = model.timestamp
        mItem.user = mUser
        
        return mItem
    }
}
