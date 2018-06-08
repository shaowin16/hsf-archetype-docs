# 配置

## hsf配置
provider模块下resource/rpc目录为hsf配置文件目录。

![](http://p9vs76p49.bkt.clouddn.com/2018-06-06-15282750414793.jpg)

其中，用 *hsf:provider* 标签表明提供一个服务生产者，用 *hsf:consumer* 标签表明消费一个服务实例。

可以参考官方文档关于hsf的 [特性](https://help.aliyun.com/document_detail/44890.html?spm=a2c4g.11186623.6.657.wcO3Ad#h2--2) 和 [使用](https://help.aliyun.com/document_detail/44170.html?spm=a2c4g.11186623.6.654.H8ThTR#h2-u914Du7F6Eu670Du52A1u5C5Eu60272)。

## springboot配置

这里采用的是properties文件的方式进行参数配置。

- application.properties文件包含了通用的配置，如spring aop配置，服务端口号，hsf配置以及多环境支持配置等。

- application-dev.properties和application-prod.properties文件主要区分开发和生产环境配置，如数据库配置。

- 如有需要可以继续添加多个环境的配置文件，在application.properties通过指定环境名生效对应的配置文件。

## logback配置

当前日志配置默认按info级别打印输出到日志文件，日志文件每天按大小切割，最多存储30天，可以根据实际需求进行更改。

相关参数配置可以参考 [官方文档](https://logback.qos.ch/manual/appenders.html)。

