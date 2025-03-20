//
//  SoftStopCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.03.2025.
//

import Foundation

final class SoftStopCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let eventLoop: EventLoop
    
    // MARK: - Init
    
    init(eventLoop: EventLoop) {
        self.eventLoop = eventLoop
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let oldBehaviour = eventLoop.behaviour
        eventLoop.behaviour = {
            if self.eventLoop.getQueueCount() > 0 {
                oldBehaviour()
            } else {
                self.eventLoop.stop()
            }
        }
    }
}
