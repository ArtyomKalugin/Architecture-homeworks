//
//  ExceptionHandler.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

final class ExceptionHandler {
    
    // MARK: - Private properties
    
    private var store = [String: [String: (CommandProtocol, Error) -> CommandProtocol]]()
    
    // MARK: - Properties
    
    static var shared = ExceptionHandler()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Methods

    func handle(
        command: CommandProtocol,
        error: Error
    ) -> CommandProtocol {
        let commandType = String(describing: type(of: command))
        let exceptionType = String(describing: type(of: error))
        
        guard let handler = store[commandType]?[exceptionType] else {
            return command
        }
        
        return handler(command, error)
    }
    
    func register(
        commandType: String,
        errorType: String,
        handler: @escaping (CommandProtocol, Error) -> CommandProtocol
    ) {
        store[commandType] = [errorType: handler]
    }
    
    func removeAll() {
        store.removeAll()
    }
}
