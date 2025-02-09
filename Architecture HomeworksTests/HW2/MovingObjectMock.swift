//
//  MovingObjectMock.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import Foundation
@testable import Architecture_Homeworks

final class MovingObjectMock: MovingObject {
    
    // MARK: - Private properties
    
    private var location: CGPoint
    private var velocity: CGVector
    
    // MARK: - Init
    
    init(location: CGPoint, velocity: CGVector) {
        self.location = location
        self.velocity = velocity
    }
    
    // MARK: - Methods
    
    func getLocation() -> CGPoint {
        location
    }
    
    func getVelocity() -> CGVector {
        velocity
    }
    
    func setLocation(_ point: CGPoint) throws {
        if point.x.isInfinite || point.y.isInfinite {
            throw NSError(domain: "infinity!", code: 1)
        } else if point.x.isNaN || point.y.isNaN {
            throw NSError(domain: "nan!", code: 1)
        }
        
        location = point
    }
}
