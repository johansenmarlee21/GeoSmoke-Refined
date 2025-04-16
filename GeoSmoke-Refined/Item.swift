//
//  Item.swift
//  GeoSmoke-Refined
//
//  Created by Johansen Marlee on 16/04/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
