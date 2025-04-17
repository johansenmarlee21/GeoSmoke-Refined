//
//  MapView.swift
//  GeoSmoke-Refined
//
//  Created by Johansen Marlee on 16/04/25.
//

import SwiftUI
import MapKit
import SwiftData

struct MapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    @Query private var locations: [SmokingArea]
    @State private var selectedLocation: SmokingArea?
    
    @ObservedObject private var locationManager = LocationManager.shared
    @State private var hasCenteredOnUser = false
    @State private var routeCoordinates: [CLLocationCoordinate2D] = []

    var body: some View {
        Map(position: $cameraPosition, selection: $selectedLocation) {
            UserAnnotation()

            ForEach(locations, id: \.self) { location in
                Marker(location.name,
                       coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                .tint(.red)
                .tag(location)
            }

        }
        .mapStyle(.hybrid(pointsOfInterest: .excludingAll))
        .onAppear {
            locationManager.requestLocationAccess()
            let center = CLLocationCoordinate2D(latitude: -6.301454, longitude: 106.651853)
//            let center = CLLocationCoordinate2D(latitude: 37.785834, longitude: -122.406417)
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            cameraPosition = .region(MKCoordinateRegion(center: center, span: span))
            cameraPosition = .userLocation(followsHeading: true, fallback: MapCameraPosition.automatic)
        }

        .sheet(item: $selectedLocation) { location in
            DetailView(area: location)
                .presentationDetents([.fraction(2/3)])
                .presentationBackgroundInteraction(.enabled)
                .padding(.top, 20)
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: SmokingArea.self, Facility.self, LocationAllPhoto.self, configurations: config)
    
    UserDefaults.standard.set(false, forKey: SmokingAreaSeeder.preloadKey)
    
    SmokingArea.seedDataIfNeeded(context: container.mainContext)
    
    return MapView()
        .modelContainer(container)
}

