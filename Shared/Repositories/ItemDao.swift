//
//  ItemDao.swift
//  Sample
//
//  Created by Shydow Lee on 7/5/21.
//

import Foundation

struct ItemDao {
    static let shared = ItemDao()
    
    private var dataManager: CoreDataManager
    
    private init() {
        dataManager = CoreDataManager.preview
    }
    
    func loadAll() -> [Item] {
        let context = dataManager.container.viewContext
        let request = ManagedItem.fetchRequest()
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        do {
            let result = try context.fetch(request)
            return result.map{ $0.transform() }
        } catch {
            return []
        }
    }
}
