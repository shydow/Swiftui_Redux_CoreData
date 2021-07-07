//
//  SampleApp.swift
//  Shared
//
//  Created by Shydow Lee on 7/5/21.
//

import SwiftUI

@main
struct SampleApp: App {
    let store = AppStore(
      initial: AppState(),
      reducer: appReducer,
      middlewares: [])
    
    init() {
      store.dispatch(.all)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
