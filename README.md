# ObjC Zen Book 中文翻译（禅与 Objective-C 编写的艺术）


![](./images/zen-logo-thumb.png)

[ObjC Zen Book 原始链接](https://github.com/objc-zen/objc-zen-book)


Swift 虽然越来越热，但是 Objective-C 却仍然是 Swift 没有成熟之前，iOS/Mac OSX 开发的唯一选择。

ObjC Zen Book 非常棒，是对 Objective-C 语言程序书写的进阶佳作，相比于其他风格指南，本书正如作者介绍的：

```
现在虽然有很多指南，但是它们都是存在一些问题的。我们不想介绍一些死板的规定，我们想提供一个在不同开发者之间能达成一致的写代码的方法。随时间的推移，这本书开始转向面向如何设计和构建优秀的代码。
```

之前没有在网上看到相关的翻译，所以我希望能够通过翻译此书，惠及国内开发者朋友，同时也是对自己的锻炼。水平浅薄，有所不足之处请在 issue 批评指正，也欢迎各位朋友来贡献翻译。 

目前翻译工作进行1/4左右，在完成各个章节的自我审校后我会一小节一小节 Push 到代码仓库中供有兴趣的朋友批评指正。计划在2015年4月完成全部工作并邀请大牛进行审校后进行正式发布。


* [前言](./translation/1-1-前言.md#preface)
  * [Swift](#swift)
  * [For the Community](#for-the-community)
  * [Authors](#authors)
* [Conditionals](#conditionals)
  * [Yoda conditions](#yoda-conditions)
  * [nil and BOOL checks](#nil-and-bool-checks)
  * [Golden Path](#golden-path)
  * [Complex Conditions](#complex-conditions)
  * [Ternary Operator](#ternary-operator)
  * [Error handling](#error-handling)
* [Case Statements](#case-statements)
    * [Enumerated Types](#enumerated-types)
* [Naming](#naming)
  * [General conventions](#general-conventions)
  * [Constants](#constants)
  * [Methods](#methods)
  * [Literals](#literals)
* [Class](#class)
  * [Class name](#class-name)
  * [Initializer and dealloc](#initializer-and-dealloc)
    * [Designated and Secondary Initializers](#designated-and-secondary-initializers)
      * [Designated Initializer](#designated-initializer)
      * [Secondary Initializer](#secondary-initializer)
        * [References](#references)
    * [instancetype](#instancetype)
        * [Reference](#reference)
    * [Initialization Patterns](#initialization-patterns)
      * [Class cluster](#class-cluster)
      * [Singleton](#singleton)
  * [Properties](#properties)
      * [Init and Dealloc](#init-and-dealloc)
      * [Dot-Notation](#dot-notation)
    * [Property Declaration](#property-declaration)
      * [Private Properties](#private-properties)
    * [Mutable Object](#mutable-object)
    * [Lazy Loading](#lazy-loading)
  * [Methods](#methods)
    * [Parameter Assert](#parameter-assert)
    * [Private methods](#private-methods)
  * [Equality](#equality)
* [Categories](#categories)
* [Protocols](#protocols)
* [NSNotification](#nsnotification)
* [Beautifying the code](#beautifying-the-code)
    * [Spacing](#spacing)
    * [Line Breaks](#line-breaks)
    * [Brackets](#brackets)
* [Code Organization](#code-organization)
  * [Exploit Code Block](#exploit-code-block)
  * [Pragma](#pragma)
    * [Pragma Mark](#pragma-mark)
  * [Explicit warnings and errors](#explicit-warnings-and-errors)
  * [Docstrings](#docstrings)
  * [Comments](#comments)
    * [Header Documentation](#header-documentation)
* [Inter-Object Communication](#inter-object-communication)
  * [Blocks](#blocks)
    * [Under the Hood](#under-the-hood)
    * [Retain cycles on self](#retain-cycles-on-self)
  * [Delegate and DataSource](#delegate-and-datasource)
    * [Inheritance](#inheritance)
    * [Multiple Delegation](#multiple-delegation)
* [Aspect Oriented Programming](#aspect-oriented-programming)
* [References](#references)
    * [Other Objective-C Style Guides](#other-objective-c-style-guides)



