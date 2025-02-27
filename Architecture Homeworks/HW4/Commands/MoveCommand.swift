//
//  MoveCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

import Foundation

final class MoveCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let movingObject: MovingObject
    
    // MARK: - Init
    
    init(movingObject: MovingObject) {
        self.movingObject = movingObject
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let location = movingObject.getLocation()
        let velocity = movingObject.getVelocity()
        
        try movingObject.setLocation(
            .init(x: location.x + velocity.dx, y: location.y + velocity.dy)
        )
    }
}
