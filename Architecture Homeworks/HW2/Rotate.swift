//
//  Rotate.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import Foundation

class Rotate {
    
    // MARK: - Private properties
    
    private let rotatableObject: RotatableObject
    
    // MARK: - Init
    
    init(rotatableObject: RotatableObject) {
        self.rotatableObject = rotatableObject
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let direction = rotatableObject.getDirection()
        let angularVelocity = rotatableObject.getAngularVelocity()
        let directionsNumber = rotatableObject.getDirectionsNumber()
        
        try rotatableObject.setDirection(
            (direction + angularVelocity) % directionsNumber
        )
    }
}

