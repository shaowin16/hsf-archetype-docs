# 日志记录

> spring boot内部使用Commons Logging来记录日志，但也保留外部接口可以让一些日志框架来进行实现。默认情况下，spring boot使用Logback作为日志实现的框架。

## logback

LogBack读取配置文件的步骤:

1. 尝试classpath下查找文件logback-test.xml
2. 如果文件不存在，尝试查找logback.xml
3. 如果两个文件都不存在，LogBack用BasicConfiguration自动对自己进行最小化配置，这样既实现了上面我们不需要添加任何配置就可以输出到控制台日志信息。

我们在resources目录下创建了logback.xml文件，并且添加日志配置输出到文件内按天存储到不同的文件之中。具体配置如下图所示：

![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284251688818.jpg)

在logback.xml配置文件中，添加了控制台输出、文件每天输出、日志文件最大上限、日志的最低级别等。

resources目录下的application.properties文件定义了日志环境和级别等其他配置信息，如下图所示：

![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284253634868.jpg)

!> Logback更多配置用法请参考[官方文档](https://logback.qos.ch/manual/configuration.html)

## AOP日志

AOP是面向切面编程，利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各个部分的耦合性降低，提高代码的可重用性，同时提高开发效率。

通过AOP把所有REST接口作为切点，设置对应的切面和方法，让接口返回后进行返回通知，在这个通知方法中进行日志记录，既减少了代码量，也利于修改。

这里定义切面记录了HTTP请求详细内容和返回内容，同时记录了处理时间，对异常进行处理，如下图所示：

![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284258822620.jpg)

*@Pointcut*：声明切入点表达式        
*@Around*：同时在所拦截方法的前后执行一段逻辑




