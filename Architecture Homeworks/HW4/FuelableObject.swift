//
//  FuelableObject.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

protocol FuelableObject {
    
    func getFuel() throws -> Double
    
    func setFuel(_ fuel: Double) throws
    
    func getFuelConsumptionVelocity() throws -> Double
    
    func setFuelConsumptionVelocity(_ velocity: Double) throws
}
