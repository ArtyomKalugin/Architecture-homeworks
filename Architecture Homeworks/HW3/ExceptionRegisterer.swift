//
//  ExceptionRegisterer.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

struct ExceptionRegisterer {
    
    static func registerHandlers() {
        // Обработчик 5
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Обработчик 7
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Обработчик 8
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatOnceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        // Обработчик 9
        ExceptionHandler.shared.register(
            commandType: String(describing: ErrorCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatTwiceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatTwiceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: RepeatOnceCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
        
        ExceptionHandler.shared.register(
            commandType: String(describing: RepeatOnceCommand.self),
            errorType: String(describing: NSError.self),
            handler: { command, error in
                return AddToQueueCommand(
                    command: WriteToLogCommand(
                        command: command,
                        error: error
                    ),
                    error: error
                )
            }
        )
    }
}
