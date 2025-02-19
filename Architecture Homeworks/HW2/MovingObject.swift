//
//  MovingObject.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 09.02.2025.
//

import Foundation

protocol MovingObject {
    
    func getLocation() -> CGPoint
    
    func getVelocity() -> CGVector
    
    func setLocation(_ point: CGPoint) throws
}
