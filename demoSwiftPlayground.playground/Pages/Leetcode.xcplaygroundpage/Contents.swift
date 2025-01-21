//: [Previous](@previous)

import Foundation
import UIKit

var greeting = "Hello, playground"

//: [Next](@next)


/*Question 1 : 
 
 We are given an array asteroids of integers representing asteroids in a row.

For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet. */


//print(arr.first!)


let arr2 : [Int] = [10,-5,6,-7,5]

func exploidState(asteroids : [Int]) -> [Int] {
    
    var stack: [Int] = []

    for asteroid in asteroids {
        if asteroid > 0 {
            stack.append(asteroid)
        } else {
            while let lastAsteroid = stack.last, lastAsteroid > 0, lastAsteroid < -(asteroid) {
                stack.removeLast()
            }
            if let lastAsteroid = stack.last, lastAsteroid == -(asteroid) {
                stack.removeLast()
            } else if stack.isEmpty || stack.last! < 0 {
                stack.append(asteroid)
            }
        }
    }
    
    return stack
}

//exploidState(asteroids: arr2)
//print(exploidState(asteroids: arr2))



/* problem 2 :
 
 You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

 Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.

  

 Example 1:

 Input: flowerbed = [1,0,0,0,1], n = 1
 Output: true
 Example 2:
 Input: flowerbed = [1,0,0,0,1], n = 2
 Output: false
 
 */


func floweBadSolution(flowerbed : inout [Int] , n : Int) -> Bool{
    
    var totalPlots = 0
    
     if flowerbed.count == 1{
        if flowerbed[0] == 0{
            totalPlots += 1
        }
    }
    
    else if flowerbed.count == 2{
        return flowerbed[0] == flowerbed[1]
    }
    
    
    
    else if flowerbed.count > 2{
        for (index,flower) in flowerbed.enumerated(){
            if flower == 0 {
                if index > 0 && index < flowerbed.count-1{
                    if flowerbed[index-1] == 0 && flowerbed[index+1] == 0{
                        flowerbed[index] = 1
                        totalPlots += 1
                    }
                }
                
                else{
                    if index == 0{
                        if flowerbed[index + 1] == 0{
                            flowerbed[index] = 1
                            totalPlots += 1
                        }
                    }else{
                        if flowerbed[index - 1] == 0{
                            flowerbed[index] = 1
                            totalPlots += 1
                        }
                    }
                }
            }
        }
    }
    
   
    
    return totalPlots == n
}

////var arr3 = [0,0,1,0,0]
//var arr3 = [0,0,1,0,0]
//print(floweBadSolution(flowerbed: &arr3, n: 1))



func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
    guard  k >= 0 else { return false }
    
    var dics : [Int : Int] = [:]
    
    
    for (i,num) in nums.enumerated(){
        if let val = dics[i]{
            if abs(val-i) <= k { return true }
        }else{
            dics[num] = i
        }
    }
    
    return false
}
    
    
    //containsNearbyDuplicate([0,1,2,3,4,0,0,7,8,9,10,11,12,0], 2)
    
    
    
    func findDiagonalOrder(_ mat: [[Int]]) -> [Int] {
        var maxSize = 0
        var result: [Int] = []
        var map: [Int: [Int]] = [:]
        
        for row in 0..<mat.count {
            for col in 0..<mat[0].count {
                maxSize = max(maxSize, row + col) ///4 , 2+2
                map[row + col, default: []].append(mat[row][col]) // map[0] = [1], map[1] = [2,4] , map[2] = [3,5,7] , map[3] = [6,8] , map[4] = [9]
            }
        }
        
        for index in 0...maxSize {
            result.append(contentsOf: index % 2 == 0 ? map[index]!.reversed() : map[index]!) // 1 , 2, 4 , 7 , 5, 3 , 6 ,8 , 9
        }
        
        return result
    }
    


