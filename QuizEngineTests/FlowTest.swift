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
        makeSUT(questios: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    
    func test_startWithOneQuestion_routesToCrrectQuestion() {
        makeSUT(questios: ["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startWithOneQuestion_routesToCrrectQuestion_2() {
        makeSUT(questios: ["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    
    func test_startWithTwoQuestion_routesToFirstQuestion() {
        makeSUT(questios: ["Q1", "Q2"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_routesToFirstQuestion_Twice() {
        let sut = makeSUT(questios: ["Q1", "Q2"])
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    
    func test_startAndAnswerFirstQuestion_routesToSecondQuestion() {
        let sut = Flow(question: ["Q1","Q2"], router: router)
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_routesToSecondAndThirdQuestion() {
        let sut = Flow(question: ["Q1","Q2", "Q3"], router: router)
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    
    func test_startAndAnswerFirstQuestion_WithOneQuestion_DoesNotroutoToOtherDirection() {
        let sut = Flow(question: ["Q1"], router: router)
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    
    func test_startWithNoQuestion_routesToResults() {
        makeSUT(questios: []).start()
        XCTAssertEqual(router.routedResults, [:])
    }
    
    func test_startWithOneQuestion_routesToResults() {
        let sut = makeSUT(questios: ["Q1"])
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedResults, ["Q1": "A1"])
    }
    
    
    func test_startWithOneQuestion_doesNotRoutesToResults() {
        makeSUT(questios: ["Q1"]).start()
        
        XCTAssertNil(router.routedResults)
    }
    
    func test_startAndAnwerFirstQuestions_WithTwoQuestions_doesNotRoutesToResults() {
        let sut = makeSUT(questios: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        XCTAssertNil(router.routedResults)
    }
    
    
    func test_startAndAnwerFirstAndSecondQuestions_WithTwoQuestions_routesToResults() {
        let sut = makeSUT(questios: ["Q1", "Q2"])
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        XCTAssertEqual(router.routedResults, ["Q1": "A1", "Q2": "A2"])
    }
    
    //MARK:- Helper method
    
    func makeSUT(questios: [String]) -> Flow {
        return Flow(question:questios, router: router)
    }
    
    class RouterSpy: Router {
     
        
        
        var routedQuestions: [String] = []
        var routedResults: [String: String]? = nil
        
        var answerCallback: AnswerCallback = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
            
        }
        
        func routeTo(result: [String : String]) {
            routedResults = result
        }
        
    }
}
