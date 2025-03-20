//
//  EventLoop.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.03.2025.
//

import Foundation

final class EventLoop {
    
    // MARK: - Private properties
    
    private var queue = [CommandProtocol]()
    private let lock = NSLock()
    private var shouldContinue = true
    
    // MARK: - Methods
    
    var behaviour: () -> Void
    var actionAfterStop: (() -> Void)?
    
    // MARK: - Init
    
    init() {
        behaviour = { }
        behaviour = {
            let command = self.getLast()
            do {
                try command?.execute()
            } catch let error {
                let handleCommand: HandleCommand? = try? IoC.shared.resolve(
                    dependency: String(describing: HandleCommand.self),
                    args: [error]
                )
                try? handleCommand?.execute()
            }
        }
    }
    
    // MARK: - Methods
    
    func start() {
        DispatchQueue.global().async {
            while(self.shouldContinue) {
                self.behaviour()
            }
            
            self.actionAfterStop?()
        }
    }
    
    func append(_ element: CommandProtocol) {
        lock.lock()
        queue.append(element)
        lock.unlock()
    }
    
    func getQueueCount() -> Int {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        return queue.count
    }
    
    func stop() {
        shouldContinue = false
    }
    
    // MARK: - Private methods
    
    private func getLast() -> CommandProtocol? {
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
}
