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
    let manager = FilterManager()
    
    @Binding var switchMode: Bool
    let name: String
    let image: String
    let filterType: CIFilter
    
    var body: some View {
        Button {
            withAnimation {
                switchMode.toggle()
            }
            manager.setFilter(filterType)
        } label: {
            Label(name, systemImage: image)
        }
    }
}

