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
    
    @ObservedObject var juice: Juice
    
    @State var showColors = false
    
    func shouldShowProduce(_ produce: Produce) -> Bool {
        if self.juice.isEditing {
            return true
        } else {
            if produce.name == "" {
                return false
            } else {
                return true
            }
        }
    }
    
    var body: some View {
        VStack {
            JuiceHeaderView(juice: juice)
            ForEach(juice.produceArray.filter(shouldShowProduce(_:)), id: \.self) { produce in
                VStack {
                    JuiceProduceRow(produce: produce, isEditing: self.$juice.isEditing)
                }
            }
            
            #if !os(watchOS)
            if juice.isEditing {
                JuiceControlBarView(juice: juice, showColors: $showColors)
            }
            
            if showColors {
                JuiceColorPickerView(color: $juice.color)
            }
            #endif
            
            Spacer()
        }
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(JuiceColor(rawValue: juice.color)?.color ?? Color.white, lineWidth: 2)
        )
        .cornerRadius(20)
        .animation(.easeInOut(duration: 0.3))
        .accentColor(JuiceColor(rawValue: juice.color)?.color ?? Color.white)
    }
}

struct JuiceView_Previews: PreviewProvider {
    
    struct Blank: View {
        var body: some View {
            List {
                VStack {
                    JuiceView(juice: Juice())
                }
            }
        }
    }
    
    struct WithProduce: View {
        var body: some View {
            List {
                VStack {
                    JuiceView(juice: Juice())
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
