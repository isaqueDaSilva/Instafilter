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

class FilterManager {
    let context = CIContext()
    
    func loadImage(_ inputImage: UIImage?, _ currentFilter: CIFilter) {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
    }
    
    func applyFilter(_ currentFilter: CIFilter, _ filterIntensity: Double, _ image: Image?) {
        
        var image = image
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
