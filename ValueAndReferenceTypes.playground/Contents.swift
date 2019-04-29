//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class Employee {
    var name = ""
}
var employee1 = Employee()
employee1.name = "Tom"

var employee2 = employee1
employee2.name = "Jerry"

print(employee1.name)
print(employee2.name)
// 总结: 因为类的实例是通过引用传递的，所以两个实例的name属性的值等于Jerry

struct EmployeeValue {
    var name = ""
}
var value1 = EmployeeValue()
value1.name = "Tom"
var value2 = value1
value2.name = "Jerry"
print(value1.name)
print(value2.name)
// 总结: 通过用struct替换class，示例的结果以显着的方式发生变化。
//      类的实例（对象）可以具有多个所有者。
//      结构体的实例有一个所有者。
//      将结构体的实例分配或传递给函数时，将复制其值。 传递结构体的唯一实例，而不是对结构体实例的引用。

/** 值类型 优点:
     1. 存储不可变数据:
        值类型非常适合存储数据。它们甚至更适合存储不可变数据。
     e.g.假设您有一个存储用户银行帐户余额的结构。如果将余额传递给某个函数，该函数不会希望在使用它时更改余额。通过将余额作为值类型传递，它将接收余额的唯一副本，无论其来自何处
 
     2. 操作数据
        值类型通常不会操作它们存储的数据。虽然提供用于对数据执行计算的接口很好且有用，但是值的所有者通过值存储数据
        这导致控制流程透明且可预测。值类型易于使用，另一个很大的好处是，它们在多线程环境中表现很好，干净，简单，透明
 */
