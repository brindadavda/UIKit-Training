//: [Previous](@previous)

import Foundation

//
//var greeting = "Hello, playground"

//: [Next](@next)


//class Home{
//    private let land = [[1,0,0,1], [1,0,1], [1,0,1,0], [1,1,0,1]]
//
//    subscript(row : Int , col : Int)->Int?{
//        let maxCol = land.count - 1
//        guard col < maxCol && col >= 0 else {return nil}
//
//        let rowNumbers = land[col].count - 1
//
//        guard row < rowNumbers , row >= 0 else { return nil }
//
//        return land[row][col]
//    }
//}

//let homeObj = Home()
//
//if let value = homeObj[1,1]{
//    print(value)
//}



//// Defining generic structure for Matrix
//struct Matrix<T> {
//
//    let rows: Int, columns: Int
//    var data: [T]
//
//    // Initializer to create a matrix
//    init(rows: Int, columns: Int, initialValue: T) {
//        self.rows = rows
//        self.columns = columns
//
//        // Initializing the matrix with an array
//        data = Array(repeating: initialValue, count: rows * columns)
//    }
//
//    // Subscript for accessing and modifying elements in the matrix
//    subscript(row: Int, column: Int) -> T {
//        get {
//            return data[(row * columns) + column]
//        }
//        set {
//            data[(row * columns) + column] = newValue
//        }
//    }
//}


//var metrix = Matrix<[String]>(rows: 4, columns: 4, initialValue: [])
////metrix[0,0] = ["name","food"]
////metrix[1,2] = ["name","food"]
////metrix[2,3] = ["name","food"]
//print(metrix.data)

//struct Reuest<Result>{
//
//}

//struct RequestEvaluator{
//    func evaluateResultBasedOnMarks<each Result>(_ : repeat Request<each Result>)-> (repeat each Result<Any, <#Failure: Error#>>)
//}
//
//let results = RequestEvaluator.evaluateResultBasedOnMarks(20,30,40)

//swift 5.9 or above
//let x = #binaryString(10)

/*
expanded code:
"1010"
*/
//print(x)

//Macros in swift
func printLocation() {
    print("File: \(#file), Function: \(#function), Line: \(#line), Column: \(#column)")
}

printLocation()
