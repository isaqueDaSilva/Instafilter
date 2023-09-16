//
//  HomeViewModel.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import Foundation
import SwiftUI

extension HomeView {
    class HomeViewModel: ObservableObject {
        @Published var manager = FilterManager()
        @Published var showingfilterIntensity: Bool = false
        @Published var showingPhotoLibrary = false
        
        func filterIntensity() -> Double {
            manager.filterIntensity
        }
        
        func image() -> Image? {
            manager.image
        }
        
        func inputImage() -> UIImage? {
            manager.inputImage
        }
        
        func loadImage() {
            manager.loadImage()
        }
        
        func applyFilter() {
            manager.applyFilter()
        }
    }
}
