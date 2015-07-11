#  美化代码

###  空格

* 缩进使用 4 个空格。 永远不要使用  tab, 确保你在 Xcode 的设置里面是这样设置的。
* 方法的大括号和其他的大括号(`if`/`else`/`switch`/`while` 等) 总是在同一行开始，在新起一行结束。

**推荐:**

```objective-c
if (user.isHappy) {
    //Do something
}
else {
    //Do something else
}
```

**不推荐:**

```objective-c
if (user.isHappy)
{
  //Do something
} else {
  //Do something else
}
```



*　方法之间应该要有一个空行来帮助代码看起来清晰且有组织。 方法内的空格应该用来分离功能，但是通常不同的功能应该用新的方法来定义。
优先使用 auto-synthesis。但是如果必要的话， `@synthesize` and `@dynamic` 
* 在实现文件中的声明应该新起一行。
* 应该总是让冒号对其。有一些方法签名可能超过三个冒号，用冒号对齐可以让代码更具有可读性。总是用冒号对其方法，即使有代码块存在。

【疑问】

**推荐:**

```objective-c
[UIView animateWithDuration:1.0
                 animations:^{
                     // something
                 }
                 completion:^(BOOL finished) {
                     // something
                 }];

```


**不推荐:**

```objective-c
[UIView animateWithDuration:1.0 animations:^{
    // something 
} completion:^(BOOL finished) {
    // something
}];
```

如果自动对齐让可读性变得糟糕，那么应该在之前把 block 定义为变量，或者重新考虑你的代码签名设计。

### Line Breaks 换行

本指南关注代码显示效果以及在线浏览的可读性，所以换行是一个重要的主题。

举个例子：

```objective-c
self.productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
```

一个像上面的长行的代码在第二行以一个间隔（2个空格）延续

```objective-c
self.productsRequest = [[SKProductsRequest alloc] 
  initWithProductIdentifiers:productIdentifiers];
```

###  括号


在以下的地方使用 [Egyptian风格 括号](https://en.wikipedia.org/wiki/Indent_style#K.26R_style) （译者注：又称 K&R 风格，代码段括号的开始位于一行的末尾，而不是另外起一行的风格。关于为什么叫做 Egyptian Brackets，可以参考 <http://blog.codinghorror.com/new-programming-jargon/> )

* 控制语句 (if-else, for, switch)

非 Egyptian 括号可以用在：

* 类的实现（如果存在)
* 方法的实现


