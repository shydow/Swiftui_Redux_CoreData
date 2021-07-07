//
//  Item+Redux.swift
//  Sample (iOS)
//
//  Created by Shydow Lee on 7/5/21.
//

import Foundation

typealias AppStore = Store<AppState, AppAction>

extension AppStore {
  static var preview: AppStore {
      let result = AppStore(
      initial: AppState(),
      reducer: appReducer,
      middlewares: [])
      
      result.dispatch(.all)
      
      return result
  }
}

enum AppAction {
    case all
    case save(item: Item)
    case delete(id: String)
}

struct AppState {
    var items: [Item] = []
}

let appReducer: Reducer<AppState, AppAction> = { state, action in
    var result = state
    switch action {
    case .all:
        result.items = ItemDao.shared.loadAll()
    case .save(let item):
        result.items.append(item)
    case .delete(let id):
        if let index = result.items.firstIndex(where: { $0.id == id }) {
            result.items.remove(at: index)
        }
    }
    return result
}