func findDiagonalOrder2(_ mat: [[Int]]) -> [Int] {
   
       // Store diagonal order in output array.
       var output:[Int] = []
       
       // Variables for mat row and column sizes.
       let n = mat.count
       let m = mat.first?.count ?? 0
       
       // Variables for i and j pointers
       var i = 0
       var j = 0
       
       // Enum for defining the traversal direction.
       enum Direction {
           case up
           case down
       }
       
       // Variable for traversal direction
       var direction: Direction = .up
   
       // Once i and j equal n and m respectively, end the loop.
       while i < n && j < m {

           // 1. Store the value at mat[i][j] in the output
           output.append(mat[i][j])

           // 2. Increment or decrement i and j as needed.
           switch direction {
               // If traversing up...
               case .up:
                   // Check that j+1 < m, therefore in the bounds of the array.  If not add 1 to i and change direction.
                   if j + 1 == m {
                       direction = .down
                       i += 1
                   } else
                   // Check that i-1 > 0, therefore in the bounds of the array.  If not add 1 to j and change direction.
                   if i - 1 < 0  {
                       direction = .down
                       j += 1
                   } else {
                       // Move up the array if i and j are within the bounds of the array.
                       i -= 1
                       j += 1
                   }
               // If traversing down...
               case .down:
                   // Check that i+1 < n, therefore in the bounds of the array.  If not add 1 to j and change direction.
                   if i + 1 == n {
                       direction = .up
                       j += 1
                   } else
                   // Check that j-1 > 0, therefore in the bounds of the array.  If not add 1 to 1 and change direction.
                   if j - 1 < 0  {
                       direction = .up
                       i += 1
                   } else {
                       // Move down the array if i and j are within the bounds of the array.
                       i += 1
                       j -= 1
                   }
           }
       }
       
       // Done.
       return output
   }




/*
 
 [1,2,3
 4,5,6
 7,8,9]
 
 */

    
//  print(findDiagonalOrder([[1,2,3],[4,5,6],[7,8,9]]))
//  print(findDiagonalOrder2([[1,2,3],[4,5,6],[7,8,9]]))



func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {

      var results : [[Int]] = []

      for i in 0..<nums.count{
          var num : [Int] = []
          var j  = 0
          while j < 4{
              if i+j < nums.count{
                  num.append(nums[i+j])
                  j += 1
              }else{
                  break
              }
              
          }
          
          if  num.count == 4{
              if let result = findFourSumResult(num,target){
                  results.append(result)
              }
          }
    
          
         
      }

      return results
  }


  func findFourSumResult(_ nums: [Int], _ target: Int) -> [Int]? {
//      print(nums)
      var result : Int = 0
      for num in nums{
          result += num
      }

      return result == target ? nums : nil
  }


//print(fourSum([1,0,-1,0,-2,2],0))


func addStrings1(_ num1: String, _ num2: String) -> String {
        let num1Chars = Array(num1.reversed()) // [1,1]
        let num2Chars = Array(num2.reversed()) // [3,2,1]
        var i = 0, j = 0, sum = 0, carry = 0
        var res = ""
    
    
        while i < num1Chars.count || j < num2Chars.count || carry != 0 { // i = 1 , j = 1 , carry = 0
            sum = carry // 0
            
            if i < num1Chars.count {
                sum += Int(String(num1Chars[i]))! // 1
                i += 1
            }
            if j < num2Chars.count {
                sum += Int(String(num2Chars[j]))! // 4
                j += 1
            }
            
            carry = sum / 10 // 0
            sum = sum % 10 // 4
            
            res.append(String(sum))
        }
        
        return String(res.reversed())
    }




func addStrings(_ num1: String, _ num2: String) -> String {
     let num1ReversedArray : [Character] = Array(num1.reversed())
     let num2ReversedArray : [Character] = Array(num2.reversed())

     var i = 0 , j = 0 , sum = 0 , carry = 0
     var result : String = ""

     while i < num1ReversedArray.count ||  j < num2ReversedArray.count {
         sum = carry
       if  i < num1ReversedArray.count{
           sum += Int(String(num1ReversedArray[i]))!
           i += 1
       }
         
         if j < num2ReversedArray.count{
             sum += Int(String(num2ReversedArray[j]))!
             j += 1
         }
         
         carry = sum/10
         sum = sum%10
         result += "\(sum)"
     }

    if carry > 0{
        result += "\(carry)"
    }
   
    
    return String(result.reversed())

   }



//print(addStrings("1", "9"))


var result : String = ""

func countAndSay(_ n: Int) -> String {

    var result = "1"
    var n = n
    
    while(n > 1){
        result = runLengthEncoding(result)
        n -= 1
    }
    
    
    return result
}


