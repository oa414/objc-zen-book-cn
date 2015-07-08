
#  Protocols

在 Objective-C 的世界里面经常错过的一个东西是抽象接口。接口（interface）这个词通常指一个类的 `.h` 文件，但是它在 Java 程序员眼里有另外的含义： 一系列不依赖具体实现的方法的定义。

在 Objective-C 里是通过 protocol 来实现抽象接口的。因为历史原因，protocol （作为 Java 接口使用）并没有在 Objective-C 社区里面广泛使用。一个主要原因是大多数的 Apple 开发的代码没有包含它，而几乎所有的开发者都是遵从 Apple 的模式以及指南的。Apple 几乎只是在委托模式下使用 protocol。

但是抽象接口的概念很强大，它计算机科学的历史中就有起源，没有理由不在 Objective-C 中使用。

我们会解释 protocol 的强大力量（用作抽象接口），用具体的例子来解释：把非常糟糕的设计的架构改造为一个良好的可复用的代码。

这个例子是在实现一个 RSS 订阅的阅读器（它可是经常在技术面试中作为一个测试题呢）。

要求很简单明了：把一个远程的 RSS 订阅展示在一个 tableview 中。

一个幼稚的方法是创建一个 `UITableViewController` 的子类，并且把所有的检索订阅数据，解析以及展示的逻辑放在一起，或者说是一个 MVC (Massive View Controller)。这可以跑起来，但是它的设计非常糟糕，不过它足够过一些要求不高的面试了。

A minimal step forward would be to follow the Single Responsibility Principle and create at least 2 components to do the different tasks:

最小的步骤是遵从单一功能原则，创建至少两个组成部分来完成这个任务：

- 一个 feed 解析器来解析搜集到的结果
- 一个 feed 阅读器来显示结果


这些类的接口可以是这样的：

```objective-c

@interface ZOCFeedParser : NSObject

@property (nonatomic, weak) id <ZOCFeedParserDelegate> delegate;
@property (nonatomic, strong) NSURL *url;

- (id)initWithURL:(NSURL *)url;

- (BOOL)start;
- (void)stop;

@end

```

```objective-c

@interface ZOCTableViewController : UITableViewController

- (instancetype)initWithFeedParser:(ZOCFeedParser *)feedParser;

@end

```


`ZOCFeedParser` 用一个 `NSURL` 来初始化来获取 RSS 订阅（在这之下可能会使用 NSXMLParser 和 NSXMLParserDelegate 创建有意义的数据），`ZOCTableViewController` 会用这个 parser 来进行初始化。 我们希望它显示 parser 接受到的指并且我们用下面的 protocol 实现委托：


```objective-c

@protocol ZOCFeedParserDelegate <NSObject>
@optional
- (void)feedParserDidStart:(ZOCFeedParser *)parser;
- (void)feedParser:(ZOCFeedParser *)parser didParseFeedInfo:(ZOCFeedInfoDTO *)info;
- (void)feedParser:(ZOCFeedParser *)parser didParseFeedItem:(ZOCFeedItemDTO *)item;
- (void)feedParserDidFinish:(ZOCFeedParser *)parser;
- (void)feedParser:(ZOCFeedParser *)parser didFailWithError:(NSError *)error;
@end

```


用合适的 protocol 来来处理 RSS 非常完美。view controller 会遵从它的公开的接口：

```objective-c
@interface ZOCTableViewController : UITableViewController <ZOCFeedParserDelegate>
```


最后创建的代码是这样子的：

```objective-c
NSURL *feedURL = [NSURL URLWithString:@"http://bbc.co.uk/feed.rss"];

ZOCFeedParser *feedParser = [[ZOCFeedParser alloc] initWithURL:feedURL];

ZOCTableViewController *tableViewController = [[ZOCTableViewController alloc] initWithFeedParser:feedParser];
feedParser.delegate = tableViewController;
```

到目前你可能觉得你的代码还是不错的，但是有多少代码是可以有效复用的呢？view controller 只能处理 `ZOCFeedParser` 类型的对象： 从这点来看我们只是把代码分离成了两个组成部分，而没有做任何其他有价值的事情。


view controller 的职责应该是“从<someone>上显示一些内容”，但是如果我们只允许传递`ZOCFeedParser`的话就不是这样的了。这就表现了需要传递给 View controller 一个更泛型的对象的需求。


We modify our feed parser introducing the `ZOCFeedParserProtocol` protocol (in the ZOCFeedParserProtocol.h file where also `ZOCFeedParserDelegate` will be).

我们使用  `ZOCFeedParserProtocol` 这个 protocol (在 ZOCFeedParserProtocol.h 文件里面，同时文件里也有 `ZOCFeedParserDelegate` )

```objective-c

@protocol ZOCFeedParserProtocol <NSObject>

@property (nonatomic, weak) id <ZOCFeedParserDelegate> delegate;
@property (nonatomic, strong) NSURL *url;

- (BOOL)start;
- (void)stop;

@end

@protocol ZOCFeedParserDelegate <NSObject>
@optional
- (void)feedParserDidStart:(id<ZOCFeedParserProtocol>)parser;
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didParseFeedInfo:(ZOCFeedInfoDTO *)info;
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didParseFeedItem:(ZOCFeedItemDTO *)item;
- (void)feedParserDidFinish:(id<ZOCFeedParserProtocol>)parser;
- (void)feedParser:(id<ZOCFeedParserProtocol>)parser didFailWithError:(NSError *)error;
@end

```


注意这个代理 protocol 现在处理响应我们新的 protocol 而且 ZOCFeedParser 的接口文件更加精炼了：

```objective-c

@interface ZOCFeedParser : NSObject <ZOCFeedParserProtocol>

- (id)initWithURL:(NSURL *)url;

@end

```


因为 `ZOCFeedParser` 实现了 `ZOCFeedParserProtocol`，它需要实现所有需要的方法。
从这点来看 view controller  可以接受任何实现这个新的  protocol 的对象，确保所有的对象会响应从 `start` 和 `stop` 的方法，而且它会通过 delegate 的属性来提供信息。所有的 view controller  只需要知道相关对象并且不需要知道实现的细节。


```objective-c

@interface ZOCTableViewController : UITableViewController <ZOCFeedParserDelegate>

- (instancetype)initWithFeedParser:(id<ZOCFeedParserProtocol>)feedParser;

@end

```

上面的代码片段的改变看起来不多，但是有了一个巨大的提升。view controller 是面向一个协议而不是具体的实现的。这带来了以下的优点：

- view controller 可以通过 delegate 属性带来的信息的任意对象，可以是  RSS 远程解析器，或者本地解析器，或是一个读取其他远程或者本地数据的服务
- `ZOCFeedParser` 和 `ZOCFeedParserDelegate` 可以被其他组成部分复用
- `ZOCViewController` （UI逻辑部分）可以被复用
- 测试更简单了，因为可以用 mock 对象来达到 protocol 预期的效果

当实现一个 protocol 你总应该坚持 [里氏替换原则](http://en.wikipedia.org/wiki/Liskov_substitution_principle)。这个原则让你应该取代任意接口（也就是Objective-C里的的"protocol"）实现，而不用改变客户端或者相关实现。

此外这也意味着你的 protocol 不应该关注实现类的细节，更加认真地设计你的  protocol  的抽象表述的时候，需要注意它和底层实现是不相干的，协议是暴露给使用者的抽象概念。

任何可以在未来复用的设计意味着可以提高代码质量，同时也是程序员的目标。是否这样设计代码，就是大师和菜鸟的区别。

最后的代码可以在这找到。[here](http://github.com/albertodebortoli/ADBFeedReader).


