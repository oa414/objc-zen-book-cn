# NSNotification

当你定义你自己的 `NSNotification` 的时候你应该把你的通知的名字定义为一个字符串常量，就像你暴露给其他类的其他字符串常量一样。你应该在公开的接口文件中将其声明为 `extern` 的， 并且在对应的实现文件里面定义。

因为你在头文件中暴露了符号，所以你应该按照统一的命名空间前缀法则，用类名前缀作为这个通知名字的前缀。 

同时，用一个 Did/Will 这样的动词以及用 "Notifications" 后缀来命名这个通知也是一个好的实践。 

```objective-c
// Foo.h
extern NSString * const ZOCFooDidBecomeBarNotification

// Foo.m
NSString * const ZOCFooDidBecomeBarNotification = @"ZOCFooDidBecomeBarNotification";
```