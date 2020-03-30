//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Sergiu on 3/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation
@testable import QuizEngine

class RouterSpy: Router {
       var routedQuestions: [String] = []
       var routedResults: Results<String, String>? = nil
       var answerCallback: (String) -> Void = { _ in }
       
       func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
           routedQuestions.append(question)
           self.answerCallback = answerCallback
           
       }
       
       func routeTo(result: Results<String, String>) {
           routedResults = result
       }
       
   }
