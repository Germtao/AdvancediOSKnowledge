# 如何监听一个托管对象上下文
   有没有想过`NSFetchedResultsController`类如何发挥其魔力？只要获取请求的结果发生变化，就会神奇地通知获取的结果控制器。 `Core Data`框架公开了几个API，允许开发人员复制`NSFetchedResultsController`类的行为。

## 通知
`Core Data`框架使用通知来通知对象在托管对象上下文中发生的更改。每个托管对象上下文都发布三种类型的通知，以通知对象有关托管对象上下文中发生的更改：

* `NSManagedObjectContextObjectsDidChangeNotification`
* `NSManagedObjectContextWillSaveNotification`
* `NSManagedObjectContextDidSaveNotification`

### 托管对象上下文发生了变化
每次托管对象上下文中的托管对象更改时，都会广播`NSNotification.Name.NSManagedObjectContextObjectsDidChange`通知。每次从托管对象上下文插入，更新或删除托管对象时，托管对象上下文都会发布`NSNotification.Name.NSManagedObjectContextObjectsDidChange`通知。

### 托管对象上下文将保存
正如`NSNotification.Name.NSManagedObjectContextWillSave`通知的名称所示，此通知在执行保存操作之前发布。

### 托管对象上下文已保存
执行保存操作的托管对象上下文在成功保存其更改后发布`NSNotification.Name.NSManagedObjectContextDidSave`通知。

## 监听通知
添加对象作为`Core Data`通知的观察者很简单。在下面的示例中，视图控制器监视它具有引用的托管对象上下文。
```
import UIKit
import CoreData

class ViewController: UIViewController {
    
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let managedObjectContext = managedObjectContext {
            // Add Observer
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextObjectsDidChange(_:)),
                                           name: NSNotification.Name.NSManagedObjectContextObjectsDidChange,
                                           object: managedObjectContext)
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextWillSave),
                                           name: NSNotification.Name.NSManagedObjectContextWillSave,
                                           object: managedObjectContext)
            notificationCenter.addObserver(self,
                                           selector: #selector(managedObjectContextDidSave),
                                           name: NSNotification.Name.NSManagedObjectContextDidSave,
                                           object: managedObjectContext)
        }
    }
}
```

请注意，视图控制器专门监视它具有引用的托管对象上下文。如果将`nil`作为`addObserver`的最后一个参数`（_：selector：name：object :)`传递，则视图控制器将接收应用程序创建的每个托管对象上下文的通知。虽然这看起来很方便，但如果您正在使用复杂的`Core Data`堆栈，这可能会非常难以理解。在大多数情况下，建议监视特定的托管对象上下文。

## 处理通知
由观察托管对象上下文的对象决定如何处理它接收的信息。通知的`object`属性是发布通知的托管对象上下文。 如果对象正在观察多个托管对象上下文，则可以检查对象属性以找出发布通知的托管对象上下文。感兴趣的信息存储在通知对象的`userInfo`字典中，`userInfo`字典包括三个重要的键:

* `NSInsertedObjectsKey`
* `NSUpdatedObjectsKey`
* `NSDeletedObjectsKey`

每个`key`对应于一组托管对象。 这些集包含从发布通知的托管对象上下文中插入、更新和删除的托管对象。

```
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userinfo = notification.userInfo else { return }
        
        if let inserts = userinfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            inserts.count > 0 {
            
        }
        
        if let updates = userinfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
            updates.count > 0 {
            
        }
        
        if let deletes = userinfo[NSDeletedObjectsKey] as? Set<NSManagedObject>,
            deletes.count > 0 {
            
        }
    }
```

## 监控变更
了解之前讨论过的通知的触发内容非常重要。虽然`Core Data`是一个高性能框架，但也需要确保处理通知不会降低应用程序的速度。如果每次修改托管对象时都执行复杂操作，则可能会遇到性能问题。

### 监控更新
示例应用程序能够创建注释并将其链接到当前用户。用户可以有许多笔记，并且笔记始终与一个用户相关联。

