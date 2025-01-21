import Foundation

enum customError : Error{
    case minor
    case bad
    case terrrible(desctiption : String)
}

print(customError.terrrible(desctiption: "Trowable error"))

enum Result<Value , Error>{
    case sucess(Value)
    case faliure(Value)
}


func fetch(){
//    let someError : Result<> = .sucess(20)
//    print(someError)
}
