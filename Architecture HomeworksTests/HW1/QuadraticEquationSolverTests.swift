//
//  QuadraticEquationSolverTests.swift
//  Architecture Homeworks
//
//  Created by Artem Kalugin on 24.01.2025.
//

import XCTest
@testable import Architecture_Homeworks

final class QuadraticEquationSolverTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var solver = QuadraticEquationSolver()
    
    // MARK: - Tests

    func testNoRoots() throws {
        // Act
        let answer = try solver.solve(a: 1, b: 0, c: 1)
        
        // Assert
        XCTAssertEqual(answer, [])
    }
    
    func testTwoRoots() throws {
        // Act
        let answer = try solver.solve(a: 1, b: 0, c: -1)
        
        // Assert
        XCTAssertEqual(answer, [1, -1])
    }
    
    func testOneRoot() throws {
        // Act
        let answer = try solver.solve(a: 1, b: 2, c: 1)
        
        // Assert
        XCTAssertEqual(answer, [-1])
    }
    
    func testException() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 0, b: 0, c: 0))
    }
    
    func testOneRootVerySmallValue() throws {
        // Act
        let answer = try solver.solve(a: 0.001, b: 0.0001, c: 0.0001)
        
        // Assert
        XCTAssertEqual(answer, [-0.05])
    }
    
    func testANaN() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: Double.nan, b: 1, c: 1))
    }
    
    func testBNaN() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: Double.nan, c: 1))
    }
    
    func testCNaN() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: 1, c: Double.nan))
    }
    
    func testAPlusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: Double.infinity, b: 1, c: 1))
    }
    
    func testBPlusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: Double.infinity, c: 1))
    }
    
    func testCPlusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: 1, c: Double.infinity))
    }
    
    func testAMinusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: -Double.infinity, b: 1, c: 1))
    }
    
    func testBMinusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: -Double.infinity, c: 1))
    }
    
    func testCMinusInf() throws {
        // Assert
        XCTAssertThrowsError(try solver.solve(a: 1, b: 1, c: -Double.infinity))
    }
}
