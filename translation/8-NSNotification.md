# NSNotification

When you define your own `NSNotification` you should define your notification's name as a string constant. Like any string constant that you want to make available to other classes, it should be declared as `extern` in the public interface, and defined privately in the corresponding implementation. 
Because you're exposing this symbol in the header you should follow the usual namespace rule prefixing the notification name with the class name that belongs to.
It's also good practice to name the notification using the verb Did/Will and terminate the name with the word "Notifications".

当你定义你自己的 `NSNotification` 的时候你应该定义把你的 notification 的名字定义为一个字符串常量，就像很多你暴露给其他类的字符串常量一样。 他应该在 public 的 接口中定义为 `extern`， 在对应的实现文件里面定义为私有的。

因为你在头文件中暴露了符号，所以你应该按照通用的命名空间前缀法则，用类名作为这个 notification 名字的前缀。 

同时，用一个 Did/Will 这样的动词以及用 "Notifications" 结尾来命名这个  notification 也是一个好的实践。  

```objective-c
// Foo.h
extern NSString * const ZOCFooDidBecomeBarNotification

// Foo.m
NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";
```