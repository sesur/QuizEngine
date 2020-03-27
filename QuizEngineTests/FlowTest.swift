//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Sergiu on 10/21/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    let router = RouterSpy()
    
    func test_startWithNoQuestion_doesNoRouteToQuestion() {
        makeSUT(question: []).start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_startWithOneQuestion_routesToCrrectQuestion() {
        makeSUT(question: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startWithOneQuestion_routesToCrrectQuestion_2() {
        makeSUT(question: ["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_startWithTwoQuestion_routesToFirstQuestion() {
        makeSUT(question: ["Q1", "Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_routesToFirstQuestion_Twice() {
        let sut = makeSUT(question: ["Q1", "Q2"])
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    
    func test_startAndAnswerFirstQuestion_routesToSecondQuestion() {
        let sut = makeSUT(question: ["Q1","Q2"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_routesToSecondAndThirdQuestion() {
        let sut = makeSUT(question: ["Q1","Q2", "Q3"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    
    func test_startAndAnswerFirstQuestion_WithOneQuestion_DoesNotroutoToOtherDirection() {
        makeSUT(question: ["Q1"]).start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    func test_startWithNoQuestion_routesToResults() {
        makeSUT(question: []).start()
        XCTAssertEqual(router.routedResults!.answers, [:])
    }
    
    func test_startWithOneQuestion_routesToResults() {
        let sut = makeSUT(question: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedResults!.answers, ["Q1": "A1"])
    }
    
    
    func test_startWithOneQuestion_doesNotRoutesToResults() {
        makeSUT(question: ["Q1"]).start()
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAndAnwerFirstQuestions_WithTwoQuestions_doesNotRoutesToResults() {
        makeSUT(question: ["Q1", "Q2"]).start()
        router.answerCallback("A1")
        XCTAssertNil(router.routedResults)
    }
    
    
    func test_startAndAnwerFirstAndSecondQuestions_WithTwoQuestions_routesToResults() {
        let sut = makeSUT(question: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults!.answers, ["Q1": "A1", "Q2": "A2"])
    }
    
    // Scoring
    func test_startAndAnwerFirstAndSecondQuestions_WithTwoQuestions_scores() {
        let sut = makeSUT(question: ["Q1", "Q2"], scoring: { _ in 10 })
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults!.score, 10)
    }
    
    func test_startAndAnwerFirstAndSecondQuestions_WithTwoQuestions_scoresWithRightAnswers() {
        
        var receivedCorrectAnswer = [String: String]()
        let sut = makeSUT(question: ["Q1", "Q2"], scoring: { answers in
            receivedCorrectAnswer = answers
            return 20
        })
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(receivedCorrectAnswer, ["Q1": "A1", "Q2": "A2"])
    }
    
    
    //MARK:- Helper method
    
    func makeSUT(question: [String], scoring: @escaping ([String: String]) -> Int = { _ in 10}) -> Flow<String, String, RouterSpy> {
        return Flow(question: question, router: router, scoring: scoring)
    }
    
    
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResults: Result<String, String>? = nil
        var answerCallback: (String) -> Void = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
            
        }
        
        func routeTo(result: Result<String, String>) {
            routedResults = result
        }
        
    }
}
