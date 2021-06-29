import UIKit

// I. Arithmatic operators to solve this equation (3 1 3 9 = 12)
// We Are going to subtract between Pranthesis (3 subtracts 1) Multiplication with (Minus 3 Plus 9)
// So It's going to be (2) Multiplication with (6) Equals 12 which makes the left side Equals the Right Side
// and here's a code implmentation illustrates my solution
func arthimaticOperators() -> Bool {
    return (3 - 1) * (-3 + 9) == 12
}



arthimaticOperators()


/* II. Write a function/method utilizing Swift to determine whether two strings are anagrams or not (examples
of anagrams: debit card/bad credit, punishments/nine thumps, etc.)
 The idea after anagrams is if the two strings contains same chars no matter what its order*/

//Solution using Swift Sort algorithm
func swiftAnagramsChecker(stringA: String, stringB: String) -> Bool {

    return stringA.lowercased().sorted().filter { $0 != " "} == stringB.lowercased().sorted().filter { $0 != " "}
}
swiftAnagramsChecker(stringA: "debit card", stringB: "bad credit")
swiftAnagramsChecker(stringA: "punishments", stringB: "nine thumps") // false because punishments contains 2 s and nine thumps doesn't have the same char twice
swiftAnagramsChecker(stringA: "punishments", stringB: "nine thumpss")


/*III. Write a method in Swift to generate the nth Fibonacci number (1, 1, 2, 3,
5, 8, 13, 21, 34)*/

//A) Recursive Solution Big O of O(2^n)

func recursiveFib(n: Int) -> Int {
    guard n > 1 else {
        return n
    }
    return recursiveFib(n: n - 1) + recursiveFib(n: n - 2)
}
// it takes 10945 iteration to get the value according to N = 20
recursiveFib(n: 20)

//B) Iterative Solution Big O of O(n)

func iterativeFib(n: Int) -> Int {
    guard n > 1 else {return n}
        var tempA = 0
        var tempB = 1
        for _ in 2...n {
            let temp = tempB
            tempB = tempA + tempB
            tempA = temp
        }
        return tempB
}
//this solution gets the value in 19 iteration according to N = 20
iterativeFib(n: 20)

//IV. Which architecture would you use for the required task below? Why?
// I'm going to use MVVM-C Along with Protocol Oriented Network layer based on Routers, Because I'm considering I'm going to build a large scale project so I have to build an architecture easy to maintain and reliable for adding new features

/*
 V. Create a currency converter by utilizing data from the fixer.io API.
 The currency converter must include a currency selector at the top to use as the base currency and display updated currency rates based on the selected base currency. When a user taps on a currency, a calculation view should appear with the selected currency and base currency. Only the base currency field should be editable.
 Feel free to use any open source libraries.
 (Consider this project as if you were developing a component within a large-scaled project)
VI. Design Example
 */

// Answers on those going to be on Currency Converter Project
