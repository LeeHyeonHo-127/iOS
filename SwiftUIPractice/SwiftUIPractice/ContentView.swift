//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by 이현호 on 2023/11/09.
//

import SwiftUI

struct ContentView: View {
    let name: String = "hello"
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark")
            Spacer()
            Text(name)
        }
        .border(Color.gray)
    }
}

#Preview {
    ContentView()
}



//TapView 연습
/*
struct ContentView: View {
    
    var body: some View {
        TabView {
            Text("The First Tap")
                .badge(2)
                .tabItem{
                    Label("Received", systemImage: "tray.and.arrow.down.fill")
                }
            Text("Another Tab")
                .tabItem{
                    Label("Sent", systemImage: "tray.and.arrow.up.fill")
                }
            Text("The Last Tab")
                .badge("!")
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
*/
