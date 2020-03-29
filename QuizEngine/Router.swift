//
//  Router.swift
//  QuizEngine
//
//  Created by Sergiu on 3/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

public protocol Router {
    
    associatedtype Answer
    associatedtype Question: Hashable
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Results<Question, Answer>)
}
