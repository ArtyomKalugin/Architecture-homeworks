//
//  RepeatOnceCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

final class RepeatOnceCommand: CommandProtocol {
    
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