我们感兴趣的方法是`ViewController`类中的`managedObjectContextObjectsDidChange（_ :)`。 `ViewController`类观察它具有引用的托管对象上下文，并且每次在托管对象上下文中修改托管对象时，都会调用`managedObjectContextObjectsDidChange（_ :)`方法。
```
    @objc private func managedObjectContextObjectsDidChange(_ notification: Notification) {
        guard let userinfo = notification.userInfo else { return }
        
        if let inserts = userinfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            inserts.count > 0 {
            print("--- INSERTS ---")
            print(inserts)
            print("+++++++++++++++")
        }
        
        if let updates = userinfo[NSUpdatedObjectsKey] as? Set<NSManagedObject>,
            updates.count > 0 {
            print("--- UPDATES ---")
            for update in updates {
                print(update.changedValues())
            }
            print("+++++++++++++++")
        }
        
        if let deletes = userinfo[NSDeletedObjectsKey] as? Set<NSManagedObject>,
            deletes.count > 0 {
            print("--- DELETES ---")
            print(deletes)
            print("+++++++++++++++")
        }
    }
```
在此方法中，我们检查通知对象的`userInfo`字典，并打印插入到托管对象上下文中和从中删除的每个托管对象。 对于更新，我们打印已修改的属性和值。 `changedValues()`方法返回一个字典，其中包含已修改的属性的名称，包括属性的旧值。

在模拟器中运行应用程序，点击左上角的`Profile`按钮，然后修改用户的名字。 点击底部的`保存`按钮时，将更新托管对象，并通过托管对象上下文发布通知。 你应该在Xcode的控制台中看到:

```
--- UPDATES ---
["first": TAO, "last": TAO1]
+++++++++++++++
```
**`changedValues()`方法非常便于理解修改了哪些属性。**

### 监控插入
点击右上角的`+`按钮，为用户添加新笔记。在文本字段中输入标题，在文本视图中输入一些内容。点按`Save`按钮以保存记事。`NSNotification.Name.NSManagedObjectContextObjectsDidChange`通知也包含有关正在更新的托管对象的信息。

```
--- INSERTS ---
[<Note: 0x6000009ac910> (entity: Note; id: 0x600002ae3860 <x-coredata:///Note/tB0D34294-CBD4-4C11-8464-1546836159012> ; data: {
    content = "Todo-1";
    createdAt = nil;
    title = "todo-1";
    updatedAt = nil;
    user = "0x8ea8ec2f781e0304 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/User/p1>";
})]
+++++++++++++++
--- UPDATES ---
["first": TAO, "last": TAO1, "notes": {(
    <Note: 0x600000989e00> (entity: Note; id: 0x8ea8ec2f781e0306 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/Note/p1> ; data: {
    content = "Todo-1";
    createdAt = nil;
    title = "todo-0";
    updatedAt = nil;
    user = "0x8ea8ec2f781e0304 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/User/p1>";
}),
    <Note: 0x6000009ac910> (entity: Note; id: 0x600002ae3860 <x-coredata:///Note/tB0D34294-CBD4-4C11-8464-1546836159012> ; data: {
    content = "Todo-1";
    createdAt = nil;
    title = "todo-1";
    updatedAt = nil;
    user = "0x8ea8ec2f781e0304 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/User/p1>";
})
)}]
+++++++++++++++
```

### 监控删除
```
--- UPDATES ---
["last": TAO1, "first": TAO, "notes": {(
    <Note: 0x6000009ac910> (entity: Note; id: 0x600002ae3860 <x-coredata:///Note/tB0D34294-CBD4-4C11-8464-1546836159012> ; data: {
    content = "Todo-1";
    createdAt = nil;
    title = "todo-1";
    updatedAt = nil;
    user = "0x8ea8ec2f781e0304 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/User/p1>";
})
)}]
+++++++++++++++
--- DELETES ---
[<Note: 0x600000989e00> (entity: Note; id: 0x8ea8ec2f781e0306 <x-coredata://4E7903A8-F37A-41FB-9373-B828B26800D0/Note/p1> ; data: {
    content = "Todo-1";
    createdAt = nil;
    title = "todo-0";
    updatedAt = nil;
    user = nil;
})]
+++++++++++++++
```
