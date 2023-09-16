//
//  FilterManager.swift
//  Instafilter
//
//  Created by Isaque da Silva on 15/09/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import SwiftUI

class FilterManager: ObservableObject {
    let context = CIContext()
    
    @Published var image: Image?
    @Published var inputImage: UIImage?
    @Published var filterIntensity: Double = 0
    @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
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
