import Foundation

public protocol Router {
    
    associatedtype Answer
    associatedtype Question: Hashable
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: Results<Question, Answer>)
}
