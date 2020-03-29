//
//  Flow.swift
//  QuizEngine
//
//  Created by Sergiu on 10/21/19.
//  Copyright © 2019 Sergiu. All rights reserved.
//

import Foundation

class Flow<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    
    private let router: R
    private let questions: [Question]
    private var answers: [Question: Answer] = [:]
    private var scoring: ([Question: Answer]) -> Int
    
    init(question:[Question], router: R, scoring: @escaping ([Question: Answer]) -> Int) {
        self.router = router
        self.questions = question
        self.scoring = scoring
    }
    
    func start() {
        if let firstQurestion = questions.first {
            router.routeTo(question: firstQurestion, answerCallback: nextCallback(from: firstQurestion))
        } else {
            router.routeTo(result: result())
        }
        
    }
    
    private func nextCallback(from question: Question) -> (Answer) -> Void {
        return { [weak self ] in self?.routeNext(question, $0) }
    }
    
    private func routeNext(_ question: Question, _ answer: Answer) {
        if let curentQuestionIndex = questions.firstIndex(of: question) {
            answers[question] = answer
            let nextQuestionIndex = curentQuestionIndex + 1
            if nextQuestionIndex < questions.count {
                let nextQuestion = questions[nextQuestionIndex]
                router.routeTo(question: nextQuestion, answerCallback: nextCallback(from: nextQuestion))
            } else {
                router.routeTo(result: result())
            }
            
        }
    }
    
    private func result() -> Results<Question, Answer> {
        return Results(answers: answers, score: scoring(answers))
    }
}
