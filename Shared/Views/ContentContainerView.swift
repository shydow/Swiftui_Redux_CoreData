//
//  ContentView.swift
//  Shared
//
//  Created by Shydow Lee on 7/5/21.
//

import SwiftUI

struct ContentContainerView: View {
    @EnvironmentObject var store: AppStore
    
    @State var showForm: Bool = false
    
    var body: some View {
        ContentView(showForm: $showForm, items: store.state.items, save: save, delete: delete).onAppear(perform: load)
    }
    
    private func load() {
        store.dispatch(.all)
    }
    
    private func save() {
        let user = User.create()
        
        store.dispatch(.save(item: Item(user: user)))
        self.showForm = false
    }
    
    private func delete(_ id: String) {
        store.dispatch(.delete(id: id))
    }
    
}

struct ContentView: View {
    @Binding var showForm: Bool
    
    var items: [Item]
    
    let save: () -> Void
    
    let delete: (_ id: String) -> Void
    
    var body: some View {
        NavigationView {
            List(items) { item in
                HStack {
                    Text(item.id)
                    Text(item.user.name)
                }
                    .onTapGesture {
                        delete(item.id)
                    }
            }
            .navigationTitle("List")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showForm.toggle()
                    }, label: {
                        Image(systemName: "plus.circle")
                    })
                }
            }
//            .navigationBarItems(trailing: Button(action: {
//                showForm.toggle()
//            }, label: {
//                Image(systemName: "plus.circle")
//            }))
            .sheet(isPresented: $showForm) {
                AddView(showForm: $showForm, save: save)
            }
        }
    }
}

struct AddView: View {
    @Binding var showForm: Bool
    
    var save: () -> Void
    
    var body: some View {
        Button("Add") {
            save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentContainerView()
    }
}
