//
//  RepeatTwiceCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 22.02.2025.
//

import Foundation

final class RepeatTwiceCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let command: CommandProtocol?
    
    // MARK: - Init
    
    init(command: CommandProtocol?, error: Error?) {
        self.command = command
    }
    
    // MARK: - Methods
    
    func execute() throws {
        try command?.execute()
    }
}
