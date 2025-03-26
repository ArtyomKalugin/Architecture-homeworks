//
//  HardStopCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.03.2025.
//

import Foundation

final class HardStopCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let eventLoop: EventLoop?
    
    // MARK: - Init
    
    init(eventLoop: EventLoop?) {
        self.eventLoop = eventLoop
    }
    
    // MARK: - Methods
    
    func execute() throws {
        eventLoop?.stop()
    }
}
