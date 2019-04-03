# Sorting Algorithms

------

- Bubble Sort
- Selection Sort
- Insertion Sort

------

**<u>Bubble Sort</u>**

- 未排序資料中的最大值會如同氣泡般往右跑
- 時間複雜度(Time Complexity)
  - Best Case：Ο(n)
    - 當資料的順序恰好為由小到大時，第一次執行後，未進行任何**swap** **⇒** 提前結束
  - Worst Case：Ο(n＾2)
    - 當資料的順序恰好為由大到小時
    - 每回合分別執行：n-1、n-2、...、1次
    - (n-1) + (n-2) + ... + 1 = n(n-1)/2 **⇒** Ο(n＾2)
  - Average Case：Ο(n＾2)
    - 第n筆資料，平均比較(n-1)/2次
- 空間複雜度(Space Complexity)：θ(1)

```swift
func bubbleSort<Element: Comparable>(_ array: inout [Element]) {
    //  如果只有1個元素, 也不需要排序
    guard array.count >= 2 else {
        return
    }
    
    // 每一回合都會將最大的值移到數列最後，因此每一回合比較的元素都會比上一回合少一個。
    for end in (1..<array.count).reversed() {
        var swapped = false
        // 每一回合中都需要將相鄰的區域，倆倆進行比較
        for current in 0..<end {
            if array[current] > array[current + 1] {
                array.swapAt(current, current + 1)
                swapped = true
            }
        }
        
        // 如果此回合已經沒任何swap動作產生，表示此數列已經排序好了，就可以提早離開迴圈
        if !swapped {
            return
        }
    }
}
```



------

**<u>Selection Sort</u>**

- 依序由**未排序**中找**最小值，加入到**已排序部份的最前端
- 時間複雜度(Time Complexity)
  - Best Case, Worst Case, Average Case都是Ο(n＾2)
  - 無論資料順序如何，都會執行兩個迴圈
- 空間複雜度(Space Complexity)：θ(1)

```swift
// 只有在每一回合結束時，才進行swap動作
func selectionSort<Element: Comparable>(_ array: inout [Element]) {
    guard array.count >= 2 else {
        return
    }
    
    // 每一個回合都要找到一個最小的元素
    for current in 0..<(array.count - 1) {
        var lowest = current
        
        for other in (current + 1)..<array.count {
            if array[lowest] > array[other] {
                // 找到此回合的最小元素
                lowest = other
            }
        }
        
        if lowest != current {
            array.swapAt(lowest, current)
        }
    }
}
```



------

**<u>Insertion Sort</u>**

- 將資料分成**已排序**、**未排序**兩部份
- 依序由未排序中的第一筆(正處理的值)，插入到已排序中的適當位置
  - 插入時**由右而左**比較，直到遇到第一個比**正處理的值**小的值，再插入
  - 比較時，若遇到的值比**正處理的值**大或相等，則將值往右移
- 時間複雜度(Time Complexity)
  - Best Case：Ο(1)
    - 當資料的順序恰好為由小到大時，每回合只需比較1次
  - Worst Case：Ο(n＾2)
    - 當資料的順序恰好為由大到小時，第i回合需比i次
  - Average Case：Ο(n＾2)
    - 第n筆資料，平均比較n/2次

```swift
// 只有進行一回合比較
// 每一次都先跟左邊的元素比較確認是否需要swap
func insertionSort<Element: Comparable>(_ array: inout [Element]) {
    guard array.count >= 2 else {
        return
    }
    
    // 不用考慮第一個，因為第一個沒左邊元素
    for current in 1..<array.count {
        for shifting in (1...current).reversed() {
            if array[shifting] < array[shifting - 1] {
                array.swapAt(shifting, shifting - 1)
            } else {
                break
            }
        }
    }
}
```

