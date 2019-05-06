import UIKit

// Numbers
let a: Int = 1
let b: Float = 0.15
let c: Double = 45.5464623466

// Strings
let str1 = "Hello"
let str2 = String("World")
let str3 = "\(str1), \(str2)"

// Collections
let array = [1, 2, 3]
let dictionary = ["a": 1, "b": 2, "c": 3]
let set = Set([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

// Array
array.count
array.isEmpty
var colors = [String]() // Array<String>()
colors.append("yellow")
colors.insert("green", at: 1)
colors.remove(at: 1)
colors.removeAll()
var vegetables = ["Leek", "Carrot", "Cabbage"]
vegetables[0]
vegetables[2] = "Tom"
vegetables
for vegetable in vegetables {
    print(vegetable)
}

// Sets - 集合中包含的每个值都是唯一的
var set1 = Set<String>()
var set2: Set<String> = []
var set3: Set<String> = ["Orange", "Cherry", "Apple"]
set3.count
set3.isEmpty
set3.insert("Jerry")
set3.remove("Apple")
set3.remove("TT")
for s in set3 {
    print(s)
}
/* 独特性和强大之处 */ // 因为具有独特的特性。对于某些任务，集合比数组更高效
let john: Set = ["_bartjacobs", "cocoacasts", "clattner_llvm"]
let anna: Set = ["gruber", "_bartjacobs", "jesse_squires", "clattner_llvm"]

let union = john.union(anna)
let intersection = john.intersection(anna)
let uniques = john.symmetricDifference(anna)
let subtracted = john.subtracting(anna)

// Dictionaries - key唯一
var stocks0 = [String: Double]()
var stocks1 = Dictionary<String, Double>()
var stocks  = ["AAPL": 178.46, "GOOG": 1137.51, "TSLA": 350.02]
for (key, value) in stocks {
    print("\(key): \(value)")
}
stocks.count
stocks.isEmpty
stocks.keys
stocks.values
stocks["TWTR"] = 23.66 // add key-value pair
stocks["AAPL"] // read value for key
stocks["GOOG"] = 2150.87 // update value for key
stocks["TSLA"] = nil // remove key-value pair
stocks.updateValue(23.22, forKey: "TSLA")
stocks.updateValue(2019.57, forKey: "GOOG")
stocks.removeValue(forKey: "GOOG")
stocks.removeAll()

// Tuples - 使用元组时，重要的是要记住元组是为临时存储相关数据而设计的。对于更复杂的数据结构，更好，甚至建议使用类和结构
func fetchFileDetails() -> (String, String, Int) {
    return ("draft.md", "text/markdown", 2076)
}
let fileDetails = fetchFileDetails()
fileDetails.0
fileDetails.1
fileDetails.2

func fetchFileDetails_1() -> (name: String, type: String, size: Int) {
    return ("draft.md", "text/markdown", 2076)
}
let fileDetails_1 = fetchFileDetails_1()
fileDetails_1.name
fileDetails_1.type
fileDetails_1.size
let (name, type, size) = fetchFileDetails_1()
let sizeAsKb = size / 1024
let sizeAsString = "\(sizeAsKb)KB"

// Conditionals - 条件语句 if/guard/switch
// if
let isUserLoggin = false
func showLoginView() {
    print("show login view")
}
if !isUserLoggin {
    showLoginView()
}

