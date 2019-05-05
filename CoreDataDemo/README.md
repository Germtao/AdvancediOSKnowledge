# 如何监听一个托管对象上下文
   有没有想过`NSFetchedResultsController`类如何发挥其魔力？只要获取请求的结果发生变化，就会神奇地通知获取的结果控制器。 `Core Data`框架公开了几个API，允许开发人员复制`NSFetchedResultsController`类的行为。

## 通知
Core Data框架使用通知来通知对象在托管对象上下文中发生的更改。每个托管对象上下文都发布三种类型的通知，以通知对象有关托管对象上下文中发生的更改：

* `NSManagedObjectContextObjectsDidChangeNotification`
* `NSManagedObjectContextWillSaveNotification`
* `NSManagedObjectContextDidSaveNotification`
