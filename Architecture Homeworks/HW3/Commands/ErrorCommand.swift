//
//  ErrorCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 21.02.2025.
//

import Foundation

final class ErrorCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let error: Error?
    
    // MARK: - Init
    
    init(command: CommandProtocol?, error: Error?) {
        self.error = error
    }
    
    // MARK: - Methods
    
    func execute() throws {
        throw error ?? NSError()
    }
}
