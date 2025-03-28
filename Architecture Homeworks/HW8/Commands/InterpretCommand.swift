//
//  InterpretCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 27.03.2025.
//

import Foundation

final class InterpretCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let objectId: String
    private let commandId: String
    private let args: [String]
    private let eventLoop: EventLoop?
    
    // MARK: - Init
    
    init(
        objectId: String,
        commandId: String,
        args: [String],
        eventLoop: EventLoop?
    ) {
        self.objectId = objectId
        self.commandId = commandId
        self.args = args
        self.eventLoop = eventLoop
    }
    
    // MARK: - Methods
    
    func execute() throws {
        let gameObject: AnyObject = try IoC.shared.resolve(
            dependency: String(describing: AnyObject.self),
            args: [objectId]
        )
        let command: CommandProtocol = try IoC.shared.resolve(
            dependency: String(describing: CommandProtocol.self),
            args: [commandId, gameObject, args]
        )
        let addToEventLoopCommand: AddToEventLoopCommand = try IoC.shared.resolve(
            dependency: String(describing: AddToEventLoopCommand.self),
            args: [command, eventLoop]
        )
        try addToEventLoopCommand.execute()
    }
}
