//
//  ContentView.swift
//  Juicies
//
//  Created by Brianna Lee on 5/6/20.
//  Copyright © 2020 Brianna Zamora. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    #if os(macOS)
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ShoppingListView()) {
                    HStack {
                        Image(systemName: "doc.plaintext")
                        Text("Shopping List")
                    }
                }
                NavigationLink(destination: JuiceListView()) {
                    HStack {
                        Text("All Juices")
                    }
                }
            }
        }.accentColor(.green)
    }
    #else
    var body: some View {
        TabView {
            ShoppingListView()
                .tabItem {
                    VStack {
                        Image(systemName: "doc.plaintext")
                        Text("Shopping")
                    }
            }
            JuiceListView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Juices")
                    }
            }
        }
        .accentColor(.green)
    .modifier(AdaptsToKeyboard())
    }
    #endif
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
