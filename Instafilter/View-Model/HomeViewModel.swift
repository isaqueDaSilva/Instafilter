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
        let manager = FilterManager()
        
        @Published var showingfilterIntensity: Bool = false
        @Published var showingPhotoLibrary = false
        
        func image() -> Image? {
            manager.image
        }
        
        func loadImage() {
            manager.loadImage()
        }
        
        func applyFilter() {
            manager.applyFilter()
        }
    }
}
