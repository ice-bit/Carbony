//
//  CarbonFootprintController.swift
//  Carbony
//
//  Created by doss-zstch1212 on 27/09/23.
//

import Foundation

class CarbonFootprintController {
    func calculateDrivingEmission(distance: Double, fuelEfficiency: Double, frequency: Int, emissionFactor: Double) -> Double {
        let co2EmissionInKg = (distance / fuelEfficiency) * emissionFactor
        let roundedEmission = round(co2EmissionInKg * 100) / 100
        
        return roundedEmission
    }
    
    func calculateElectricityEmission(electricityConsumedKWh: Double, electricitySource: ElectricitySource) -> Double {
        let emissionFactor: Double = getEmissionFactor(source: electricitySource)
        let emissionKg: Double = electricityConsumedKWh * emissionFactor
        let roundedEmission = round(emissionKg * 100) / 100
        
        return roundedEmission
    }
    
    func getEmissionFactor(source: ElectricitySource) -> Double {
        switch source {
        case .coal:
            return 1.3
        case .naturalGas:
            return 0.6
        case .oil:
            return 1.2
        case .nuclear:
            return 0
        case .hydropower:
            return 0
        case .wind:
            return 0
        case .solar:
            return 0
        case .biomass:
            return 0.5
        }
    }
    
    func updateTotalFootprint(with value: Double) {
        let currentFootprint = UserDefaults.standard.double(forKey: "totalFootprint")
        let updatedFootprint = currentFootprint + value
        // Set the updated footprint to the UserDefaults
        UserDefaults.standard.setValue(updatedFootprint, forKey: "totalFootprint")
    }

}
