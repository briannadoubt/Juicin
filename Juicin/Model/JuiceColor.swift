//
//  JuiceColor.swift
//  Juicin
//
//  Created by Brianna Lee on 5/10/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import Foundation
import SwiftUI

enum JuiceColor: String, CaseIterable {
    case red
    case green
    case purple
    case orange
    
    var color: Color {
        switch self {
        case .green:
            return Color.green
        case .orange:
            return Color.orange
        case .purple:
            return Color.purple
        case .red:
            return Color.red
        }
    }
}
