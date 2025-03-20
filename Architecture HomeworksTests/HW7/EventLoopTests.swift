//
//  EventLoopTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 20.03.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class EventLoopTests: XCTestCase {

    // MARK: - Tests

    func testHardStopSuccess() throws {
        // Arrange
        let semaphore = DispatchSemaphore(value: .zero)
        let eventLoop = EventLoop()
        eventLoop.actionAfterStop = { semaphore.signal() }
        var counter = 0
        
        // Act
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(HardStopCommand(eventLoop: eventLoop))
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.start()
        
        // Assert
        semaphore.wait()
        XCTAssert(counter == 2)
    }
    
    func testSoftStopSuccess() throws {
        // Arrange
        let semaphore = DispatchSemaphore(value: .zero)
        let eventLoop = EventLoop()
        eventLoop.actionAfterStop = { semaphore.signal() }
        var counter = 0
        
        // Act
        eventLoop.append(SoftStopCommand(eventLoop: eventLoop))
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.append(UniversalCommand { counter += 1 })
        eventLoop.start()
        
        // Assert
        semaphore.wait()
        XCTAssert(counter == 4)
    }
}
