//
//  FacilityFilterViewModel.swift
//  GeoSmoke-Refined
//
//  Created by Ageng Tawang Aryonindito on 21/04/25.
//

import Foundation
import SwiftData
import SwiftUI

class FacilityFilterViewModel: ObservableObject {
    @Query var smokingAreas: [SmokingArea]
    @Published var selectedArea: SmokingArea? = nil
    
    private let gradeOrder: [String: Int] = [
        "High": 0,
        "Moderate": 1,
        "Low": 2
    ]
    
    var sortedSmokingAreas: [SmokingArea] {
        smokingAreas.sorted {
            (gradeOrder[$0.facilityGrade] ?? 3) < (gradeOrder[$1.facilityGrade] ?? 3)
        }
    }
    
    
    func select(area: SmokingArea) {
        selectedArea = area
    }
}
