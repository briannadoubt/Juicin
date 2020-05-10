//
//  ListButtonStyle.swift
//  Juicin
//
//  Created by Brianna Lee on 5/10/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct ListButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .buttonStyle(BorderlessButtonStyle())
    }
}
