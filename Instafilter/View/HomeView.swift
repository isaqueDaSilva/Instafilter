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
                    if viewModel.image == nil {
                        ZStack {
                            Rectangle()
                                .fill(.secondary)
                                .cornerRadius(10)
                                .frame(height: 400)
                            Button {
                                viewModel.showingUserGalery = true
                            } label: {
                                VStack {
                                    Image(systemName: "square.and.arrow.down")
                                        .font(.system(size: 30))
                                    Text("Import your Image")
                                        .padding(.top, 10)
                                }
                                .foregroundColor(.white)
                            }
                            
                        }
                    } else {
                        viewModel.image?
                            .resizable()
                            .scaledToFit()
                    }
                    
                    if viewModel.showingSliderIntensity {
                        Slider(value: $viewModel.filterIntensity)
                            .onChange(of: viewModel.filterIntensity) { _ in
                                viewModel.applyFilter()
                            }
                            .padding(.top)
                    }
                }
                .padding()
            }
            .navigationTitle("InstaFilter")
            .preferredColorScheme(.dark)
            .onChange(of: viewModel.inputImage) { _ in viewModel.loadImage() }
            .sheet(isPresented: $viewModel.showingUserGalery) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .toolbar {
                if viewModel.image != nil {
                    ToolbarItem {
                        Button("Save") {

                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        HStack {
                            
                            FilterButton(
                                showingSlider: $viewModel.showingSliderIntensity,
                                currentFilter: { viewModel.setFilter(CIFilter.sepiaTone()) },
                                filterType: "Sepia Tone",
                                image: "camera.filters"
                            )
                            
                            FilterButton (
                                showingSlider: $viewModel.showingSliderIntensity,
                                currentFilter: { viewModel.setFilter(CIFilter.gaussianBlur()) },
                                filterType: "Gausian Blur",
                                image: "f.cursive"
                            )
                        }
                    }
                }
            }
        }
    }
}
