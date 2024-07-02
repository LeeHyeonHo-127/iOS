//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by 이현호 on 2023/11/09.
//

import SwiftUI

struct View1: View {
    var body: some View {
        LazyVGrid(columns: [GridItem(),GridItem()]) {
            ForEach((1..<11), id: \.self) { _ in
                Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                    .frame(width: 150, height: 150)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}


struct View2: View {
    var body: some View {
        VStack{
            Text("Text with default Padding")
                .padding()
                .border(.gray)
            
            Text("Unpadding")
                .border(.yellow)
        }
    }
}

struct View3: View{
    var body: some View{
        Button(action: buttonTapped, label: {
            /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
        })
    }
    
    func buttonTapped(){
        print("hello Universe")
    }
}

struct TabItem: View{
    var body: some View {
        TabView{
            View1()
                .tabItem{
                    Label("Menu", systemImage: "list.dash")
                }
            
            View2()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
            
            View3()
                .tabItem {
                    Label("ButtonTest", systemImage: "square.and.pencil")
                }
        }
    }
}

struct ContentView: View{
    var body: some View{
        TabItem()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//Image 연습
/*
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
*/


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
