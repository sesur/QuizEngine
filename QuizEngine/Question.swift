import Foundation

public enum Question<T: Hashable>: Hashable {
    case singleSelection(T)
    case multipleSelection(T)
}
