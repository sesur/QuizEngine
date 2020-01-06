//
//  Flow.swift
//  QuizEngine
//
//  Created by Sergiu on 10/21/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(result: [String: String])
}

class Flow {
    
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    
    init(question:[String] ,router: Router) {
        self.router = router
        self.questions = question
    }
    
    func start() {
        if let firstQurestion = questions.first {
            router.routeTo(question: firstQurestion, answerCallback: nextCallback(from: firstQurestion))
        } else {
             router.routeTo(result: result)
        }
       
    }
    
   private func nextCallback(from question: String) -> Router.AnswerCallback {
        return { [weak self ] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: String, _ answer: String) {
        if let curentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextQuestionIndex = curentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result)
            }
            
        }
    }
}
