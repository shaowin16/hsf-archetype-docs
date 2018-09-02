# 配置

## hsf配置
通过注解暴露和引入RPC接口。provider模块下config目录的HsfConfig类为消费方引入接口的配置类，若要暴露RPC接口注册到注册中心，只需要在接口的实现类上加上 *@HSFProvider* 注解即可。

生产者：

![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358769008774.jpg)

消费者：

![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358773227676.jpg)

![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358772367052.jpg)

可以参考官方文档关于hsf的 [特性](https://help.aliyun.com/document_detail/44890.html?spm=a2c4g.11186623.6.657.wcO3Ad#h2--2) 和 [使用](https://help.aliyun.com/document_detail/44170.html?spm=a2c4g.11186623.6.654.H8ThTR#h2-u914Du7F6Eu670Du52A1u5C5Eu60272)。

## springboot配置

这里采用的是properties文件的方式进行参数配置。

- application.properties文件包含了通用的配置，如spring aop配置，服务端口号，hsf配置以及多环境支持配置等。

- application-dev.properties和application-prod.properties文件主要区分开发和生产环境配置，如数据库配置。

- 如有需要可以继续添加多个环境的配置文件，在application.properties通过指定环境名生效对应的配置文件。

## logback配置

当前日志配置默认按info级别打印输出到日志文件，日志文件每天按大小切割，最多存储30天，可以根据实际需求进行更改。

相关参数配置可以参考 [官方文档](https://logback.qos.ch/manual/appenders.html)。

