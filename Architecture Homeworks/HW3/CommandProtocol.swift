//
//  CommandProtocol.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 19.02.2025.
//

import Foundation

protocol CommandProtocol: AnyObject {
    
    func execute() throws
}
