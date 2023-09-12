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
        VStack {
            Text("Hello, world!")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .ignoresSafeArea()
                .onTapGesture {
                    showingChangeBackground = true
                }
        }
        .confirmationDialog("Change Background", isPresented: $showingChangeBackground) {
            Button("Red") { backgroundColor = .red }
            Button("Green") { backgroundColor = .green }
            Button("Blue") { backgroundColor = .blue }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Change color of background")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
