//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Sergiu on 3/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTestCase {
    let router = RouterSpy()
    var game: Game<String, String, RouterSpy>!
    
    func test_startGame_withZeroOfTwoCorrectAnswer_scoresZero(){
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        router.answerCallback("wrong")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResults?.score, 0)
    }
    
    func test_startGame_withOneOfTwoCorrectAnswer_scoresOne(){
        game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2":"A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        XCTAssertEqual(router.routedResults?.score, 1)
    }
    
    func test_startGame_withTwoOfTwoCorrectAnswer_scoresTwo(){
           game = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2":"A2"])
           
           router.answerCallback("A1")
           router.answerCallback("A2")
           XCTAssertEqual(router.routedResults?.score, 2)
       }
}
