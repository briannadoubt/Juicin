//
//  JuiceColorPickerView.swift
//  Juicin
//
//  Created by Brianna Lee on 5/12/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct JuiceColorPickerView: View {
    
    @Environment(\.managedObjectContext) var context
    
    @Binding var color: String
    
    var body: some View {
        HStack {
            ForEach(JuiceColor.allCases, id: \.self) { newColor in
                Button(action: {
                    self.color = newColor.rawValue
                    try? self.context.save()
                }) {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(newColor.color)
                            .cornerRadius(10)
                        if self.color == newColor.rawValue {
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
}

struct JuiceColorPickerView_Previews: PreviewProvider {
    
    struct JuiceColorPickerViewPreview: View {
        
        @State var color: String
        
//        init(color: String) {
//            self.color = color
//        }
        
        var body: some View {
            JuiceColorPickerView(color: $color)
        }
    }
    
    static var previews: some View {
        Group {
            ForEach(JuiceColor.allCases, id: \.self) { colorKey in
                JuiceColorPickerViewPreview(color: colorKey.rawValue)
            }
        }
    }
}
