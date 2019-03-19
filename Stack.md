# Stack

------

先來談談最基本的資料結構的Stack，先從特性來說明

- Stack是LIFO(Last-In, First-Out)，也就是先進後出。
- 基本的操作有
  - Push: O(1)，直接放在Stack最頂端。
  - Pop: O(1), 直接取Stack最頂端的物件。
  - Peek: O(1), 查詢Stack最頂端的物件。

------

再來看看如何利用Swift來進行實作

- 利用Swift中的array來製作Stack。
- Equatable讓我們可以比較兩個不同Stack是否相同，用來方便測試。
- 如果沒有處理 function 回傳的結果，Xcode會發出善意的警告，不過如果你確定不想處理，而且不想看到警告的話，只要在 function 前加上 @discardableResult， Xcode 就不會再產生煩人的警告了。

```swift
struct Stack<Element: Equatable>: Equatable {
    private var storage: [Element] = []
    var isEmpty: Bool {
        return peek() == nil
    }
    
    // init
    init() { }
    
    init(_ elements: [Element]) {
        storage = elements
    }
    
    // peek
    func peek() -> Element? {
        return storage.last
    }
    
    // push
    mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    // pop
    mutating func pop() -> Element? {
        return storage.popLast()
    }
}
```

- 實作兩個protocol，也是方便後來的測試
  - [CustomStringConvertible](https://developer.apple.com/documentation/swift/customstringconvertible)
  - [ExpressibleByArrayLiteral](https://developer.apple.com/documentation/swift/expressiblebyarrayliteral)

```swift
extension Stack: CustomStringConvertible {
    var description: String {
        return storage
            .map { "\($0)" }
            .joined(separator: " ")
    }
}

extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
```

------

來看看測試

```swift
final class StackTestCase: XCTestCase {
    var stack = Stack<Int>()
    
    override func setUp() {
        stack.push(1)
        stack.push(2)
        stack.push(3)
        stack.push(4)
    }

    func test_push() {
        XCTAssertEqual(stack.description, "1 2 3 4")
    }
    
    func test_pop() {
        XCTAssertEqual(stack.pop(), 4)
    }
    
    func test_peek() {
        XCTAssertEqual(stack.peek(), 4)
    }
    
    func test_isEmpty() {
        XCTAssertFalse(stack.isEmpty)
    }
    
    func test_initWithArray() {
        let array = [1, 2, 3, 4]
        XCTAssertEqual(stack, Stack(array))
    }
    
    func test_arrayLiteral() {
        let stack: Stack = ["blue", "orange", "green"]
        XCTAssertEqual(stack, ["blue", "orange", "green"])
    }

}
```

------

最後，來看看Stack是可以如何應用

- 如何判斷一個字串中的左右括號的數量是相等的?

```swift
func checkParentheses(_ string: String) -> Bool {
    var stack = Stack<Character>()
    
    for character in string {
        if character == "(" {
            stack.push(character)
        } else if character == ")" {
            if stack.isEmpty {
                return false
            } else {
                stack.pop()
            }
        }
    }
    
    return stack.isEmpty
}

final class StackChallengeTestCase: XCTestCase {
  func test_checkParens() {
    XCTAssertTrue( checkParentheses("()") )
  }
  
  func test_checkParens1() {
    XCTAssertTrue( checkParentheses("hello(world)()") )
  }
  
  func test_checkParens2() {
    XCTAssertFalse( checkParentheses("(hello world") )
  }
  
  func test_checkParens3() {
    XCTAssertFalse( checkParentheses("((())(meow)))()))") )
  }
  
}
```

