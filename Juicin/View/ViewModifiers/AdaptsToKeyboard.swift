//
//  KeyboardContainer.swift
//  Juicies
//
//  Created by Brianna Lee on 5/7/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI
import Combine

// Usage:
// struct MyView: View {
//     var body: some View {
//         Form {...}
//         .modifier(AdaptsToKeyboard())
//     }
// }
struct AdaptsToKeyboard: ViewModifier {
    @State var currentHeight: CGFloat = 0
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.currentHeight)
//                .animation(.easeInOut(duration: 0.3))
                .onAppear(perform: {
                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillShowNotification)
                        .merge(with: NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillChangeFrameNotification))
                        .compactMap { notification in
                            
                            notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
                    }
                    .map { rect in
                        // This terrible solution coming at you from 44 pixels away ;)
                        // The view's don't render in line with this around a tab bar.
                        let tabBarHeight: CGFloat = 44
                        return rect.height - geometry.safeAreaInsets.bottom - tabBarHeight
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))

                    NotificationCenter.Publisher(center: NotificationCenter.default, name: UIResponder.keyboardWillHideNotification)
                        .compactMap { notification in
                            CGFloat.zero
                    }
                    .subscribe(Subscribers.Assign(object: self, keyPath: \.currentHeight))
                })
        }
    }
}


