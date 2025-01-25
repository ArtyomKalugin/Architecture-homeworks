//
//  Untitled.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 24.01.2025.
//

import Foundation

final class QuadraticEquationSolver {
    
    // MARK: - Private properties
    
    private let e = Double(1e-5)
    private let bigValue = Double(truncating: pow(10, 9) as NSDecimalNumber)
    
    func solve(a: Double, b: Double, c: Double) throws -> [Double] {
        if abs(a) <= e {
            throw NSError(domain: "a == 0", code: 1)
        }
        
        if a == .infinity || b == .infinity || c == .infinity {
            throw NSError(domain: "plus infinity!", code: 1)
        } else if a == -.infinity || b == -.infinity || c == -.infinity {
            throw NSError(domain: "minus infinity!", code: 1)
        }
        
        let D = b * b - 4 * a * c
        if D < -e {
            return [] // Корней нет
        }
        
        // Один корень кратности 2
        if abs(D) <= e {
            let root = -b / (2 * a)
            return [root]
        }
        
        // Два корня кратности 1
        if abs(D) >= e {
            var firstRoot: Double
            var secondRoot: Double
            
            if D >= bigValue {
                firstRoot = (-b + copysign(1.0, b) + sqrt(D)) / (2 * a)
                secondRoot = c / firstRoot
            } else {
                firstRoot = (-b + sqrt(D)) / (2 * a)
                secondRoot = (-b - sqrt(D)) / (2 * a)
            }
            
            return [firstRoot, secondRoot]
        }
        
        throw NSError(domain: "not a number!", code: 1)
    }
}