func runLengthEncoding(_ str : String) -> String{
    var count : Int  = 1
    var encodedString : [String] = []
    
    let strArray : [Character] = Array(str)
    
    for i in 0..<strArray.count-1{
            if strArray[i] == strArray[i+1] && count < 9{
                count += 1
            }else{
                encodedString.append("\(count)\(strArray[i])")
                count = 1
            }
    }

    encodedString.append("\(count)\(strArray[strArray.count-1])")
    
    return encodedString.joined()
}


//print(countAndSay(4))


func findAnagrams(_ s: String, _ p: String) -> [Int] {
    var result : [Int] = []
    let arrs = Array(s)
    
    var i : Int = 0
    var str : String = ""
    
    while i < arrs.count{
       
        if isAnagram(str1: str, str2: p){
            print(i)
            if i  - p.count >= 0{
                result.append(i-p.count)
            }
        }
        
        str += String(arrs[i])
        i += 1
    }
    
    return result
}


func isAnagram(str1: String, str2: String)->Bool{

    let a = Array(str1)
    let b = Array(str2)
    
    print(str1)
    print(str2)
    print()

    if a.sorted() == b.sorted() {
        return true
    }
    return false
}

//print(findAnagrams("cbaebabacd","abc"))


func findDuplicate(_ paths: [String]) -> [[String]] {
       var dics : [String : [String]] = [:]
    var result : [String : [String]] = [:]
   
    for path in paths{
        for seperatore in path.split(separator: "("){
            if seperatore.contains(")") , let data = seperatore.split(separator: ")").first{
                let sperator : String = String(data)
                dics[sperator , default: []].append(path)
            }
        }
    }
    
    
    for path in paths{
        for fileData in dics.keys{
            let datas = path.split(separator: " ")
            for seperatore in datas{
                print(seperatore , fileData , seperatore.contains(fileData))
                if seperatore.contains(fileData){
                    if let data = datas.first{
                        if var value =  result[fileData]{
                            result[fileData]?.append(String("\(data) \(seperatore)"))
                        }else{
                            result[fileData] = []
                        }
                      
                    }
                }
            }
        }
    }
    

    print(result)
    
    return []
   }

//print(findDuplicate( ["root/a 1.txt(abcd) 2.txt(efgh)","root/c 3.txt(abcd)","root/c/d 4.txt(efgh)","root 4.txt(efgh)"]))




    func findWords(_ words: [String]) -> [String] {
        

        var result : [String] = []

        for str in words{

            let arr : [Character] = Array(str)
      
            var (row1 , row2, row3) = whichRowContainsChar(String(arr[0].lowercased()))
            var i : Int = 1

            if row1{
                while i <= arr.count - 1{
                    let result = whichRowContainsChar(String(arr[i].lowercased()))
                    if result.row1 == false{
                        break
                    }
                    i += 1
                }

                if i == arr.count{
                    result.append(str)
                }
            }

            else if row2{
               while i <= arr.count - 1{
                   let result = whichRowContainsChar(String(arr[i].lowercased()))
                    if result.row2 == false{
                        break
                    }
                    i += 1
                }
                
                if i == arr.count{
                    result.append(str)
                }
            }

            else if row3{
                 while i <= arr.count - 1{
                     let result = whichRowContainsChar(String(arr[i].lowercased()))
                    if result.row3 == false{
                        break
                    }
                    i += 1
                }


                if i == arr.count{
                    result.append(str)
                }
            }
        }

        return result
    }


    private func whichRowContainsChar(_ char  : String) -> (row1 : Bool , row2 : Bool , row3 : Bool){

        let keyboardArray = ["qwertyuiop" , "asdfghjkl" , "zxcvbnm"]

        if keyboardArray[0].contains(char){
               return (true,false,false)
            }else if keyboardArray[1].contains(char){
                return (false,true,false)
            }else{
                return (false,false,true)
            }
    }

//print(findWords(["Hello","Alaska","Dad","Peace"]))


func isPalindrome(_ s: String) -> Bool {
    let filteredString = Array(s.lowercased())
    var resultString : String = ""
    
    print(filteredString)
    
    for char in filteredString{
        if char != " "{
            resultString += String(char)
        }
    }
    
    print(resultString)
    
    
    return true
}





    @_optimize(speed)
    func lengthOfLastWord(_ s: String) -> Int {
        var length = 0
        var index = s.endIndex

        repeat {
            index = s.index(before: index)
            let char = s[index]

            if char.isWhitespace {
                if length > 0 {
                    break
                }
            } else {
                length += 1
            }
        } while index > s.startIndex
        return length
       
    }


