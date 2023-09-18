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
                    
                    if viewModel.showingSliderIntensity && viewModel.image != nil {
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
                        HStack(spacing: 10) {
                            Button {
                                viewModel.showingUserGalery = true
                            } label: {
                                Label("Change current photo", systemImage: "photo")
                            }
                            .padding(.top, 4.5)
                            
                            Button {
                                viewModel.save()
                            } label: {
                                Label("Save photo", systemImage: "square.and.arrow.up")
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .bottomBar) {
                        HStack(spacing: 20) {
                            
                            FilterButton(showingSlider: $viewModel.showingSliderIntensity, filterType: "Crystallize", image: "wand.and.stars.inverse", isLabelOn: true) {
                                viewModel.setFilter(CIFilter.crystallize())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Edges",image: "timeline.selection", isLabelOn: true) {
                                viewModel.setFilter(CIFilter.edges())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Gausian Blur",image: "f.cursive", isLabelOn: true) {
                                viewModel.setFilter(CIFilter.gaussianBlur())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Pixellate",image: "eyedropper", isLabelOn: true) {
                                viewModel.setFilter(CIFilter.pixellate())
                            }
                            
                            FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Sepia Tone",image: "camera.filters", isLabelOn: true) {
                                viewModel.setFilter(CIFilter.sepiaTone())
                            }
                            
                            Menu {
                                FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Unsharp Mask",image: nil, isLabelOn: false) {
                                    viewModel.setFilter(CIFilter.unsharpMask())
                                }
                                
                                FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Vignette",image: nil, isLabelOn: false) {
                                    viewModel.setFilter(CIFilter.vignette())
                                }
                                
                                FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: "Distortion",image: nil, isLabelOn: false) {
                                    viewModel.setFilter(CIFilter.twirlDistortion())
                                }
                            } label: {
                                Label("More Filters", systemImage: "line.3.horizontal")
                            }
                        }
                    }
                }
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showingAlert) {
                Button("OK") {
                    withAnimation {
                        viewModel.image = nil
                    }
                }
            } message: {
                Text(viewModel.alertMessage)
            }

        }
    }
}
