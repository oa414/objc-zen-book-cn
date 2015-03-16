(待自我审校)
# Case Statements Case语句

括号在case语句里面是不必要的，除非编译器强制要求。当一个 case 包含了多行语句的时候，需要加上括号。

Braces are not required for case statements, unless enforced by the complier.  
When a case contains more than one line, braces should be added.

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

There are times when the same code can be used for multiple cases, and a fall-through should be used.  A fall-through is the removal of the 'break' statement for a case thus allowing the flow of execution to pass to the next case value.

有时候可以在不同的case里面用相同的代码，并且要使用 fall-through。 一个 fall-through  是一个case语句不执行 break 而让下面的 case 继续执行。

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

When using an enumerated type for a switch, `default` is not needed. For example:

当在Switch语句里面使用一个可枚举的变量的时候，`default` 是不必要的。比如：

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

Moreover, avoiding the default case, if new values are added to the enum, the programmer is immediately notified with a warning:

此外，避免使用默认的case，如果新的值加入到enum，程序员会马上收到一个warning通知

`Enumeration value 'ZOCEnumValue3' not handled in switch.`

### Enumerated Types 枚举类型

When using `enum`s, it is recommended to use the new fixed underlying type specification because it has stronger type checking and code completion. The SDK now includes a macro to facilitate and encourage use of fixed underlying types — `NS_ENUM()`

当使用 `enum` 的时候，建议使用新的固定的基础类型定义，因它有更强大的的类型检查和代码补全。 sDK 现在有一个 宏来鼓励和促进用固定基础类型定义 - `NS_ENUM()`

**Example:**

```objective-c
typedef NS_ENUM(NSUInteger, ZOCMachineState) {
    ZOCMachineStateNone,
    ZOCMachineStateIdle,
    ZOCMachineStateRunning,
    ZOCMachineStatePaused
};
```
