//
//  ItemDao.swift
//  Sample
//
//  Created by Shydow Lee on 7/5/21.
//

import Foundation

struct ItemDao {
    static let shared = ItemDao()
    
    private init() {
        
    }
    
    func loadAll() -> [Item] {
        var result: [Item] = []
        for _ in 0 ... 10 {
            result.append(Item())
        }
        return result
    }
}
