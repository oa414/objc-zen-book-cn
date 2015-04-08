# Aspect Oriented Programming 面向切面编程

Aspect Oriented Programming (AOP) is something not well-known in the Objective-C community but it should be as the runtime is so powerful that AOP should be one of the first things that comes to the mind. Unfortunately, as there is no standard de facto library, nothing comes ready to use out-of-the-box from Apple and the topic is far from being trivial, developers still don't think of it in nowadays. 

Aspect Oriented Programming (AOP，面向切面编程) 是在 Objective-C 社区内没有那么有名，但是 AOP 应该是因为它在运行时可以有巨大威力。 不幸的是，因为没有事实上的标准，Apple 没有开箱即用的提供，而且也显得不重要，开发者都不怎么考虑。

Quoting the [Aspect Oriented Programming](http://en.wikipedia.org/wiki/Aspect-oriented_programming) Wikipedia page:
引用 [Aspect Oriented Programming](http://en.wikipedia.org/wiki/Aspect-oriented_programming) 维基页面:

> An aspect can alter the behavior of the base code (the non-aspect part of a program) by applying advice (additional behavior) at various join points (points in a program) specified in a quantification or query called a pointcut (that detects whether a given join point matches).

> 一个切面可以通过改变基础代码的行为(程序的非切面的部分)

In the world of Objective-C this means using the runtime features to add *aspects* to specific methods. The additional behaviors given by the aspect can be either:

在 Objective-C 的世界里，这意味着使用运行时的特性来为 *切面* 增加适合的代码。通过切面增加的行为可以是：

* add code to be performed before a specific method call on a specific class
* add code to be performed after a specific method call on a specific class
* add code to be performed instead of the original implementation of a specific method call on a specific class

* 在特定的类的特定方法调用前运行特定的代码
* 在特定的类的特定方法调用后运行特定的代码
* 增加代码来替代原来的特定的类的特定的方法的实现

There are many ways to achieve this we are not digging into deep here, basically all of them leverage the power of the runtime. 
[Peter Steinberger](https://twitter.com/steipete) wrote a library, [Aspects](https://github.com/steipete/Aspects) that fits the AOP approach perfectly. We found it reliable and well-designed and we are going to use it here for sake of simplicity.
As said for all the AOP-ish libraries, the library does some cool magic with the runtime, replacing and adding methods (further tricks over the method swizzling technique).

有很多方法可以achieve我们没有深入挖掘，它们主要都是利用了运行时。 [Peter Steinberger](https://twitter.com/steipete) 写了一个库，[Aspects](https://github.com/steipete/Aspects) 完美地适合了 AOP的方法。我们发现它值得信赖以及设计优秀，所以我们就在这边作为一个朴素的例子。

对于所有的 AOP库，这个库用运行时做了一些非常酷的魔法，取代并且增加了方法（比method swizzling 技术更有技巧性）


The API of Aspect are interesting and powerful:

Aspect 的 API 有趣并且强大：

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

For instance, the following code will perform the block parameter after the execution of the method `myMethod:` (instance or class method that be) on the class `MyClass`.

比如，下面的代码会对于执行 `MyClass` 类的 `myMethod:`  (instance or class method that be) 执行块参数。

```objective-c
[MyClass aspect_hookSelector:@selector(myMethod:)
                 withOptions:AspectPositionAfter
                  usingBlock:^(id<AspectInfo> aspectInfo) {
            ...
        }
                       error:nil];
```

In other words: the code provided in the block parameter will always be executed after each call of the `@selector` parameter on any object of type `MyClass` (or on the class itself if the method is a class method).
 
换一句话shuoi：这个代码避免了 block 参数会总是执行在 `@selector`  参数调用之后，在一个  `MyClass` 的对象上（或者在一个类本身，如果方法是一个类方法的话）


We added an aspect on `MyClass` for the method `myMethod:`.

我们为 `MyClass` 类的 `myMethod:` 方法增加了切面。

Usually AOP is used to implement cross cutting concern. Perfect example to leverage are analytics or logging.

通常 AOP 用来实现横向切面的地方，完美的利用点是统计和日志。

In the following we will present the use of AOP for analytics. Analytics are a popular "feature" to include in iOS projects, with a huge variety of choices ranging from Google Analytics, Flurry, MixPanel, etc.
Most of them have tutorials describing how to track specific views and events including a few lines of code inside each class.

下面的例子里面，我们会用AOP用来进行统计。统计是iOS项目里面一个热门的特性，有很多选择比如Google Analytics, Flurry, MixPanel, 等等.

大部分都有教程来知道如何追踪特定的界面和事件，包括在每一个类里写几行代码。

On Ray Wenderlich's blog there is a long [article](http://www.raywenderlich.com/53459/google-analytics-ios) with some sample code to include in your view controller in order to track an event with [Google Analytics](https://developers.google.com/analytics/devguides/collection/ios/):

在 Ray Wenderlich 的博客里有 [article](http://www.raywenderlich.com/53459/google-analytics-ios) 和一些示例代码，通过[Google Analytics](https://developers.google.com/analytics/devguides/collection/ios/)来加入到你的view controller里面进行统计。

```objective-c
- (void)logButtonPress:(UIButton *)button {
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
}
```

The code above sends an event with context information whenever a button is tapped. Things get worse when you want to track a screen view:

上面的代码在按钮点击的时候发送了特定的上下文事件。当你想追踪屏幕的时候会更糟糕。

```objective-c
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Stopwatch"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}
```

This should look like a code smell to the most of the experienced iOS developers. We are actually making the view controller dirty adding lines of code that should not belong there as it's not responsibility of the view controller to track events. You could argue that you usually have a specific object responsible for analytics tracking and you inject this object inside the view controller but the problem is still there and no matter where you hide the tracking logic: you eventually end up inserting some lines of code in the `viewDidAppear:`.

对于大部分有经验的iOS工程师，这看起来不是很好的代码。我们让ViewController 变得糟糕因为我们加入了统计事件的代码，但是它不是 ViewController的职能。你可以反驳你通常有特定的对象来负责统计追踪并且你将代码注入了 viewcontroller，但是无论你追梦隐藏逻辑，问题仍然存在:你最后还是在`viewDidAppear:` 后插入了代码。


We can use AOP to track screen views on specific `viewDidAppear:` methods, and moreover, we could use the same approach to add event tracking in other methods we are interested in, for instance when the user taps on a button (i.e. trivially calling the corresponding IBAction).

你可以用 AOP 来追踪屏幕视图来特殊化 `viewDidAppear:`  方法。同时，我们可以用同样的方法来在其他感兴趣的方法里面加入事件追踪，比如任何用户点击按钮的时候（频繁的调用IBAction）

This approach is clean and unobtrusive:

这个方法是干净并且非侵入性的：

* the view controllers will not get dirty with code that does not naturally belongs to them
* it becomes possible to specify a SPOC file (single point of customization) for all the aspects to add to our code
* the SPOC should be used to add the aspects at the very startup of the app
* if the SPOC file is malformed and at least one selector or class is not recognized, the app will crash at startup (which is cool for our purposes) 
* the team in the company responsible for managing the analytics usually provides a document with the list of *things* to track; this document could then be easily mapped to a SPOC file
* as the logic for the tracking is now abstracted, it becomes possible to scale with a grater number of analytics providers
* for screen views it is enough to specify in the SPOC file the classes involved (the corresponding aspect will be added to the `viewDidAppear:` method), for events it is necessary to specify the selectors. To send both screen views and events, a tracking label and maybe extra meta data are needed to provide extra information (depending on the analytics provider).


* 这个 view controller 不会被不属于它的代码污染
* 为所有加入到我们代码的切面定义一个 SPOC 文件 (single point of customization)提供了可能
* SPOC 应该在 App 刚开始启动的时候就加入切面
* 公司负责统计的团队通常会提供统计文档，罗列出需要追踪的事件。这个文档可以很容易映射到一个 SPOC 文件。
* 追踪逻辑抽象化之后，扩展到 a grater number of 统计提供方变得可能
* 对于屏幕视图，足够在 SPOC 文件，类相关的（相当的层面会加入到 `viewDidAppear:` 方法）。对于必要的定义 selector 的方法，同时发送屏幕视图和时间，一个喝醉粽 label 和可能的额外的需要元信息来土工额外数据（取决于统计提供方）
*

We may want a SPOC file similar to the following (also a .plist file would perfectly fit as well):


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

The architecture proposed is hosted on GitHub on the [EF Education First](https://github.com/ef-ctx/JohnnyEnglish/blob/master/CTXUserActivityTrackingManager.m) profile.

这个提及的架构在 Github 中托管 [EF Education First](https://github.com/ef-ctx/JohnnyEnglish/blob/master/CTXUserActivityTrackingManager.m)

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