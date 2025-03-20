//
//  UniversalCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 20.03.2025.
//

import Foundation

final class UniversalCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private let action: () -> Void
    
    // MARK: - Init
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    // MARK: - Methods
    
    func execute() throws {
        action()
    }
}
