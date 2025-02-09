//
//  MoveTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class MoveTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var move: Move?
    
    // MARK: - Tear down
    
    override func tearDown() {
        move = nil
     }
    
    // MARK: - Tests

    func testDefaultValues() throws {
        // Assert
        let movingObject = MovingObjectMock(
            location: .init(x: 12, y: 5),
            velocity: .init(dx: -7, dy: 3)
        )
        move = .init(movingObject: movingObject)
        
        // Act
        try move?.execute()
        
        // Assert
        XCTAssertEqual(movingObject.getLocation(), .init(x: 5, y: 8))
    }
    
    func testInvalidLocation() throws {
        // Assert
        let movingObject = MovingObjectMock(
            location: .init(x: CGFloat.nan, y: CGFloat.nan),
            velocity: .init(dx: -7, dy: 3)
        )
        move = .init(movingObject: movingObject)
        
        // Assert
        XCTAssertThrowsError(try move?.execute())
    }
    
    func testInvalidVelocity() throws {
        // Assert
        let movingObject = MovingObjectMock(
            location: .init(x: 12, y: 5),
            velocity: .init(dx: CGFloat.nan, dy: CGFloat.nan)
        )
        move = .init(movingObject: movingObject)
        
        // Assert
        XCTAssertThrowsError(try move?.execute())
    }
    
    func testInvalidSetLocation() throws {
        // Assert
        let movingObject = MovingObjectMock(
            location: .init(x: 12, y: 5),
            velocity: .init(dx: -7, dy: 3)
        )
        
        // Assert
        XCTAssertThrowsError(try movingObject.setLocation(.init(x: CGFloat.infinity, y: CGFloat.infinity)))
    }
}
