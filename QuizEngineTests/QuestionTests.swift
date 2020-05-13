//
//  QuestionTests.swift
//  QuizTests
//
//  Created by Sergiu on 4/9/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class QuestionTests: XCTestCase {
    func test_singleSelection_returnHashValue() {
        let type = "type"
        let sut = Question.singleSelection(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
    
    func test_multipleSelection_returnHashValue() {
        let type = "type"
        let sut = Question.multipleSelection(type)
        XCTAssertEqual(sut.hashValue, type.hashValue)
    }
}
