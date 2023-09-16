//
//  FilterIntensityView.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import SwiftUI

struct FilterIntensityView: View {
    @Binding var value: Double
    var body: some View {
        VStack {
            Slider(value: $value, in: 0...1)
        }
    }
}

