//
//  ImagePickerExtension.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import Foundation
import PhotosUI

extension ImagePicker {
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePicker
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    DispatchQueue.main.async {
                        self.parent.image = image as? UIImage
                    }
                }
            }
        }
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
    }
}
