import Foundation

var something = "some"

something = "34"

let num = Int(something)

let array = NSMutableArray(array: ["fr","gjtk"])

func changeArrayToMutable(_ array : NSArray){
    let copy = array as! NSMutableArray
    copy.add("fhfr")
    
}

//array
//changeArrayToMutable(array)
//array

var age = 23

while age >= 23{
    if age == 23{
        //print("Age is 23")
        //age = 20
        break
    }
    //age = 23
}


//age


//1. challange is letters are unique
//let str1 = "tjhg"

func isUnique(str : String){
    if Set(str).count == str.count{
        print("unique")
    }else{
        print("not unique")
    }
}

//isUnique(str: str1)


//2. is a String a palindrome
func isPalindrom(str : String) -> Bool{
    
    let size = str.count
    let new_half_str = ""
    let characters = Array(str.lowercased())
    
    var initialIndex = 0
    var finalIndex = str.count - 1
    

    while initialIndex < finalIndex{
        if characters[initialIndex] != characters[finalIndex]{
            return false
        }
        initialIndex += 1
        finalIndex -= 1
    }

    return true
    //

}

var str = "%30=18=03%"
/*if isPalindrom(str: str) {
    print("Palindrom")
}else{
    print("Not Palindrom")
}
*/

//3. Do two string contain same character?
func isStringsCharacterEqual(str1 : String , str2 : String){
    if Set(str1).count == Set(str2).count{
        print("yes")
    }else{
        print("no")
    }
}

//isStringsCharacterEqual(str1: "12wd", str2: "1wd2")


//4. Dose one string contain another?
let str1 = "swift" , str2 = "ift"

print(str1.contains(str2))

//5. Count the characters
print("rules".count)

//6. Remove duplicate letters from a string
func removeDuplicateLetter(str : String) -> String{
    var set = Set<Character>()
    print(set)
    return str.uppercased().filter({set.insert($0).inserted})
}

//print(removeDuplicateLetter(str: "Sttringts"))


//7. Condense whitespace i.e remove whitespace
str = "   doert   ty hyny "
print(str.filter({!$0.isWhitespace}))
print(str.components(separatedBy: .whitespaces).joined())
print(str.replacingOccurrences(of: " ", with: ""))
let regexValue = try! NSRegularExpression(pattern: "\\s", options: [])
      let newString = regexValue.stringByReplacingMatches(in: str, options: [], range: NSRange(location: 0, length: str.utf16.count), withTemplate: "")

print(newString)


//8. String is rotated
let arrayStr = Array(str)
print(arrayStr[0])

let s = "abcde", goal = "abcde"

print(s.count == goal.count && (s+s).contains(goal))


//9. Find Pangrams
let str3 = "abcdefghijklmnopqrstuvwxyz"
let alphabetString = "abcdefghijklmnopqrstuvwxyz"
func isPangrams(str : String) -> Bool{ // means it contain all the english alphabet
    for char in alphabetString{
        if !str.lowercased().contains(char){
            return false
        }
    }
    
    return true
}

/*if isPangrams(str: str3){
    print("Pangrams")
}else{
    print("Not Pangrams")
}*/

//10. Vowels and consonants
// Write a function that returns a tuple containing the number of vowels and consonants.
str = "aeiuokoby"
let vowels = "AEIOU"
let consonants = "BCDFGHJKLMNPQRSTVWXYZ"

func containVowelAndConsonants(str : String) -> ( Int ,Int){
    
    var totalVowels = 0
    var totalConsonants = 0
    
    for char in str.uppercased(){
        if vowels.contains(char){
            totalVowels += 1
        }else if consonants.contains(char){
            totalConsonants += 1
        }
    }
    
    
    return (totalVowels,totalConsonants)
}

//print(containVowelAndConsonants(str: str))


//11. Three different letters
str = "ghmgr"

var i = 0
let arr = Array(Set(str))
while i < 3{
    print(arr[i])
    i += 1
}


//12. Find longest prefix
//Write a function to find the longest common prefix string amongst an array of strings.

//If there is no common prefix, return an empty string "".


//Example 1:

//Input: strs = ["flower","flow","flight"]
//Output: "fl"
//Example 2:

//Input: strs = ["dog","racecar","car"]
//Output: ""
//Explanation: There is no common prefix among the input strings.
 

//Constraints:

//1 <= strs.length <= 200
//0 <= strs[i].length <= 200
//strs[i] consists of only lowercase English letters.

func longestCommonPrefix(_ strs: [String]) -> String {
        
        if strs.isEmpty { return "" }
        var common = strs[0]
        
        for ch in strs {
            //print("from for str: \(ch) and \(common)")
            //print("\n \(!ch.hasPrefix(common))")
            while !ch.hasPrefix(common) {
                common = String(common.dropLast())
                
               // print("from while str: \(ch) and \(common)")
            }
            
        }
        return common
    }

let strs = ["flower","flow","flight","forest" , "from", "faizabad","flower","flow","flight","forest" , "from", "faizabad","flower","flow","flight","forest" , "from", "faizabad"]
//print(longestCommonPrefix(strs))


//13. Run-length encoding : Remaning


//14. String permutations : Remaning


//15. Reverse the words in string
str = "Hello World!"
print("Original str : \(str)\nReversed str : \(String(str.reversed()))")
