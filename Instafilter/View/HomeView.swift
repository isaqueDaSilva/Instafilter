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
                        HStack(spacing: 20) {
                            
                            FilterButton(showingSlider: $viewModel.showingSliderIntensity, filterType: "Crystallize",image: "wand.and.stars.inverse") {
                                viewModel.setFilter(CIFilter.crystallize())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Edges",image: "timeline.selection") {
                                viewModel.setFilter(CIFilter.edges())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Gausian Blur",image: "f.cursive") {
                                viewModel.setFilter(CIFilter.gaussianBlur())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Pixellate",image: "eyedropper") {
                                viewModel.setFilter(CIFilter.pixellate())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Sepia Tone",image: "camera.filters") {
                                viewModel.setFilter(CIFilter.sepiaTone())
                            }
                            
                            Button {
                                viewModel.showingConfirmationDialog = true
                            } label: {
                                Label("More Filters", systemImage: "line.3.horizontal")
                            }
                        }
                    }
                }
            }
            .confirmationDialog("More Filters", isPresented: $viewModel.showingConfirmationDialog) {
                Button("Unsharp Mask") { viewModel.setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { viewModel.setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
        }
    }
}
