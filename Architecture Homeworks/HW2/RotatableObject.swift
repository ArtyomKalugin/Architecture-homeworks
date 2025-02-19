//
//  RotatableObject.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import Foundation

protocol RotatableObject {
    
    func getDirection() -> Int
    
    func getDirectionsNumber() -> Int
    
    func getAngularVelocity() -> Int
    
    func setDirection(_ direction: Int) throws
}
