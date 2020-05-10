//
//  JuiceView.swift
//  Juicies
//
//  Created by Brianna Lee on 5/7/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI
import CoreData

struct JuiceView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var juice: Juice {
        willSet {
            if self.juice.name.isEmpty {
                self.isEditing = true
            }
        }
    }
    
    private var produceFetchRequest: FetchRequest<Produce>
    
    init(_ juice: Juice) {
        self.juice = juice
        produceFetchRequest = FetchRequest<Produce>(
            entity: Produce.entity(),
            sortDescriptors: [
                NSSortDescriptor(
                    keyPath: \Juice.updatedAt,
                    ascending: true
                )
            ],
            predicate: NSPredicate(format: "juice = %@", juice.id)
        )
        isEditing = juice.name.isEmpty
    }
    
    @State var showColors = false
    @State var isEditing: Bool = false
    
    func addProduce() {
        let newProduce = Produce(context: context)
        newProduce.createdAt = Date()
        newProduce.id = UUID().uuidString
        newProduce.name = ""
        newProduce.quantity = 1
        newProduce.updatedAt = Date()
        newProduce.juice = juice.id
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func addProduceToList() {
        for produce in produceFetchRequest.wrappedValue {
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
    
    func toggleIsEditing() {
        isEditing = !isEditing
        if isEditing == false {
            try? context.save()
        }
    }
    
    var body: some View {
        VStack {
            ZStack {
                JuiceColor(rawValue: juice.color)?.color ?? Color.white
                HStack {
                    ZStack {
                        if juice.name.isEmpty {
                            HStack {
                                Text("Name of Juice")
                                    .font(.headline)
                                    .padding()
                                    .foregroundColor(Color(.white))
                                Spacer()
                            }
                        }
                        TextField("", text: $juice.name)
                            .disabled(!isEditing)
                            .font(.headline)
                            .padding()
                            .lineLimit(0)
                            .foregroundColor(.white)
                            .accentColor(.white)
                    }
                    #if !os(watchOS)
                    Button(action: toggleIsEditing) {
                        Text(self.isEditing ? "Done" : "Edit")
                    }.padding().buttonStyle(BorderlessButtonStyle()).foregroundColor(.white)
                    #else
                    Button(action: toggleIsEditing) {
                        Text(self.isEditing ? "Done" : "Edit")
                    }.padding().foregroundColor(.white)
                    #endif
                }
            }
            
            ForEach(produceFetchRequest.wrappedValue, id: \.self) { produce in
                ProduceRow(produce: produce, isEditing: self.$isEditing)
            }
            
            if isEditing {
                HStack {
                    Spacer()
                    #if !os(watchOS)
                    Button(action: addProduce) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Produce")
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    #else
                    Button(action: addProduce) {
                        HStack {
                            Image(systemName: "plus")
                            Text("To List")
                        }
                    }
                    #endif
                    Spacer()
                    #if !os(watchOS)
                    Button(action: addProduceToList) {
                        HStack {
                            Image(systemName: "plus")
                            Text("To List")
                        }
                    }
                    .buttonStyle(BorderlessButtonStyle())
                    #else
                    Button(action: addProduceToList) {
                        HStack {
                            Image(systemName: "plus")
                            Text("To List")
                        }
                    }
                    #endif
                    Spacer()
                    #if !os(watchOS)
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
                    }.padding()
                    .buttonStyle(BorderlessButtonStyle())
                    #else
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
                    }.padding()
                    #endif
                }
                #if !os(watchOS)
                if showColors {
                    HStack {
                        ForEach(JuiceColor.allCases, id: \.self) { color in
                            Button(action: {
                                self.juice.color = color.rawValue
                                print(color.rawValue)
                                try? self.context.save()
                            }) {
                                ZStack {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(color.color)
                                        .cornerRadius(10)
                                    if self.juice.color == color.rawValue {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .padding()
                        }
                    }
                }
                #endif
            }
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(JuiceColor(rawValue: juice.color)?.color ?? Color.white, lineWidth: 2)
        )
        .cornerRadius(10)
        .animation(.easeInOut(duration: 0.3))
        .accentColor(JuiceColor(rawValue: juice.color)?.color ?? Color.white)
    }
}

struct JuiceView_Previews: PreviewProvider {
    
    struct Blank: View {
        var body: some View {
            List {
                VStack {
                    JuiceView(Juice())
                }
            }
        }
    }
    
    struct WithProduce: View {
        var body: some View {
            List {
                VStack {
                    JuiceView(Juice())
                }
            }
        }
    }
    
    static var previews: some View {
        Group {
            Blank().accentColor(.black).padding()
            WithProduce().accentColor(.black).padding()
        }
    }
}
