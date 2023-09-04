//
//  Footprint.swift
//  Carbony
//
//  Created by doss-zstch1212 on 31/08/23.
//

import Foundation

class Footprint {
    let footprintUUID: UUID
    let emissionValue: Int
    
    init(footprintUUID: UUID, emissionValue: Int) {
        self.footprintUUID = footprintUUID
        self.emissionValue = emissionValue
    }
}
