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
        
        @Published var showingUserGalery: Bool = false
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var imageSaved: UIImage?
        @Published var currentFilter: CIFilter = CIFilter.sepiaTone()
        @Published var filterIntensity: Double = 0.5
        @Published var showingSliderIntensity: Bool = false
        @Published var showingConfirmationDialog = false
        @Published var showingAlert = false
        @Published var alertTitle = ""
        @Published var alertMessage = ""
        
        func setFilter(_ filter: CIFilter) {
            DispatchQueue.main.async {
                self.currentFilter = filter
                self.loadImage()
            }
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            let beginImage = CIImage(image: inputImage)
            self.currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyFilter()
        }
        
        func applyFilter() {
            let inputKeys = currentFilter.inputKeys
            
            if inputKeys.contains(kCIInputIntensityKey) {
                self.currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
            }
            
            if inputKeys.contains(kCIInputRadiusKey) {
                self.currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
            }
            
            if inputKeys.contains(kCIInputScaleKey) {
                self.currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
            }
            
            guard let outputImage = currentFilter.outputImage else { return }
            
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                let uiImage = UIImage(cgImage: cgImage)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                    self.imageSaved = uiImage
                }
            }
        }
        
        func save() {
            guard let imageSaved = imageSaved else { return }
            
            let imageSaver = ImageSaver()
            
            imageSaver.successHandler = {
                self.alertTitle = "Saved"
                self.alertMessage = "Your image has been saved successfully!"
                self.showingAlert = true
            }
            
            imageSaver.errorHandler = {
                self.alertTitle = "Error"
                self.alertMessage = "An error occurred while saving the image to the gallery.\($0.localizedDescription)\nPlease try again!"
                self.showingAlert = true
            }
            
            imageSaver.writeToPhotoAlbum(imageSaved)
        }
    }
}
