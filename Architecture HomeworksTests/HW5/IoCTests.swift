//
//  IoCTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 02.03.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class IoCTests: XCTestCase {
    
    // MARK: - Properties
    
    final class MockClass { }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        let scope: ScopeStorage = try IoC.shared.resolve(scope: "Scope.Current", args: [])
        scope.storage["MockClass"] = nil
    }
    
    // MARK: - Tests

    func testRegisterCommand() throws {
        // Arrange
        let registerCommand = RegisterCommand("Scope.Current", String(describing: MockClass.self)) { _ in
            return MockClass()
        }
        
        // Act
        try registerCommand.execute()
        
        // Assert
        let mockClass: MockClass = try IoC.shared.resolve(
            dependency: String(describing: MockClass.self),
            args: []
        )
        XCTAssertEqual(String(describing: mockClass.self), "Architecture_HomeworksTests.IoCTests.MockClass")
    }
    
    func testGetFromContainerSuccess() throws {
        // Arrange
        let creationHandler: ([Any]) -> AnyObject = { _ in return MockClass() as AnyObject }
        let registerCommand: RegisterCommand<AnyObject> = try IoC.shared.resolve(
            dependency: "RegisterCommand",
            args: [
                "Scope.Current",
                String(describing: MockClass.self),
                creationHandler
            ]
        )
        
        // Act
        try registerCommand.execute()
        
        // Assert
        let mockClass: MockClass = try IoC.shared.resolve(
            dependency: String(describing: MockClass.self),
            args: []
        )
        XCTAssertEqual(String(describing: mockClass.self), "Architecture_HomeworksTests.IoCTests.MockClass")
    }
    
    func testGetFromContainerFailure() throws {
        // Assert
        let mockClass: MockClass? = try? IoC.shared.resolve(
            dependency: String(describing: MockClass.self),
            args: []
        )
        XCTAssertNil(mockClass)
    }
    
    func testGetFromContainerAsync() throws {
        let dispatchSemaphore = DispatchSemaphore(value: 0)
        var asyncMockClass: MockClass?
        DispatchQueue.global().async {
            // Arrange
            let creationHandler: ([Any]) -> AnyObject = { _ in return MockClass() as AnyObject }
            let registerCommand: RegisterCommand<AnyObject>? = try? IoC.shared.resolve(
                dependency: "RegisterCommand",
                args: [
                    "Scope.Global",
                    String(describing: MockClass.self),
                    creationHandler
                ]
            )
            // Act
            try? registerCommand?.execute()
            asyncMockClass = try? IoC.shared.resolve(
                scope: "Scope.Global",
                dependency: String(describing: MockClass.self),
                args: []
            )
            
            dispatchSemaphore.signal()
        }
        
        // Arrange
        let creationHandler: ([Any]) -> AnyObject = { _ in return MockClass() as AnyObject }
        let registerCommand: RegisterCommand<AnyObject> = try IoC.shared.resolve(
            dependency: "RegisterCommand",
            args: [
                "Scope.Current",
                String(describing: MockClass.self),
                creationHandler
            ]
        )
        
        // Act
        try registerCommand.execute()
        let mockClass: MockClass = try IoC.shared.resolve(
            dependency: String(describing: MockClass.self),
            args: []
        )
        
        dispatchSemaphore.wait()
        
        // Assert
        guard let asyncMockClass = asyncMockClass else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(String(describing: mockClass.self), "Architecture_HomeworksTests.IoCTests.MockClass")
        XCTAssertEqual(String(describing: asyncMockClass.self), "Architecture_HomeworksTests.IoCTests.MockClass")
    }
}
