//
//  HomeViewModel.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI

extension HomeView {
    class HomeViewModel: ObservableObject {
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var filterIntensity: Double = 0.5
        @Published var showingfilterIntensity: Bool = false
        @Published var showingPhotoLibrary = false
        @Published var context = CIContext()
        @Published var currentFilter = CIFilter.sepiaTone()
        
        func changeFilter() {
            
        }
        
        func save() {
            
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyFilter()
        }
        
        func applyFilter() {
            currentFilter.intensity = Float(filterIntensity)
            
            guard let outputImage = currentFilter.outputImage else { return }
            
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                self.image = Image(uiImage: uiImage)
            }
        }
    }
}
