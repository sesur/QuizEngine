//
//  Game.swift
//  QuizEngine
//
//  Created by Sergiu on 3/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation


public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}


public func startGame<Question, Answer, R: Router>(questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(question: questions, router: router, scoring: {_ in 1 })
    flow.start()
    return Game(flow: flow)
}
