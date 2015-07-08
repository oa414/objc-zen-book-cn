# Aspect Oriented Programming 面向切面编程

Aspect Oriented Programming (AOP，面向切面编程) 在 Objective-C 社区内没有那么有名，但是 AOP 在运行时可以有巨大威力。 但是因为没有事实上的标准，Apple 也没有开箱即用的提供，也显得不重要，开发者都不怎么考虑它。


引用 [Aspect Oriented Programming](http://en.wikipedia.org/wiki/Aspect-oriented_programming) 维基页面:

> An aspect can alter the behavior of the base code (the non-aspect part of a program) by applying advice (additional behavior) at various join points (points in a program) specified in a quantification or query called a pointcut (that detects whether a given join point matches). (一个切面可以通过在多个 join points 中 实行 advice 改变基础代码的行为(程序的非切面的部分) )


在 Objective-C 的世界里，这意味着使用运行时的特性来为 *切面* 增加适合的代码。通过切面增加的行为可以是：


* 在类的特定方法调用前运行特定的代码
* 在类的特定方法调用后运行特定的代码
* 增加代码来替代原来的类的方法的实现


有很多方法可以达成这些目的，但是我们没有深入挖掘，不过它们主要都是利用了运行时。 [Peter Steinberger](https://twitter.com/steipete) 写了一个库，[Aspects](https://github.com/steipete/Aspects) 完美地适配了 AOP 的思路。我们发现它值得信赖以及设计得非常优秀，所以我们就在这边作为一个简单的例子。

对于所有的 AOP库，这个库用运行时做了一些非常酷的魔法，可以替换或者增加一些方法（比 method swizzling 技术更有技巧性）


Aspect 的 API 有趣并且非常强大：

```objective-c
+ (id<AspectToken>)aspect_hookSelector:(SEL)selector
                      withOptions:(AspectOptions)options
                       usingBlock:(id)block
                            error:(NSError **)error;
- (id<AspectToken>)aspect_hookSelector:(SEL)selector
                      withOptions:(AspectOptions)options
                       usingBlock:(id)block
                            error:(NSError **)error;
```


比如，下面的代码会对于执行 `MyClass` 类的 `myMethod:`  (实例或者类的方法) 执行块参数。

```objective-c
[MyClass aspect_hookSelector:@selector(myMethod:)
                 withOptions:AspectPositionAfter
                  usingBlock:^(id<AspectInfo> aspectInfo) {
            ...
        }
                       error:nil];
```


换一句话说：这个代码可以让在 `@selector` 参数对应的方法调用之后，在一个  `MyClass` 的对象上（或者在一个类本身，如果方法是一个类方法的话）执行 block 参数。

我们为 `MyClass` 类的 `myMethod:` 方法增加了切面。

通常 AOP 用来实现横向切面的完美的适用的地方是统计和日志。

下面的例子里面，我们会用AOP用来进行统计。统计是iOS项目里面一个热门的特性，有很多选择比如 Google Analytics, Flurry, MixPanel, 等等.

大部分统计框架都有教程来指导如何追踪特定的界面和事件，包括在每一个类里写几行代码。

在 Ray Wenderlich 的博客里有 [文章](http://www.raywenderlich.com/53459/google-analytics-ios) 和一些示例代码，通过在你的 view controller 里面加入 [Google Analytics](https://developers.google.com/analytics/devguides/collection/ios/)  进行统计。

```objective-c
- (void)logButtonPress:(UIButton *)button {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
}
```


上面的代码在按钮点击的时候发送了特定的上下文事件。但是当你想追踪屏幕的时候会更糟糕。

```objective-c
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
```

对于大部分有经验的iOS工程师，这看起来不是很好的代码。我们让 view controller 变得更糟糕了。因为我们加入了统计事件的代码，但是它不是 view controller 的职能。你可以反驳，因为你通常有特定的对象来负责统计追踪，并且你将代码注入了 view controller ，但是无论你隐藏逻辑，问题仍然存在 ：你最后还是在`viewDidAppear:` 后插入了代码。



你可以用 AOP 来追踪屏幕视图来修改 `viewDidAppear:`  方法。同时，我们可以用同样的方法，来在其他感兴趣的方法里面加入事件追踪，比如任何用户点击按钮的时候（比如频繁地调用IBAction）


这个方法是干净并且非侵入性的：

* 这个 view controller 不会被不属于它的代码污染
* 为所有加入到我们代码的切面定义一个 SPOC 文件 (single point of customization)提供了可能
* SPOC 应该在 App 刚开始启动的时候就加入切面
* 公司负责统计的团队通常会提供统计文档，罗列出需要追踪的事件。这个文档可以很容易映射到一个 SPOC 文件。
* 追踪逻辑抽象化之后，扩展到很多其他统计框架会很方便
* 对于屏幕视图，对于需要定义 selector 的方法，只需要在 SPOC 文件修改相关的类（相关的切面会加入到 `viewDidAppear:` 方法）。如果要同时发送屏幕视图和时间，一个追踪的 label 和其他元信息来提供额外数据（取决于统计提供方）




我们可能希望一个 SPOC 文件类似下面的（同样的一个 .plist 文件会适配）

```objective-c
NSDictionary *analyticsConfiguration()
{
    return @{
        @"trackedScreens" : @[
            @{
                @"class" : @"ZOCMainViewController",
                @"label" : @"Main screen"
                }
             ],
        @"trackedEvents" : @[
            @{
                @"class" : @"ZOCMainViewController",
                @"selector" : @"loginViewFetchedUserInfo:user:",
                @"label" : @"Login with Facebook"
                },
            @{
                @"class" : @"ZOCMainViewController",
                @"selector" : @"loginViewShowingLoggedOutUser:",
                @"label" : @"Logout with Facebook"
                },
            @{
                @"class" : @"ZOCMainViewController",
                @"selector" : @"loginView:handleError:",
                @"label" : @"Login error with Facebook"
                },
            @{
                @"class" : @"ZOCMainViewController",
                @"selector" : @"shareButtonPressed:",
                @"label" : @"Share button"
                }
             ]
    };
}
```



这个提及的架构在 Github 的[EF Education First](https://github.com/ef-ctx/JohnnyEnglish/blob/master/CTXUserActivityTrackingManager.m) 中托管 

```objective-c
- (void)setupWithConfiguration:(NSDictionary *)configuration
{
    // screen views tracking
    for (NSDictionary *trackedScreen in configuration[@"trackedScreens"]) {
        Class clazz = NSClassFromString(trackedScreen[@"class"]);

        [clazz aspect_hookSelector:@selector(viewDidAppear:)
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSString *viewName = trackedScreen[@"label"];
                [tracker trackScreenHitWithName:viewName];
            });
        }];

    }

    // events tracking
    for (NSDictionary *trackedEvents in configuration[@"trackedEvents"]) {
        Class clazz = NSClassFromString(trackedEvents[@"class"]);
        SEL selektor = NSSelectorFromString(trackedEvents[@"selector"]);

        [clazz aspect_hookSelector:selektor
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UserActivityButtonPressedEvent *buttonPressEvent = [UserActivityButtonPressedEvent eventWithLabel:trackedEvents[@"label"]];
                [tracker trackEvent:buttonPressEvent];
            });
        }];

    }
}
```