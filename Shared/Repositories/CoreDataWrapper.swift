//
//  CoreDataWrapper.swift
//  Sample
//
//  Created by Shydow Lee on 7/15/21.
//

import Foundation
import CoreData

protocol CoreDataWrapper {
    associatedtype M
    associatedtype E: NSManagedObject
    static func transform(from model: M, context: NSManagedObjectContext) -> E
    
    static func transform(from entity: E) -> M
}

extension CoreDataWrapper {
    func save(model: M) {
        let context = CoreDataManager.shared.context
        
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func delete(id: String) {
        let context = CoreDataManager.shared.context
        let request = E.fetchRequest()
        request.predicate = NSPredicate(format: "id = %?", id)
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                context.delete(entity as! NSManagedObject)
            }
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func loadAll() -> [M] {
        let context = CoreDataManager.shared.context
        let request = E.fetchRequest()
        request.predicate = NSPredicate(format: "TRUEPREDICATE")
        var results: [M] = []
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                results.append(Self.transform(from: entity as! Self.E))
            }
        } catch {
            return []
        }
        
        return results
    }
    func load(by predicate: NSPredicate) -> [M] {
        let context = CoreDataManager.shared.context
        let request = E.fetchRequest()
        request.predicate = predicate
        var results: [M] = []
        
        do {
            let entities = try context.fetch(request)
            for entity in entities {
                results.append(Self.transform(from: entity as! Self.E))
            }
        } catch {
            return []
        }
        
        return results
    }
}
