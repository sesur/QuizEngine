//
//  Results.swift
//  QuizEngine
//
//  Created by Sergiu on 3/28/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

public struct Results<Question: Hashable, Answer> {
    public  let answers: [Question: Answer]
    public let score: Int
}
