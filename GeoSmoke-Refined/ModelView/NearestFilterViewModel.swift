//
//  NearestFilterViewModel.swift
//  GeoSmoke-Refined
//
//  Created by Ageng Tawang Aryonindito on 21/04/25.
//

import Foundation
import SwiftData
import CoreLocation

@MainActor
class NearestFilterViewModel: ObservableObject {
    @Published var userLocation: CLLocation?
    @Published var distances: [PersistentIdentifier: Double] = [:]
    @Published var selectedArea: SmokingArea? = nil

    private var locationManager = LocationManager.shared

    func requestUserLocationAndCalculateDistances(smokingAreas: [SmokingArea]) {
        locationManager.requestUserLocation { [weak self] location in
            guard let self = self, let location = location else { return }
            self.userLocation = location
            self.calculateAllDistances(from: location, smokingAreas: smokingAreas)
        }
    }

    private func calculateAllDistances(from location: CLLocation, smokingAreas: [SmokingArea]) {
        var newDistances: [PersistentIdentifier: Double] = [:]
        for area in smokingAreas {
            let areaLocation = CLLocation(latitude: area.latitude, longitude: area.longitude)
            newDistances[area.persistentModelID] = location.distance(from: areaLocation)
        }
        distances = newDistances
    }

    func sortByDistance(_ a: SmokingArea, _ b: SmokingArea) -> Bool {
        let d1 = distances[a.persistentModelID] ?? .greatestFiniteMagnitude
        let d2 = distances[b.persistentModelID] ?? .greatestFiniteMagnitude
        return d1 < d2
    }
}
