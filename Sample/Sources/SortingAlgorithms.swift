/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// Bubble Sort: 每一回合都把最大值找出來，放到數列右邊。
// Selection Sort: 每一回合都把最小值找出來，放到數列左邊。
// Insertion Sort: 只要一回合，就可以把所有數列排序完成，但這回合需要進行多次比較。

// Bubble Sort
// n-1 passes
// Best case: O(n)
// Worset case: O(n^2)
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


// Selection Sort
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

// Insertion Sort
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
