//
//  HomeViewModel.swift
//  Instafilter
//
//  Created by Isaque da Silva on 14/09/23.
//

import Foundation
import SwiftUI

extension HomeView {
    class HomeViewModel: ObservableObject {
        @Published var image: Image?
        @Published var filterIntensity: Double = 0.5
        @Published var showingfilterIntensity: Bool = false
        
        func changeFilter() {
            
        }
        
        func save() {
            
        }
    }
}
