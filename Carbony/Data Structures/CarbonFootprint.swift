//
//  Footprint.swift
//  Carbony
//
//  Created by doss-zstch1212 on 31/08/23.
//

import Foundation

class CarbonFootprint {
    let id: UUID
    let emissionValue: Double
    let footprintType: ActivityType
    let date: Date
    
    init(id: UUID, emissionValue: Double, footprintType: ActivityType, date: Date) {
        self.id = id
        self.emissionValue = emissionValue
        self.footprintType = footprintType
        self.date = date
    }
}
