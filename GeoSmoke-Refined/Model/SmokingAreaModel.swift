//
//  SmokingAreaModel.swift
//  GeoSmoke-Refined
//
//  Created by Johansen Marlee on 16/04/25.
//

import SwiftData

@Model
class SmokingArea{
    var name: String
    var location: String
    var longitude: Double
    var latitude: Double
    var photoURL: String
    var disposalPhotoURL: String
    var disposalDirection: String
    
    @Relationship(deleteRule: .cascade) var facilities: [Facility]
    var isFavorite: Bool
    @Relationship(deleteRule: .cascade) var allPhoto: [LocationAllPhoto]
    var facilityGrade: String
    
    var ambience: String
    var crowdLevel: String
    var smokingTypes: [String]
    
    init(
        name: String,
        location: String,
        latitude: Double,
        longitude: Double,
        photoURL: String,
        disposalPhotoURL: String,
        disposalDirection: String,
        facilities: [Facility],
        isFavorite: Bool,
        allPhoto: [LocationAllPhoto],
        facilityGrade: String,
        ambience: String,
        crowdLevel: String,
        smokingTypes: [String]
    ) {
        self.name = name
        self.location = location
        self.latitude = latitude
        self.longitude = longitude
        self.photoURL = photoURL
        self.disposalPhotoURL = disposalPhotoURL
        self.disposalDirection = disposalDirection
        self.facilities = facilities
        self.isFavorite = isFavorite
        self.allPhoto = allPhoto
        self.facilityGrade = facilityGrade
        
        self.ambience = ambience
        self.crowdLevel = crowdLevel
        self.smokingTypes = smokingTypes
    }
}



@Model
class Facility {
    var name: String
    init(name: String) {
        self.name = name
    }
}

@Model
class LocationAllPhoto {
    var photo: String
    
    init(photo: String) {
        self.photo = photo
    }
}



extension SmokingArea {
    var facilityNames: [String] {
        facilities.map { $0.name }
    }
}
