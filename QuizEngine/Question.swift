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
}
