//
//  FavoriteFilterViewModel.swift
//  GeoSmoke-Refined
//
//  Created by Ageng Tawang Aryonindito on 21/04/25.
//

import Foundation
import SwiftUI
import SwiftData

class FavoriteFilterViewModel: ObservableObject {
    @Published var selectedArea: SmokingArea? = nil

    var onSelect: ((SmokingArea) -> Void)?

    func select(area: SmokingArea) {
        selectedArea = area
        onSelect?(area)
    }
}
