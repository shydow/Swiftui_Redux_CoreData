//
//  User+CoreData.swift
//  Sample
//
//  Created by Shydow Lee on 7/7/21.
//

import Foundation

extension ManagedUser {
    func getUser() -> User {
        let id = self.id
        let name = self.name
        
        return User(id: id!, name: name!)
    }
    
}
