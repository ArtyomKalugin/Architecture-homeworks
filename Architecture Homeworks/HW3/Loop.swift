//
//  Loop.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

final class Loop {
    
    // MARK: - Propeties
    
    var shouldContinue = true
    
    // MARK: - Methods
    
    func start(maxCount: Int) {
        var count = 1
        
        while(shouldContinue) {
            if count == maxCount {
                shouldContinue = false
                break
            }
            
            guard let command = CommandsQueue.shared.getLast() else {
                break
            }
            
            do {
                try command.execute()
            } catch let error {
                try? ExceptionHandler.shared.handle(
                    command: command,
                    error: error
                ).execute()
            }
            
            count += 1
        }
    }
}
