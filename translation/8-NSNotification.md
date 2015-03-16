# NSNotification

When you define your own `NSNotification` you should define your notification's name as a string constant. Like any string constant that you want to make available to other classes, it should be declared as `extern` in the public interface, and defined privately in the corresponding implementation. 
Because you're exposing this symbol in the header you should follow the usual namespace rule prefixing the notification name with the class name that belongs to.
It's also good practice to name the notification using the verb Did/Will and terminate the name with the word "Notifications".

当你定义你自己的 `NSNotification` 的时候你应该把你的通知 的名字定义为一个字符串常量，就像你暴露给其他类的其他字符串常量一样。你应该在公开的接口文件中将其声明为 `extern` 的， 并且在对应的实现文件里面定义。

因为你在头文件中暴露了符号，所以你应该按照统一的命名空间前缀法则，用类名前缀作为这个通知名字的前缀。 

同时，用一个 Did/Will 这样的动词以及用 "Notifications" 后缀来命名这个通知一个好的实践。 

```objective-c
// Foo.h
extern NSString * const ZOCFooDidBecomeBarNotification

// Foo.m
NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";
```