//
//  FilterButton.swift
//  Instafilter
//
//  Created by Isaque da Silva on 15/09/23.
//

import SwiftUI

struct FilterButton: View {
    @Binding var switchMode: Bool
    var filter: CIFilter
    var image: Image
    
    var body: some View {
        Button {
            withAnimation {
                switchMode.toggle()
            }
        } label: {
            Image(systemName: "wand.and.stars.inverse")
        }
    }
}

