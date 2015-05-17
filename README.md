# ObjC Zen Book 中文翻译（禅与 Objective-C 编写的艺术）


![](./images/zen-logo-thumb.png)

[ObjC Zen Book 原始链接](https://github.com/objc-zen/objc-zen-book)


Swift 虽然越来越热，但是 Objective-C 却仍然是 Swift 没有成熟之前，iOS/Mac OSX 开发的唯一选择。

ObjC Zen Book 非常棒，是对 Objective-C 语言程序书写的进阶佳作，相比于其他风格指南，本书正如作者介绍的：

> 现在虽然有很多指南，但是它们都是存在一些问题的。我们不想介绍一些死板的规定，我们想提供一个在不同开发者之间能达成一致的写代码的方法。随时间的推移，这本书开始转向面向如何设计和构建优秀的代码。

之前没有在网上看到相关的翻译，所以我希望能够通过翻译此书，惠及国内开发者朋友，同时也是对自己的锻炼。水平浅薄，有所不足之处请在 issue 批评指正，也欢迎各位朋友来贡献翻译。 

**本译文已取得原文作者授权允许翻译，并且将在完成翻译后，以 Fork 原仓库方式提交中文翻译的形式合并到官方仓库**

## 翻译标准

为了追求中文通顺，不影响原文意思的情况下，部分内容可能会改变一些描述，或者去掉一些英文的难以翻译的幽默。

此外，一些技术名词的翻译，可能没有明确的标准，但是会追求在这本小书内的统一，以及会列出一张翻译的对应名词表格。

|中文  | 英文 | 
| ----- | --------| 
|分类 | Categories |
|协议 | Protocols |
|接口 | interface |
|实践 | practice |
|签名 | signature |



##  排版规范和注意事项

- 参考 <https://github.com/objccn/articles/wiki/%E5%A6%82%E4%BD%95%E8%B4%A1%E7%8C%AE%E5%86%85%E5%AE%B9>

- 文章标题使用 \# 标记
章节标题从 \#\# 标记开始使用，按照层次每层增加一级，即 \#\#，\#\#\# 等。
代码可以在代码内容每行前使用四个空格开始，或是在代码顶格开始并前后使用三个 \`\`\` 符号。注意两种方式不要混用，另外无论使用哪种方式，代码缩进为4个空格。一行太长的代码（包括缩进80个字符以上）请注意在合适的地方进行换行和对齐。

- 较为专业术语请保留英文原文，特别是对于普遍习惯使用的短语或者英文内容更容易理解的词。比如，虽然有很多人将 Key Value Observing 翻译为 键值观察，但是应该更偏向于选择 KVO 这样通用的缩略形式。另外，千万不要将诸如 Grand Central Dispatch 翻译为大中枢派发之类的闻所未闻的叫法，请将其简单地写作 GCD 即可。

- 中文和英文混编时，如果一个英文单词/短语前后是中文字符，请留意随手在英文和中文之间留出一个半角空格，就像上面这条中做的这样

- 中文正文及标题中出现的英文及数字应该使用半角方式输入，并且在左右各留一个半角空格。如果这些这些半角英文及数字的左边或者右边紧接着任何的中文全角括号或者其他标点符号的话，则不需要加入半角空格。
代码中的注释我们希望您也能顺手进行翻译。



## 进度

目前内容都是追求速度的很粗略的翻译，需要进一步详细修订。

计划在2015年4月30日前完成全部工作，并邀请大牛进行审校后进行正式发布。

到自我修订阶段的译稿基本凑合能看。。


|章节  | 粗略翻译 | 自我修订 | 详细审校|
| ----- | --------| --- | ---- |
|1  | ✅| ✅ | ❌|
|2  | ✅| ✅ | ❌|
|3  | ✅| ✅ | ❌|
|4  | ✅| ✅ | ❌|
|5  | ✅| ❌ | ❌|
|6  | ✅| ✅ | ❌|
|7  | ✅| ✅ | ❌|
|8  | ✅| ✅ | ❌|
|9  | ✅| ✅ | ❌|
|10 | ✅| ✅ | ❌|
|11 | ✅| ❌ | ❌|
|12 | ✅| ✅ | ❌|
|13 | ✅| ✅ | ❌|

### TODO

- 完成自我修订
- 完成所有有疑问的地方的翻译
- 重新自我修订
- 删除英文和修正格式
- 邀请大牛审校

## 作者

原作者：

**Luca Bernardi**

- http://lucabernardi.com
- @luka_bernardi
- http://github.com/lukabernardi

**Alberto De Bortoli**

- http://albertodebortoli.com
- @albertodebo
- http://github.com/albertodebortoli

翻译和校队：

- 林翔宇 linxiangyu@nupter.org
- 庞博 bopang@sohu-inc.com

## 目录

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



