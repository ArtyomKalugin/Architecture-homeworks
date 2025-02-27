//
//  BurnFuelCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

import Foundation

final class BurnFuelCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let fuelableObject: FuelableObject
    
    // MARK: - Init
    
    init(fuelableObject: FuelableObject) {
        self.fuelableObject = fuelableObject
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let fuelLevel = try fuelableObject.getFuel()
        let fuelConsumptionVelocity = try fuelableObject.getFuelConsumptionVelocity()
        let currentFuelLevel = fuelLevel - fuelConsumptionVelocity
        
        try fuelableObject.setFuel(currentFuelLevel)
    }
}
