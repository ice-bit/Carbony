//
//  Footprint.swift
//  Carbony
//
//  Created by doss-zstch1212 on 31/08/23.
//

import Foundation

class CarbonFootprint {
    let uuid: UUID
    let emissionValue: Double
    let footprintType: String
    let date: Date
    
    init(uuid: UUID, emissionValue: Double, footprintType: String, date: Date) {
        self.uuid = uuid
        self.emissionValue = emissionValue
        self.footprintType = footprintType
        self.date = date
    }
}
