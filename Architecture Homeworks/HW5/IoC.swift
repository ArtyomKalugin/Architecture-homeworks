//
//  IoC.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 01.03.2025.
//

import Foundation


final class IoC {
    
    // MARK: - Properties
    
    static let shared = IoC()
    
    // MARK: - Private properties
    
    private var objects = [String: ScopeStorage]()
    private let lock = NSLock()
    
    // MARK: - Private init
    
    private init() {
        let registerCommandHandler: ([Any]) -> AnyObject = { args in
            let scope = args[0] as? String ?? "Scope.Current"
            let dependency = args[1] as! String
            let creationHandler = args[2] as! ([Any]) -> AnyObject
            
            return RegisterCommand(scope, dependency, creationHandler)
        }
        
        let scopeStorage = ScopeStorage()
        scopeStorage.storage["RegisterCommand"] = registerCommandHandler
        objects["Scope.Current"] = scopeStorage
    }
    
    // MARK: - Methods
    
    func resolve<T>(
        scope: String = "Scope.Current",
        dependency: String? = nil,
        args: [Any]
    ) throws -> T {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        if let dependency = dependency {
            if let object = objects[scope]?.storage[dependency] {
                let type = object(args)
                return type as! T
            }
        } else {
            if objects[scope] == nil {
                objects[scope] = ScopeStorage()
            }
            
            return objects[scope] as! T
        }
        
        throw NSError()
    }
}
