//
//  ShoppingListView.swift
//  Juicies
//
//  Created by Brianna Lee on 5/6/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct ShoppingListView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(
        entity: ShoppingListItem.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \ShoppingListItem.updatedAt, ascending: false)
        ],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: true))
    ) var completeItems: FetchedResults<ShoppingListItem>
    
    @FetchRequest(
        entity: ShoppingListItem.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "isComplete == %@", NSNumber(value: false))
    ) var incompleteItems: FetchedResults<ShoppingListItem>
    
    func addShoppingListItem() {
        let newShoppingListItem = ShoppingListItem(context: context)
        newShoppingListItem.id = UUID().uuidString
        newShoppingListItem.isComplete = false
        newShoppingListItem.name = ""
        newShoppingListItem.quantity = 1
        newShoppingListItem.createdAt = Date()
        newShoppingListItem.updatedAt = Date()
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func deleteIncomplete(at offsets: IndexSet) {
        for index in offsets {
            if let incompleteItem = incompleteItems.first(where: {$0 == incompleteItems[index]}) {
                context.delete(incompleteItem)
                do {
                    try context.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
                return
            }
        }
    }
    
    func deleteComplete(at offsets: IndexSet) {
        for index in offsets {
            if let completedItem = completeItems.first(where: {$0 == completeItems[index]}) {
                context.delete(completedItem)
                do {
                    try context.save()
                } catch {
                    fatalError(error.localizedDescription)
                }
                return
            }
        }
    }
    
    #if !os(watchOS)
    var body: some View {
        NavigationView {
            List {
                Button(action: addShoppingListItem) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Item")
                    }
                }
                Section {
                    ForEach(incompleteItems, id:\.self) { item in
                        ShoppingListItemRow(shoppingListItem: item)
                    }
                    .onDelete(perform: deleteIncomplete(at:))
                }
                if completeItems.count > 0 {
                    Section(header: Text("Completed")) {
                        ForEach(completeItems, id: \.self) { item in
                            ShoppingListItemRow(shoppingListItem: item)
                        }
                        .onDelete(perform: deleteComplete(at:))
                    }
                }
            }
            .navigationBarTitle("Shopping List")
    .navigationBarItems(trailing: EditButton().animation(.easeInOut))
        }
    }
    #else
    var body: some View {
        List {
            Button(action: addShoppingListItem) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Item")
                }
            }
            Section {
                ForEach(incompleteItems, id:\.self) { item in
                    ShoppingListItemRow(shoppingListItem: item)
                }.onDelete(perform: deleteIncomplete(at:))
            }
            if completeItems.count > 0 {
                Section(header: Text("Completed")) {
                    ForEach(completeItems, id: \.self) { item in
                        ShoppingListItemRow(shoppingListItem: item)
                    }.onDelete(perform: deleteComplete(at:))
                }
            }
        }
    }
    #endif
}

struct ShoppingListView_Previews: PreviewProvider {
    
    struct ShoppingListViewPreview: View {
        var body: some View {
            ShoppingListView()
        }
    }
    static var previews: some View {
        Group {
            ShoppingListViewPreview()
        }
    }
}
