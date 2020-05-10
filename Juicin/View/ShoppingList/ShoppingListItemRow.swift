//
//  ShoppingListItemRow.swift
//  Juicies
//
//  Created by Brianna Lee on 5/7/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct ShoppingListItemRow: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var shoppingListItem: ShoppingListItem
    
    func mark() {
        shoppingListItem.isComplete = !shoppingListItem.isComplete
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some View {
        HStack {
            Button(action: mark) {
                Image(systemName: shoppingListItem.isComplete ? "circle.fill" : "circle")
            }.padding()
            if shoppingListItem.quantity > 1 {
                Text("\(shoppingListItem.quantity)")
            }
            TextField("Name", text: self.$shoppingListItem.name)
        }
    }
}

struct ShoppingListItemRow_Previews: PreviewProvider {
    struct ShowQuantity: View {
        var body: some View {
            ShoppingListItemRow(shoppingListItem: ShoppingListItem())
        }
    }
    struct HideQuantity: View {
        var body: some View {
            ShoppingListItemRow(shoppingListItem: ShoppingListItem())
        }
    }
    static var previews: some View {
        Group {
            ShowQuantity()
            HideQuantity()
        }
    }
}
