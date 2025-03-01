//
//  MacroCommandsTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class MacroCommandsTests: XCTestCase {
    
    // MARK: - Tests

    func testCheckFuelCommandSuccess() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: .zero,
            directionsNumber: .zero,
            angularVelocity: .zero,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let checkFuelCommand = CheckFuelCommand(fuelableObject: universalObject)
        
        // Assert
        XCTAssertNoThrow(try checkFuelCommand.execute())
    }
    
    func testCheckFuelCommandFailure() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: .zero,
            directionsNumber: .zero,
            angularVelocity: .zero,
            fuel: 10,
            fuelConsumptionVelocity: 20
        )
        let checkFuelCommand = CheckFuelCommand(fuelableObject: universalObject)
        
        // Assert
        XCTAssertThrowsError(try checkFuelCommand.execute())
    }
    
    func testBurnFuelCommandSuccess() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: .zero,
            directionsNumber: .zero,
            angularVelocity: .zero,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let burnFuelCommand = BurnFuelCommand(fuelableObject: universalObject)
        
        // Act
        try burnFuelCommand.execute()
        
        // Assert
        XCTAssertEqual(try universalObject.getFuel(), 90)
    }
    
    func testBurnFuelCommandFailure() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: .zero,
            directionsNumber: .zero,
            angularVelocity: .zero,
            fuel: .nan,
            fuelConsumptionVelocity: 10
        )
        let burnFuelCommand = BurnFuelCommand(fuelableObject: universalObject)
        
        // Assert
        XCTAssertThrowsError(try burnFuelCommand.execute())
    }
    
    func testChanngeVelocityCommandSuccess() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: 10,
            directionsNumber: 360,
            angularVelocity: 36,
            fuel: .zero,
            fuelConsumptionVelocity: .zero
        )
        let changeVelocityCommand = ChangeVelocityCommand(rotatableObject: universalObject)
        
        // Act
        try changeVelocityCommand.execute()
        
        // Assert
        XCTAssertEqual(universalObject.getDirection(), 46)
    }
    
    func testChangeVelocityCommandFailure() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: -10,
            directionsNumber: -360,
            angularVelocity: -36,
            fuel: .zero,
            fuelConsumptionVelocity: .zero
        )
        let changeVelocityCommand = ChangeVelocityCommand(rotatableObject: universalObject)
        
        // Assert
        XCTAssertThrowsError(try changeVelocityCommand.execute())
    }
    
    func testMacroCommandSuccess() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: 10,
            directionsNumber: 360,
            angularVelocity: 36,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let macroCommand = MacroCommand(
            commands: [
                ChangeVelocityCommand(rotatableObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )
        
        // Act
        try macroCommand.execute()
        
        // Assert
        XCTAssertEqual(universalObject.getDirection(), 46)
        XCTAssertEqual(try universalObject.getFuel(), 90)
    }
    
    func testMacroCommandFailure() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .zero,
            velocity: .zero,
            direction: -10,
            directionsNumber: -360,
            angularVelocity: -36,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let macroCommand = MacroCommand(
            commands: [
                ChangeVelocityCommand(rotatableObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )

        // Assert
        XCTAssertThrowsError(try macroCommand.execute())
    }
    
    func testMoveDirectlyCommand() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .init(x: 12, y: 5),
            velocity: .init(dx: -7, dy: 3),
            direction: 10,
            directionsNumber: 360,
            angularVelocity: 36,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let macroCommand = MacroCommand(
            commands: [
                CheckFuelCommand(fuelableObject: universalObject),
                MoveCommand(movingObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )
        
        // Act
        try macroCommand.execute()
        
        // Assert
        XCTAssertEqual(universalObject.getLocation(), .init(x: 5, y: 8))
        XCTAssertEqual(try universalObject.getFuel(), 90)
    }
    
    func testRotateAndMoveDirectlyCommand() throws {
        // Assert
        let universalObject = UniversalObject(
            location: .init(x: 12, y: 5),
            velocity: .init(dx: -7, dy: 3),
            direction: 10,
            directionsNumber: 360,
            angularVelocity: 36,
            fuel: 100,
            fuelConsumptionVelocity: 10
        )
        let macroCommand = MacroCommand(
            commands: [
                CheckFuelCommand(fuelableObject: universalObject),
                ChangeVelocityCommand(rotatableObject: universalObject),
                MoveCommand(movingObject: universalObject),
                BurnFuelCommand(fuelableObject: universalObject)
            ]
        )
        
        // Act
        try macroCommand.execute()
        
        // Assert
        XCTAssertEqual(universalObject.getLocation(), .init(x: 5, y: 8))
        XCTAssertEqual(try universalObject.getFuel(), 90)
        XCTAssertEqual(universalObject.getDirection(), 46)
    }
}
