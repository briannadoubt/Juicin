//
//  JuiceControlBarView.swift
//  Juicin
//
//  Created by Brianna Lee on 5/12/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct JuiceControlBarView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var juice: Juice
    
    @Binding var showColors: Bool
    
    func addProduce() {
        let newProduce = Produce(context: context)
        newProduce.createdAt = Date()
        newProduce.id = UUID().uuidString
        newProduce.name = ""
        newProduce.quantity = 1
        newProduce.updatedAt = Date()
        newProduce.juice.adding(juice)
        juice.produce.adding(newProduce)
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addProduceToList() {
        for produce in juice.produceArray {
            let newShoppingListItem = ShoppingListItem(context: context)
            newShoppingListItem.id = UUID().uuidString
            newShoppingListItem.isComplete = false
            newShoppingListItem.name = produce.name
            newShoppingListItem.quantity = produce.quantity
            newShoppingListItem.createdAt = Date()
            newShoppingListItem.updatedAt = Date()
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
    
    func toggleShowColors() {
        showColors = !showColors
    }
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: addProduce) {
                HStack {
                    Image(systemName: "plus")
                    Text("Produce")
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button(action: addProduceToList) {
                HStack {
                    Image(systemName: "plus")
                    Text("To List")
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            Spacer()
            Button(action: toggleShowColors) {
                ZStack {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .background(JuiceColor(rawValue: juice.color)?.color ?? Color.white)
                        .cornerRadius(10)
                    if showColors {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                    }
                }
            }
                .padding()
                .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct JuiceControlBarView_Previews: PreviewProvider {
    
    struct ShowingColors: View {
        @State var showColors = true
        var body: some View {
            JuiceControlBarView(juice: Juice(), showColors: $showColors)
        }
    }
    
    struct NotShowingColors: View {
        @State var showColors = false
        var body: some View {
            JuiceControlBarView(juice: Juice(), showColors: $showColors)
        }
    }
    
    static var previews: some View {
        Group {
            NotShowingColors()
            ShowingColors()
        }
    }
}
