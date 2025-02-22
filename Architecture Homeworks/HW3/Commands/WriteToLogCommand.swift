//
//  WriteToLogCommand.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

final class WriteToLogCommand: CommandProtocol {
    
    // MARK: - Private properties
    
    private var error: Error?
    
    // MARK: - Init
    
    init(command: CommandProtocol?, error: Error?) {
        self.error = error
    }
    
    // MARK: - Methods
    
    func execute() throws {
        Log.shared.writeToLog("ERROR: \(String(describing: type(of: error)))")
    }
}
