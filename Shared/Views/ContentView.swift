//
//  ContentView.swift
//  Shared
//
//  Created by Shydow Lee on 7/5/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    
    @State var showForm: Bool = false
    
    var body: some View {
        NavigationView {
            List(store.state.items) { item in
                Text(item.id)
                    .onTapGesture {
                        store.dispatch(.delete(id: item.id))
                    }
            }
            .navigationTitle("List")
            .navigationBarItems(trailing: Button(action: {
                showForm.toggle()
            }, label: {
                Image(systemName: "plus.circle")
            }))
            .sheet(isPresented: $showForm) {
                AddView(showForm: $showForm)
            }
        }
    }
}

struct AddView: View {
    @EnvironmentObject var store: AppStore
    
    @Binding var showForm: Bool
    
    var body: some View {
        Button("Add") {
            store.dispatch(.save(item: Item()))
            self.showForm = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppStore.preview)
    }
}
