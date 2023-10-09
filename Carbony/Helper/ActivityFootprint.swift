//
//  ActivityFootprint.swift
//  Carbony
//
//  Created by doss-zstch1212 on 28/09/23.
//

import Foundation

class ActivityFootprint {
    let distance: Double
    let fuelEmission: Double
    let emissionFactor: Double
    let frequency: Int
    let electricityConsumed: Double
    let electricalSource: ElectricitySource
    
    init(distance: Double, fuelEmission: Double, emissionFactor: Double, frequency: Int, electricityConsumed: Double, electricalSource: ElectricitySource) {
        self.distance = distance
        self.fuelEmission = fuelEmission
        self.emissionFactor = emissionFactor
        self.frequency = frequency
        self.electricityConsumed = electricityConsumed
        self.electricalSource = electricalSource
    }
}
