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
        let context = CIContext()
        
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var filterIntensity: Double = 0.5
        @Published var showingfilterIntensity: Bool = false
        @Published var showingPhotoLibrary = false
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
            let inputKeys = currentFilter.inputKeys
            
            if inputKeys.contains(kCIInputIntensityKey) {
                currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            }
            
            if inputKeys.contains(kCIInputRadiusKey) {
                currentFilter.setValue(filterIntensity, forKey: kCIInputRadiusKey)
            }
            
            if inputKeys.contains(kCIInputScaleKey) {
                currentFilter.setValue(filterIntensity, forKey: kCIInputScaleKey)
            }
            
            guard let outputImage = currentFilter.outputImage else { return }
            
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                image = Image(uiImage: uiImage)
            }
        }
    }
}
