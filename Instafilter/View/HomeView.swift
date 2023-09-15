//
//  HomeView.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Color("MidnightBlue").ignoresSafeArea()
                VStack {
                    ZStack {
                        if viewModel.image == nil {
                            Rectangle()
                                .fill(.secondary)
                                .cornerRadius(10)
                                .frame(height: 400)
                            Button {
                                viewModel.showingPhotoLibrary = true
                            } label: {
                                VStack {
                                    Image(systemName: "square.and.arrow.down")
                                        .font(.system(size: 25))
                                        .padding(5)
                                    Text("Import your photo")
                                }
                                .foregroundColor(.white)
                            }
                        } else {
                            viewModel.image?
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    if viewModel.showingfilterIntensity {
                        FilterIntensityView(range: $viewModel.filterIntensity)
                            .onChange(of: viewModel.filterIntensity) { _ in viewModel.applyFilter() }
                            .padding(.top, 30)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("InstaFilter")
            .preferredColorScheme(.dark)
            .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
            .toolbar {
                if viewModel.image != nil {
                    ToolbarItem {
                        Button("Save") {
                            
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        Button {
                            withAnimation {
                                viewModel.showingfilterIntensity.toggle()
                            }
                        } label: {
                            Image(systemName: "wand.and.stars.inverse")
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingPhotoLibrary) {
                ImagePicker(image: $viewModel.inputImage)
            }
        }
    }
}
