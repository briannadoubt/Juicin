//
//  JuiceProduceRow.swift
//  Juicies
//
//  Created by Brianna Lee on 5/7/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct JuiceProduceRow: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var produce: Produce
    
    @Binding var isEditing: Bool
    
    func increaseQuantity() {
        produce.quantity += 1
    }
    
    func decreaseQuantity() {
        produce.quantity -= 1
        if produce.quantity == 0 {
            context.delete(produce)
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "\(produce.quantity).square")
                .resizable()
                .frame(
                    width: 25,
                    height: 25
                )
                .padding(10)
            TextField("Produce", text: $produce.name, onEditingChanged: { textDidChange in
                if textDidChange {
                    try? self.context.save()
                }
            }).disabled(!isEditing)
            if isEditing {
                #if !os(watchOS)
                Button(action: decreaseQuantity) {
                    Image(systemName: "minus")
                }.modifier(ListButtonStyle())
                #else
                Button(action: decreaseQuantity) {
                    Image(systemName: "minus")
                }
                #endif
                #if !os(watchOS)
                Button(action: increaseQuantity) {
                    Image(systemName: "plus")
                }.modifier(ListButtonStyle())
                #else
                Button(action: increaseQuantity) {
                    Image(systemName: "plus")
                }
                #endif
            }
        }.fixedSize(horizontal: false, vertical: true)
    }
}

struct ProduceView_Previews: PreviewProvider {
    
    struct Editing: View {
        @State var isEditing = true
        var body: some View {
            JuiceProduceRow(produce: Produce(), isEditing: $isEditing)
        }
    }
    
    struct NotEditing: View {
        @State var isEditing = false
        var body: some View {
            JuiceProduceRow(produce: Produce(), isEditing: $isEditing)
        }
    }
    
    static var previews: some View {
        Group {
            NotEditing()
            Editing()
        }
    }
}
