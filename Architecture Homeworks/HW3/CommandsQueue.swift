//
//  CommandsQueue.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

final class CommandsQueue {
    
    static var shared = CommandsQueue()
    private var queue = [CommandProtocol]()
    private let lock = NSLock()
    
    private init() { }
    
    func getLast() -> CommandProtocol? {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        if queue.isEmpty {
            return nil
        } else {
            return queue.removeFirst()
        }
    }
    
    func append(_ element: CommandProtocol) {
        lock.lock()
        queue.append(element)
        lock.unlock()
    }
}
