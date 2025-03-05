//
//  RegisterCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 01.03.2025.
//

import Foundation

final class RegisterCommand<T: AnyObject>: CommandProtocol {
    
    // MARK: - Private properties
    
    private let creationHandler: ([Any]) -> T
    private let dependency: String
    private let scope: String
    private let lock = NSLock()
    
    // MARK: - Init
    
    init(
        _ scope: String,
        _ dependency: String,
        _ creationHandler: @escaping ([Any]) -> T
    ) {
        self.scope = scope
        self.dependency = dependency
        self.creationHandler = creationHandler
    }
    
    // MARK: - Methods
    
    func execute() throws {
        lock.lock()
        let scope: ScopeStorage = try IoC.shared.resolve(scope: scope, args: [])
        scope.storage[dependency] = creationHandler
        lock.unlock()
    }
}

