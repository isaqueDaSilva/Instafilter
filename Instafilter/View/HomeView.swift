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
                    
                    if viewModel.showingSliderIntensity && viewModel.image != nil && viewModel.currentFilter != CIFilter.colorInvert() {
                        Slider(value: $viewModel.filterIntensity, in: 0...viewModel.maxValue)
                            .onChange(of: viewModel.filterIntensity, { _, _ in
                                viewModel.applyFilter()
                            })
                            .padding(.top)
                    }
                }
                .padding()
            }
            .navigationTitle("InstaFilter")
            .preferredColorScheme(.dark)
            .onChange(of: viewModel.inputImage, { _, _ in
                viewModel.loadImage()
            })
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
                            ForEach(viewModel.filterInButtonBar) { filter in
                                FilterButton(showingSlider: $viewModel.showingSliderIntensity, filterType: filter.name, image: filter.icone, isLabelOn: true) {
                                    viewModel.setFilter(filter.filterType)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            Menu {
                                ForEach(viewModel.filtersInMenu) { filter in
                                    FilterButton (showingSlider: $viewModel.showingSliderIntensity, filterType: filter.name, image: filter.icone, isLabelOn: false) {
                                        viewModel.setFilter(filter.filterType)
                                    }
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
