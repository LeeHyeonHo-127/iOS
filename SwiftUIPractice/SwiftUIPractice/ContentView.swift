//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by 이현호 on 2023/11/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 10
        ) {
            ForEach(
                1...5,
                id: \.self
            ) {
                Text("Item \($0)")
            }
        }
   }

}

#Preview {
    ContentView()
}
