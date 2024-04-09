import Foundation

public struct Results<Question: Hashable, Answer> {
    public  let answers: [Question: Answer]
    public let score: Int
}
