//: # Homework 1 - Swift Playground

//: In order to answer the [EXPLAIN YOUR ANSWER HERE] questions,
//: you must go to Editor -> Show Raw Markup and edit the bracketed text.
//: Once done, go to Editor -> Show Rendered Markup to return to the previous view mode.


import UIKit


//: ## Q1: Optionals
class Words {
    var wordA : String!
    var wordB : String!
    
    init (wordA: String?, wordB: String?) {
        self.wordA = wordA
        self.wordB = wordB
    }

//: ### Are the values passed in to the **init** function and those set to the instance
//: ### variables the same type? If not, why?


//: No, the instance variables are of the implicitly unwrapped optional type while the variables passed in are regualr optionals. In the case of when wordA (same for wordB) being passed into the init function is nil, the instance variable wordA (and wordB) will always unwrap whenever self.wordA/wordB is used because the implicitly unwrapped optional assumes it has been assigned a string value and is safe to unwrap.


//: ## Q2: Variable Types and Function Types
    class func arePalindromes(words: [String]) -> Bool {
        let reversedWords = words.map() {String($0.characters.reverse())}
        let numElements = words.count
        
        for var i = 0; i < numElements; i++ {
            if words[i] != reversedWords[i] {
                return false
            }
        }
        return true
    }
//: ### Why does the compiler dislike the **for loop**? Fix it.
//: ### What else is wrong with this function? You may have to refer to (but **not**
//: ### change) the code at the very bottom. Debug the function.


//: The complier uses the let statement to refer to i as a constant. However, if i is a constant, then doing i++ is wrong because i cannot reassign (change) its value. i++ increments i and reassigns the new value to i, which requires i to be a mutable variable. The other problem is that in the function call, arePalindromes, they use the class to call the function instead of instantiating an object. However, to be called directly through the class requires the function to be class/static (part of the class instead of being part of a specific object). Finally, the arePalindromes does not return true if it succeeds. Also, a small syntax change was to change var to let for numElements since numElements is not modified in the method.


//: ## Q3: More Functions and Object Initialization
    func isAnagram() -> Bool {
        var countLetters = [Character : Int]() //Line X
        let lenA = self.wordA.characters.count
        let lenB = self.wordB.characters.count
        
        if lenA != lenB {
            return false
        }
        
        var arrA = Array(self.wordA.characters)
        var arrB = Array(self.wordB.characters)
        
        for i in 0...lenA-1 {
            let letter = arrA[i]
            if let val = countLetters[letter] { //Line Y
                countLetters[letter] = val + 1
            } else {
                countLetters[letter] = 1
            }
        }
        
        for i in 0...lenB-1 {
            let letter = arrB[i]
            if let val = countLetters[letter] {
                countLetters[letter] = val - 1
            } else {
                return false
            }
        }
        
        for (_, count) in countLetters {
            if count != 0 {
                return false
            }
        }
        
        return true
    }
//: ### What is the problem with declaring **countLetters** as we do in **Line X**,
//: ### and then using it in **Line Y**? Fix it (by only changing **Line X**).
//: ### What else is wrong with this function? You may have to refer to (but **not**
//: ### change) the code at the very bottom. Debug the function.


//: The problem is that countLetters is declared but there is never a value instantiated for it, thus making it nil. However, countLetters is not declared as an optional therefore it tricks the compiler through static typing that there will be a value for it. When it is used in the for loop, the problem will be if its nil the program will crash since it doesn't do any optional check or safe unwrapping because it doesn't know countLetters was never initialized. Therefore a value must be assigned to countLetters. Another error is isAnagram() does not have an optional return type but was returning nil and that it never had a correct case (return true). Also, isAnagram() cannot be a class method because it is being called with an instance of the class using instance variables, therefore this method needs to be changed into an instance method. Finally some small syntax things include replacing letters with _ since letters is not used, and setting the length of the words to constants since the words were not modified inside the isAmalgram method.
    
    
}


//: ## Check Your Answers
//: ### If you now see an output stream in the right sidebar, you have successfully
//: ### debugged the code above. Remember that you must also fully and correctly answer
//: ### all of the written questions above to receive full credit for this homework.


//: **DO NOT** touch any code below this point.
Words.arePalindromes(["hih", "racecar", "mom", "wow"])
Words.arePalindromes(["gene", "shawn", "hello"])
var wordsObj = Words.init(wordA: "anagram", wordB: "managra")
wordsObj.isAnagram()
wordsObj.wordA = "hello"
wordsObj.wordB = "what"
wordsObj.isAnagram()
