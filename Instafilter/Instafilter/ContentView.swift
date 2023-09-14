//
//  ContentView.swift
//  Instafilter
//
//  Created by Isaque da Silva on 11/09/23.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundColor = Color.white
    @State private var showingChangeBackground = false
    var body: some View {
        NavigationView {
            ZStack {
                Color("MidnightBlue").ignoresSafeArea()
            }
            .navigationTitle("InstaFilter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
