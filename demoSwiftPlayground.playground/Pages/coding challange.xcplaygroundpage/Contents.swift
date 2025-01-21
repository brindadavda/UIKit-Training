//: [Previous](@previous)

import Foundation

func executeDiffer() -> String {
    var str = "A"
    
    defer {
        str += "B"
    }
    str += "C"
    
    do {
        defer {
            str += "D"
        }
        str += "E"
        
        do {
            str += "F"
        }
    }
    
    defer {
        str += "G"
        
       
    }
    
    return str
}

print(executeDiffer())


//deinit work
class Phone{
    
    private var name : String
    
    init(name : String){
        debugPrint("Init method called")
        self.name = name
    }
    
    func printName(){
        print("Phone name is \(name)")
    }
    
    deinit{
        debugPrint("Deinit called because deallocation of memory")
    }
}


if true{
    let phone = Phone(name: "one plus")
    //phone.printName()
    print(#column)

}


var addTwoNumber : (Int ,Int) -> Int = { (n1 ,n2 ) in return n1 + n2}

//print(addTwoNumber(1,3))

func longestCommonPrefix(_ strs: [String]) -> String {
       var result = ""
        var pre : String = strs[0]

    for str in strs{
        while !str.hasPrefix(pre) {
            if pre.count > 1{
                pre = String(pre.dropLast())
            }else{
                break
            }
        }
    }

    return pre
   }


print(longestCommonPrefix(["flower","flow","flight"]))
