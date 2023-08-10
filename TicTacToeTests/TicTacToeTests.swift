//
//  TicTacToeTests.swift
//  TicTacToeTests
//
//  Created by ditthales on 09/08/23.
//

import XCTest
@testable import TicTacToe

final class TicTacToeTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    func testSpaceIsFree() {
        let gameEngine = GameEngine()
        
        XCTAssertTrue(gameEngine.spaceIsFree(n: 1))
        XCTAssertTrue(gameEngine.spaceIsFree(n: 5))
        
        gameEngine.tabuleiro[3] = "X"
        XCTAssertFalse(gameEngine.spaceIsFree(n: 3))
        
        gameEngine.tabuleiro[8] = "O"
        XCTAssertFalse(gameEngine.spaceIsFree(n: 8))
    }
    
    func testIsBoardEmpty() {
        var gameEngine = GameEngine()
        
        XCTAssertTrue(gameEngine.isBoardEmpty())
        
        gameEngine.tabuleiro[2] = "X"
        XCTAssertFalse(gameEngine.isBoardEmpty())
        
        // Reset the board
        gameEngine = GameEngine()
        XCTAssertTrue(gameEngine.isBoardEmpty())
        
        gameEngine.tabuleiro[4] = "O"
        XCTAssertFalse(gameEngine.isBoardEmpty())
    }
    
}
