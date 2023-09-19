//
//  CarbonFootprintCalculator.swift
//  Carbony
//
//  Created by doss-zstch1212 on 14/09/23.
//

import Foundation
// TODO: - Design the methods for carbon calculations
protocol CarbonFootprintCalculating {
    func calculateEmissions(forActivity activity: ActivityType) -> Double
    func calculateDrivingEmission(milesDriven: Double, fuelEfficiency: Double) -> Double
    func calculateElectricityEmission(usageKWh: Double, source: ElectricitySource) -> Double
}

/*class CarbonFootprintCalculator: CarbonFootprintCalculating {
    
    func calculateEmissions(forActivity activity: ActivityType) -> Double {
        var emissionResult: Double = 0.0
        switch activity {
        case .driving:
            emissionResult = calculateDrivingEmission(milesDriven: <#T##Double#>, fuelEfficiency: <#T##Double#>)
        case .electricity:
            emissionResult = calculateElectricityEmission(usageKWh: <#T##Double#>, source: <#T##ElectricitySource#>)
        }
        
        return emissionResult
    }
    
    func calculateDrivingEmission(milesDriven: Double, fuelEfficiency: Double) -> Double {
        <#code#>
    }
    
    func calculateElectricityEmission(usageKWh: Double, source: ElectricitySource) -> Double {
        <#code#>
    }
}*/
