//
//  EmptyCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 22.02.2025.
//

import Foundation

final class EmptyCommand: CommandProtocol {
    
    // MARK: - Init
    
    init(command: CommandProtocol?, error: Error?) { }
    
    // MARK: - Methods
    
    func execute() throws { }
}
