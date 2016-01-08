import Foundation

// Sigsegv occurs when accessing a nonexistent property of a return type
// declared as 'Self' by two different protocols, both of which are implemented
// by the concrete class.
// Crash is actually in Traversal::visit.

protocol ParentProtocol {
    var proto1 : ChildProtocol1 { get }
    var proto2 : ChildProtocol2 { get }
    func chain() -> Self
}

protocol ChildProtocol1 : ParentProtocol {}
protocol ChildProtocol2 : ParentProtocol {}

class Delegate : ChildProtocol1, ChildProtocol2 {
    var proto1 : ChildProtocol1 {
        return self
    }
    var proto2 : ChildProtocol2 {
        return self
    }
    func chain() -> Self {
        return self
    }
}

func main() {
    Delegate().proto1.proto2.chain().nonexistent
}
