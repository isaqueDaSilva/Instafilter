//
//  FilterButton.swift
//  Instafilter
//
//  Created by Isaque da Silva on 15/09/23.
//

import SwiftUI

struct FilterButton: View {
    @Binding var showingSlider: Bool
    let filterType: String
    let image: String?
    var isLabelOn: Bool
    
    var currentFilter: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                if showingSlider == false {
                    showingSlider = true
                }
                currentFilter()
            }
        } label: {
            if isLabelOn {
                Label(filterType, systemImage: image ?? "")
            } else {
                Text(filterType)
            }
        }
    }
}
