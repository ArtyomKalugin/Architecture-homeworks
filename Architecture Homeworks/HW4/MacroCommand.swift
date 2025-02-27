//
//  MacroCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 25.02.2025.
//

import Foundation

final class MacroCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private var commands: [CommandProtocol]
    
    // MARK: - Init
    
    init(commands: [CommandProtocol]) {
        self.commands = commands
    }
    
    // MARK: - Methods
    
    func execute() throws {
        for command in commands {
            do {
                try command.execute()
            } catch _ {
                throw CommandError()
            }
        }
    }
}
