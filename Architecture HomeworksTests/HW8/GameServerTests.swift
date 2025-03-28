//
//  GameServerTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 28.03.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class GameServerTests: XCTestCase {
    
    final class MockClass: AnyObject { }
    
    // MARK: - Tests
    
    func testGameServerSuccess() throws {
        // Arrange
        let eventLoop = EventLoop()
        let gameServer = GameServer(games: ["1": eventLoop])
        
        let creationHandler: ([Any]) -> AnyObject = { _ in return MockClass() as AnyObject }
        let registerCommand: RegisterCommand<AnyObject> = try IoC.shared.resolve(
            dependency: "RegisterCommand",
            args: [
                "Scope.Current",
                String(describing: AnyObject.self),
                creationHandler
            ]
        )
        try registerCommand.execute()
        
        
        // Act
        
        
        // Assert
        
    }
}
