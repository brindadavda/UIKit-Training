//: [Previous](@previous)

import Foundation

//16. FIzz Buzz
func fizzBuzz(num : Int) -> String{
    var result = ""
    
    for i in 1...num{
        if i%3 == 0 && i%5 == 0{
            result += "Fizz Buzz, "
        }
        else if i%3 == 0{
            result += "Fizz, "
        }else if i%5 == 0{
            result += "Buzz, "
        }else{
            result += "\(i), "
        }
    }
    
    return result
}

//print(fizzBuzz(num: 36))

//17. Generate a random number in a range
//print(Int.random(in: 0...4))

//18. Recreate the pow() function
func customPow(baseNumber : Int, exponent : Int) -> Int{
    
    var result = baseNumber
    
    for _ in 1...exponent-1{
        result *= baseNumber
    }
    
    return result
}

//print(customPow(baseNumber: 2, exponent: 6))

//19. Swap two numbers
var a = 12
var b = 2
a = a + b
b = a - b
a = a - b


//print(a)
//print(b)

//20. Number is prime
func isPrim(num : Int)-> Bool{
    if num == 1 || num == 2{
        return true
    }
    
    for i in 2...Int(sqrt(Double(num))){
        if num%i == 0 {
            return false
        }
    }
    
    return true
}

//print(isPrim(num: 1))

//21. Counting binary ones : Remaining

//22. Binary reverse : Remaining
func reverseBinaryDigits(of number: Int) -> Int {
    var reversed = 0
    var num = number

    while num > 0 {
        reversed <<= 1
        reversed |= num & 1
        num >>= 1
    }

    return reversed
}

print(reverseBinaryDigits(of: 10))


//23. Integer disguised as string
print("\(type(of: 12)) is \(type(of: String(12)))")


//24. 


