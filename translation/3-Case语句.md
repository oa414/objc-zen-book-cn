# Case语句

除非编译器强制要求，括号在 case 语句里面是不必要的。但是当一个 case 包含了多行语句的时候，需要加上括号。


```objective-c
switch (condition) {
    case 1:
        // ...
        break;
    case 2: {
        // ...
        // Multi-line example using braces
        break;
       }
    case 3:
        // ...
        break;
    default: 
        // ...
        break;
}
```


有时候可以使用 fall-through 在不同的 case 里面执行一样的代码。一个 fall-through  是指移除 case 语句的 “break” 然后让下面的 case 继续执行。

```objective-c
switch (condition) {
    case 1:
    case 2:
        // code executed for values 1 and 2
        break;
    default: 
        // ...
        break;
}
```


当在 switch 语句里面使用一个可枚举的变量的时候，`default` 是不必要的。比如：

```objective-c
switch (menuType) {
    case ZOCEnumNone:
        // ...
        break;
    case ZOCEnumValue1:
        // ...
        break;
    case ZOCEnumValue2:
        // ...
        break;
}
```


此外，为了避免使用默认的 case，如果新的值加入到 enum，程序员会马上收到一个 warning 通知

`Enumeration value 'ZOCEnumValue3' not handled in switch.`

### Enumerated Types 枚举类型


当使用 `enum` 的时候，建议使用新的固定的基础类型定义，因它有更强大的的类型检查和代码补全。 SDK 现在有一个 宏来鼓励和促进使用固定类型定义 - `NS_ENUM()`

*例子: **

```objective-c
typedef NS_ENUM(NSUInteger, ZOCMachineState) {
    ZOCMachineStateNone,
    ZOCMachineStateIdle,
    ZOCMachineStateRunning,
    ZOCMachineStatePaused
};
```
