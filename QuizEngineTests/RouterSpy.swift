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
