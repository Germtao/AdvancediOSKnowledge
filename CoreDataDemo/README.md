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
