//
//  Question.swift
//  Quiz
//
//  Created by Sergiu on 4/9/20.
//  Copyright © 2020 Sergiu. All rights reserved.
//

import Foundation

public enum Question<T: Hashable>: Hashable {
    case singleSelection(T)
    case multipleSelection(T)
    
   public func hash(into hasher: inout Hasher) {
        switch self {
        case .singleSelection(let value):
            hasher.combine(value)
        case .multipleSelection(let value):
            hasher.combine(value)
        }
    }
    
}
