//
//  HandleCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.03.2025.
//

import Foundation

final class HandleCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let error: Error?
    
    // MARK: - Init
    
    init(error: Error?) {
        self.error = error
    }
    
    // MARK: - Methods
    
    func execute() throws {
        // Do something...
    }
}
