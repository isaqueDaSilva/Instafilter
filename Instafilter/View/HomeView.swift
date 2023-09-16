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
                        if viewModel.image() == nil {
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
                            viewModel.image()?
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    if viewModel.showingfilterIntensity {
                        FilterIntensityView(value: $viewModel.manager.filterIntensity)
                            .onChange(of: viewModel.filterIntensity()) { _ in
                                viewModel.applyFilter()
                            }
                            .padding(.top, 30)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("InstaFilter")
            .preferredColorScheme(.dark)
            .onChange(of: viewModel.inputImage()) { _ in viewModel.loadImage() }
            .toolbar {
                if viewModel.image() != nil {
                    ToolbarItem {
                        Button("Save") {
                            
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        FilterButton(
                            switchMode: $viewModel.showingfilterIntensity,
                            name: "Sepia Tone", image: "camera.filters",
                            filterType: CIFilter.sepiaTone()
                        )
                        .onChange(of: viewModel.showingfilterIntensity) { newValue in
                            viewModel.showingfilterIntensity = newValue
                        }
                    }
                }
            }
            .sheet(isPresented: $viewModel.showingPhotoLibrary) {
                ImagePicker(image: $viewModel.manager.inputImage)
            }
        }
    }
}
