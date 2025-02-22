//
//  CommandsTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 22.02.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class CommandsTests: XCTestCase {
    
    // MARK: - Private properties
    
    private let loop = Loop()
    
    // MARK: - Tear down
    
    override func tearDown() {
        ExceptionHandler.shared.removeAll()
     }
    
    // MARK: - Tests

    func testWriteToLogCommand() throws {
        // Assert
        let writeToLogCommand = WriteToLogCommand(
            command: nil,
            error: NSError()
        )
        
        // Act
        try writeToLogCommand.execute()
        
        // Assert
        XCTAssertEqual(Log.shared.getLog(), "ERROR: Optional<Error>")
    }
    
    func testAddToQueueCommand() throws {
        // Assert
        let emptyCommand = EmptyCommand(command: nil, error: nil)
        let addToQueueCommand = AddToQueueCommand(
            command: emptyCommand,
            error: nil
        )
        
        // Act
        try addToQueueCommand.execute()
        
        // Assert
        let lastCommand = CommandsQueue.shared.getLast()
        XCTAssertTrue(lastCommand.self === emptyCommand.self)
    }
    
    // Пункт 5
    func testAddToQueueHandler() throws {
        // Assert
        CommandsQueue.shared.append(ErrorCommand(command: nil, error: NSError()))
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Act
        loop.start(maxCount: 3)
        
        // Assert
        XCTAssertEqual(Log.shared.getLog(), "ERROR: Optional<Error>")
    }
    
    func testRepeatCommand() throws {
        // Assert
        let repeatCommand = RepeatOnceCommand(
            command: WriteToLogCommand(
                command: nil,
                error: NSError()
            ),
            error: nil
        )
        
        // Act
        try repeatCommand.execute()
        
        // Assert
        XCTAssertEqual(Log.shared.getLog(), "ERROR: Optional<Error>")
    }
    
    // Пункт 7
    func testRepeatErrorHandler() throws {
        // Assert
        CommandsQueue.shared.append(ErrorCommand(command: nil, error: NSError()))
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Act
        loop.start(maxCount: 3)
        
        // Assert
        let lastCommand = CommandsQueue.shared.getLast()
        XCTAssertTrue(lastCommand == nil)
    }
    
    // Пункт 8
    func testRepeatAndWriteToLogHandler() throws {
        // Assert
        CommandsQueue.shared.append(ErrorCommand(command: nil, error: NSError()))
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatOnceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Act
        loop.start(maxCount: 4)
        
        // Assert
        XCTAssertEqual(Log.shared.getLog(), "ERROR: Optional<Error>")
    }
    
    // Пункт 9
    func testRepeatTwiceAndWriteToLogHandler() throws {
        // Assert
        CommandsQueue.shared.append(ErrorCommand(command: nil, error: NSError()))
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatTwiceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatTwiceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatOnceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Act
        loop.start(maxCount: 5)
        
        // Assert
        XCTAssertEqual(Log.shared.getLog(), "ERROR: Optional<Error>")
    }
}
