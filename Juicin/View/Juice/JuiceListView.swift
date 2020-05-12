//
//  JuicesView.swift
//  Juicies
//
//  Created by Brianna Lee on 5/6/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct JuiceListView: View {
    
    #if !os(watchOS)
    @Environment(\.managedObjectContext) var context
    #else
    let context = (WKExtension.shared().delegate as! ExtensionDelegate).persistentContainer.viewContext
    #endif
    
    @FetchRequest(
        entity: Juice.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Juice.updatedAt, ascending: false)
        ]
    ) var juices: FetchedResults<Juice>
    
    func addJuice() {
        let newJuice = Juice(context: context)
        newJuice.isEditing = true
        newJuice.id = UUID().uuidString
        newJuice.name = ""
        newJuice.createdAt = Date()
        newJuice.updatedAt = Date()
        newJuice.color = juices.first?.color ?? "green"
        do {
            try context.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            if let juice = juices.first(where: {$0.id == juices[index].id}) {
                context.delete(juice)
            }
        }
    }
    
    #if !os(watchOS)
    var body: some View {
        NavigationView {
            List {
                Button(action: addJuice) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Juice")
                    }
                }
                ForEach(self.juices, id: \.self) { juice in
                    VStack {
                        JuiceView(juice)
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
            Button(action: addJuice) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add Juice")
                }
            }
            ForEach(juices, id: \.self) { juice in
                JuiceView(juice)
            }.onDelete(perform: delete(at:))
        }
    }
    #endif
}

struct JuiceListView_Previews: PreviewProvider {
    struct JuiceListViewPreview: View {
        var body: some View {
            JuiceListView()
        }
    }
    static var previews: some View {
        Group {
            JuiceListViewPreview()
        }
    }
}
