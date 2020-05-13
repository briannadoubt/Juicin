//
//  AllProduceView.swift
//  Juicin
//
//  Created by Brianna Lee on 5/12/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct AllProduceView: View {
    
    #if !os(watchOS)
    @Environment(\.managedObjectContext) var context
    #else
    let context = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    #endif
    
    @FetchRequest(
        entity: Produce.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Produce.updatedAt, ascending: false)
        ]
    ) var produce: FetchedResults<Produce>
    
    @State var isEditing: Bool = false
    
    func addProduce() {
        let newProduce = Produce(context: context)
//        newProduce.isEditing = true
        newProduce.id = UUID().uuidString
        newProduce.name = ""
        newProduce.createdAt = Date()
        newProduce.updatedAt = Date()
//        newProduce.color = produce.first?.color ?? "green"
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            if let singleProduce = produce.first(where: { $0.id == produce[index].id }) {
                context.delete(singleProduce)
            }
        }
    }
    
    #if !os(watchOS)
    var body: some View {
        NavigationView {
            List {
                Button(action: addProduce) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Produce")
                    }
                }
                ForEach(produce, id: \.self) { singleProduce in
                    VStack {
                        JuiceProduceRow(produce: singleProduce, isEditing: self.$isEditing)
                        Spacer()
                    }
                }
                .onDelete(perform: delete(at:))
            }
            .navigationBarTitle("My Juices")
        }
    }
    #else
    var body: some View {
        List {
            Button(action: addProduce) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Juice")
                }
            }
            ForEach(produce, id: \.self) { singleProduce in
                JuiceProduceRow(produce: singleProduce, isEditing: self.$isEditing)
            }
            .onDelete(perform: delete(at:))
        }
    }
    #endif
}

struct AllProduce_Previews: PreviewProvider {
    static var previews: some View {
        AllProduceView()
    }
}
