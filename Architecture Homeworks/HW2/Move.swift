//
//  Move.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import Foundation

class Move {
    
    // MARK: - Private properties
    
    private let movingObject: MovingObject
    
    // MARK: - Init
    
    init(movingObject: MovingObject) {
        self.movingObject = movingObject
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let location = movingObject.getLocation()
        if location.x.isInfinite || location.y.isInfinite {
            throw NSError(domain: "infinity!", code: 1)
        } else if location.x.isNaN || location.y.isNaN {
            throw NSError(domain: "nan!", code: 1)
        }
        
        let velocity = movingObject.getVelocity()
        if velocity.dx.isInfinite || velocity.dy.isInfinite {
            throw NSError(domain: "infinity!", code: 1)
        } else if velocity.dx.isNaN || velocity.dy.isNaN {
            throw NSError(domain: "nan!", code: 1)
        }
        
        try movingObject.setLocation(
            .init(x: location.x + velocity.dx, y: location.y + velocity.dy)
        )
    }
}
