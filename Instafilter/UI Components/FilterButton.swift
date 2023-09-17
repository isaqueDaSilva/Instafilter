//
//  FilterButton.swift
//  Instafilter
//
//  Created by Isaque da Silva on 15/09/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct FilterButton: View {
    @Binding var showingSlider: Bool
    let filterType: String
    let image: String
    var currentFilter: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                if showingSlider == false {
                    showingSlider.toggle()
                }
                currentFilter()
            }
        } label: {
            Label(filterType, systemImage: image)
        }
    }
}
