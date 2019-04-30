//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class Animal {
    func sound() {
        fatalError("Subclasses need to implement the `sound()` method.")
    }
}

class Cat: Animal {
    override func sound() {
        print("miauw")
    }
}

class Dog: Animal {
//    override func sound() {
//        print("woof")
//    }
}

let kitty = Cat()
kitty.sound()

let bobby = Dog()
//bobby.sound()

/**
 总结： 缺点
 一个重要的缺点是这个解决方案试图模仿抽象类模式。 Swift不支持抽象类，这个解决方案只不过是试图在Swift中修补抽象类的缺失。
 
 更重要的缺点是在编译时未检测到缺少的实现。 调用哪个方法是在运行时通过动态调度决定的。 这是该解决方案的主要限制
 */


protocol AnimalProtocol {
    func sound()
}

class Cat1: AnimalProtocol {
    func sound() {
        print("Cat1: miauw")
    }
}

class Dog1: AnimalProtocol {
    func sound() {
        print("Dog1: woof")
    }
    
    var maximumAge: Int {
        return 25
    }
}

/**
 总结：优点
 1. 如果协议未正确实现，编译器会在编译时通知我们。
 2. 类和结构都可以符合协议。 在Objective-C中不是这样。 协议绕过类型限制。 任何类型都可以符合AnimalProtocol协议
 */

extension AnimalProtocol {
    var maximumAge: Int {
        return 20
    }
    
    func feed() {
        print("eating")
    }
}

let cat1 = Cat1()
cat1.maximumAge
cat1.feed()

let dog1 = Dog1()
dog1.maximumAge
dog1.feed()
