//
//  AddToEventLoopCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 28.03.2025.
//

import Foundation

final class AddToEventLoopCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let command: CommandProtocol?
    private let eventLoop: EventLoop?
    
    // MARK: - Init
    
    init(command: CommandProtocol?, eventLoop: EventLoop?) {
        self.command = command
        self.eventLoop = eventLoop
    }
    
    // MARK: - Methods
    
    func execute() throws {
        guard let command, let eventLoop else { throw NSError() }
        
        eventLoop.append(command)
    }
}
