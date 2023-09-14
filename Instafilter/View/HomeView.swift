//
//  HomeView.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color("MidnightBlue").ignoresSafeArea()
                
                VStack {
                    Button {
                        
                    } label: {
                        VStack {
                            Image(systemName: "square.and.arrow.down")
                                .font(.system(size: 25))
                                .padding(5)
                            Text("Import your photo")
                        }
                        .foregroundColor(.white)
                    }

                }
            }
            .navigationTitle("InstaFilter")
            .preferredColorScheme(.dark)
        }
    }
}
