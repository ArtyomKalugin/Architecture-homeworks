//
//  Log.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 22.02.2025.
//

import Foundation

final class Log {
    
    static var shared = Log()
    private var lastLog = ""
    private var lock = NSLock()
    
    private init() { }
    
    func writeToLog(_ text: String) {
        lock.lock()
        lastLog = text
        lock.unlock()
    }
    
    func getLog() -> String {
        lock.lock()
        
        defer {
            lock.unlock()
        }
        
        return lastLog
    }
}
