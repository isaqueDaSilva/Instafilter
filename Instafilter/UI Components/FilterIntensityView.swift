//
//  FilterIntensityView.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import SwiftUI

struct FilterIntensityView: View {
    @Binding var range: Double
    var body: some View {
        VStack {
            Slider(value: $range, in: 0...100)
        }
    }
}

