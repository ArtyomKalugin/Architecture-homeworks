//
//  UniversalObject.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

import Foundation

final class UniversalObject: FuelableObject, MovingObject, RotatableObject {
    
    // MARK: - Private properties
    
    private var location: CGPoint
    private var velocity: CGVector
    private var direction: Int
    private var directionsNumber: Int
    private var angularVelocity: Int
    private var fuel: Double
    private var fuelConsumptionVelocity: Double
    
    // MARK: - Init
    
    init(
        location: CGPoint,
        velocity: CGVector,
        direction: Int,
        directionsNumber: Int,
        angularVelocity: Int,
        fuel: Double,
        fuelConsumptionVelocity: Double
    ) {
        self.location = location
        self.velocity = velocity
        self.direction = direction
        self.directionsNumber = directionsNumber
        self.angularVelocity = angularVelocity
        self.fuel = fuel
        self.fuelConsumptionVelocity = fuelConsumptionVelocity
    }
    
    func getFuel() throws -> Double {
        if fuel.isNaN || fuel.isInfinite {
            throw NSError()
        }
        
        return fuel
    }
    
    func setFuel(_ fuel: Double) throws {
        if fuel < 0 {
            throw NSError()
        }
        
        self.fuel = fuel
    }
    
    func getFuelConsumptionVelocity() throws -> Double {
        if fuelConsumptionVelocity.isNaN || fuelConsumptionVelocity.isInfinite {
            throw NSError()
        }
        
        return fuelConsumptionVelocity
    }
    
    func setFuelConsumptionVelocity(_ velocity: Double) throws {
        if fuelConsumptionVelocity <= 0 {
            throw NSError()
        }
        
        fuelConsumptionVelocity = velocity
    }
    
    func getLocation() -> CGPoint {
        return location
    }
    
    func getVelocity() -> CGVector {
        return velocity
    }
    
    func setLocation(_ point: CGPoint) throws {
        location = point
    }
    
    func getDirection() -> Int {
        return direction
    }
    
    func getDirectionsNumber() -> Int {
        return directionsNumber
    }
    
    func getAngularVelocity() -> Int {
        return angularVelocity
    }
    
    func setDirection(_ direction: Int) throws {
        if direction < 0 {
            throw NSError()
        }
        
        self.direction = direction
    }
}
