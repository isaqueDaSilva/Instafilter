//
//  Filters.swift
//  Instafilter
//
//  Created by Isaque da Silva on 17/09/23.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation

struct Filters: Identifiable {
    var id = UUID()
    let name: String
    let filterType: CIFilter
    let icone: String?
}
