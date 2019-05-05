# 如何监听一个托管对象上下文
   有没有想过`NSFetchedResultsController`类如何发挥其魔力？只要获取请求的结果发生变化，就会神奇地通知获取的结果控制器。 `Core Data`框架公开了几个API，允许开发人员复制`NSFetchedResultsController`类的行为。

## 通知
Core Data框架使用通知来通知对象在托管对象上下文中发生的更改。每个托管对象上下文都发布三种类型的通知，以通知对象有关托管对象上下文中发生的更改：

* `NSManagedObjectContextObjectsDidChangeNotification`
* `NSManagedObjectContextWillSaveNotification`
* `NSManagedObjectContextDidSaveNotification`

**托管对象上下文发生了变化**
每次托管对象上下文中的托管对象更改时，都会广播`NSNotification.Name.NSManagedObjectContextObjectsDidChange`通知。每次从托管对象上下文插入，更新或删除托管对象时，托管对象上下文都会发布`NSNotification.Name.NSManagedObjectContextObjectsDidChange`通知。

**托管对象上下文将保存**
正如`NSNotification.Name.NSManagedObjectContextWillSave`通知的名称所示，此通知在执行保存操作之前发布。

**托管对象上下文已保存**
执行保存操作的托管对象上下文在成功保存其更改后发布`NSNotification.Name.NSManagedObjectContextDidSave`通知。