//print(lengthOfLastWord("A man, a plan, a canal: Panama  dd"))

///////////////
func  reverseVowel(_ str : String) -> String {
    var s = Array(str.lowercased())
    
    var leftCounter : Int = 0 , rightCounter : Int = s.count - 1
    var vowels : [Character] = ["a","e","i","o","u"]
    
    while leftCounter < rightCounter{
        if vowels.contains(s[leftCounter]) && vowels.contains(s[rightCounter]){
            s.swapAt(leftCounter, rightCounter)
            leftCounter += 1
            rightCounter -= 1
        }
        else if vowels.contains(s[leftCounter]){
            leftCounter += 1
        }else if vowels.contains(s[rightCounter]){
            rightCounter -= 1
        }else{
            leftCounter += 1
            rightCounter -= 1
        }
    }
    
    return String(s)
}

//print(reverseVowel("leetcode"))


func moveZeroes(_ nums : [Int]) -> [Int]{
    var result : [Int] = []
    var totalZero : Int = 0
    
    for (i,num) in nums.enumerated(){
        if num == 0{
            totalZero += 1
        }else{
            result.append(num)
        }
    }
    if totalZero > 0{
        for i in 1...totalZero{
            result.append(0)
        }
    }
    
    
    return result
}

//print(moveZeroes([0,1,0,3,12]))


func expressionAndOperators(_ num : String , _ target : Int) -> [String]{
    
    var result : [String] = []
    let arr : [String] = Array(num).map({String($0)})
    
    if validOperation(num, target, operation: .add){
        result.append(arr.joined(separator: Operation.add.rawValue))
    }
    
    if validOperation(num, target, operation: .minus){
        result.append(arr.joined(separator: Operation.minus.rawValue))
    }
    
     if validOperation(num, target, operation: .mult){
        result.append(arr.joined(separator: Operation.mult.rawValue))
    }
    
    
    
    
    
    return result
}

enum Operation : String {
    case add = "+"
    case minus = "-"
    case mult = "*"
}

func validOperation(_ nums : String , _ target : Int , operation : Operation) -> Bool{
    guard var num = Int(nums) else { return false }
    
    var result : Int = operation == .mult ? 1 : 0
    
    while num > 0{
        let r = num%10
        num = num/10
       
        switch operation{
            case .add :
                result += r
            case .minus :
                result = abs(result) - r
            case .mult :
                result *= r
        }
    }
    
    return abs(result) == target
}




var allExpressions = [String]()
var nums : [Character] = []
var target : Int = 0

func addOperators(_ num: String, _ tar: Int) -> [String] {
     nums = Array(num)
    target = tar
    dfs(0, "", 0, 0)
    return allExpressions
}

func dfs(_ start: Int,
               _ expression: String,
               _ value: Int,
               _ prev: Int) {
    
    
    print("\(#function) : \(start) \(expression) \(value) \(prev)")
    
    if start == nums.count {
        if value == target {
            allExpressions.append(expression)
        }
    } else {
        var currNum = 0
        for index in start..<nums.count {
            if index != start && nums[start] == "0" { break }
            currNum = currNum * 10 + Int("\(nums[index])")!
            print(currNum)
            
            if start == 0  {
                dfs(index + 1, expression + "\(currNum)", currNum, currNum)
            } else {
                dfs( index + 1, expression + "+\(currNum)", value  + currNum, currNum)
                dfs(index + 1, expression + "-\(currNum)", value - currNum, -currNum)

                let mulValue = value - prev + ( prev * currNum)
                dfs( index + 1, expression + "*\(currNum)", mulValue, prev * currNum)
                
            }
        }
    }
}


//print(addOperators("110",0))


func mergeSortTwoArray(_ num1 : [Int] ,_ num2 : [Int] , _ m : Int , _ n : Int) -> [Int]{
    var result : [Int] = []
    
    if m <= num1.count && m > 0{
        for i in 0...m-1{
            result.append(num1[i])
        }
    }
   
    if n <= num2.count && n > 0{
        for i in 0...n-1{
            result.append(num2[i])
        }
    }
    
    
    return result.sorted()
}


//print(mergeSortTwoArray([1,2,3,0,0,0],[2,5,6],3,3))
print(mergeSortTwoArray([1],[],1,0))
