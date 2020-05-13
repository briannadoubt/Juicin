//
//  JuiceHeaderView.swift
//  Juicin
//
//  Created by Brianna Lee on 5/12/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct JuiceHeaderView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @ObservedObject var juice: Juice
    
    func toggleIsEditing() {
        juice.isEditing = !juice.isEditing
        if juice.isEditing == false {
            try? context.save()
        }
    }
    
    var body: some View {
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
                        .disabled(!juice.isEditing)
                        .font(.headline)
                        .padding()
                        .lineLimit(0)
                        .foregroundColor(.white)
                        .accentColor(.white)
                }
                #if !os(watchOS)
                Button(action: toggleIsEditing) {
                    Text(self.juice.isEditing ? "Done" : "Edit")
                }
                    .buttonStyle(BorderlessButtonStyle())
                    .foregroundColor(.white)
                .padding()
                #endif
            }
        }
    }
}

struct JuiceHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        JuiceHeaderView(juice: Juice())
    }
}
