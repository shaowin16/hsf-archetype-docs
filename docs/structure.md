# 目录结构

使用stonehenge-cli工具生成默认的hsf模板工程，目录结构如下所示：

```
.
├── Dockerfile
├── pom.xml
├── start-code.sh
├── stonehenge-api
│   ├── pom.xml
│   └── src
│       ├── main
│       │   ├── java
│       │   │   └── com
│       │   │       └── dtyunxi
│       │   │           └── stonehenge
│       │   │               ├── api
│       │   │               │   ├── ApplicationService.java
│       │   │               │   └── query
│       │   │               │       └── ApplicationQueryService.java
│       │   │               └── domain
│       │   │                   ├── dto
│       │   │                   │   ├── ApplicationDto.java
│       │   │                   │   └── Payload.java
│       │   │                   └── eo
│       │   │                       └── ApplicationEo.java
│       │   └── resources
│       └── test
│           ├── java
│           │   └── com
│           │       └── dtyunxi
│           │           └── stonehenge
│           └── resources
└── stonehenge-provider
    ├── pom.xml
    └── src
        ├── main
        │   ├── java
        │   │   └── com
        │   │       └── dtyunxi
        │   │           └── stonehenge
        │   │               ├── StartupApplication.java
        │   │               ├── aop
        │   │               │   └── LogAspect.java
        │   │               ├── config
        │   │               │   ├── DataSourceConfig.java
        │   │               │   └── JaxrsApplication.java
        │   │               ├── mapper
        │   │               │   └── ApplicationMapper.java
        │   │               └── service
        │   │                   ├── rest
        │   │                   │   ├── ApplicationRestServiceImpl.java
        │   │                   │   └── api
        │   │                   │       └── ApplicationRestService.java
        │   │                   └── rpc
        │   │                       ├── ApplicationServiceImpl.java
        │   │                       └── query
        │   │                           └── ApplicationQueryServiceImpl.java
        │   └── resources
        │       ├── application-dev.properties
        │       ├── application-prod.properties
        │       ├── application.properties
        │       ├── logback-spring.xml
        │       └── rpc
        │           └── hsf-provider.xml
        └── test
            ├── java
            │   └── com
            │       └── dtyunxi
            │           └── stonehenge
            └── resources
```

- 工程划分为 *api* 和 *provider* 两个模块。api模块包含rpc调用接口以及数据库映射实体；provider模块包含具体rpc接口实现类，以及对外直接暴露restful风格的接口和实现。     

- api模块下的*.api.query包包含了rpc调用的所有查询方法类，其他增删改对应类在api包下。单独划分出query查询包方便后期在应用层实现读写分离。

- api模块下的domain包分为dto包，包含了自定义封装的返回实体类，eo包内容为对应的数据库映射实体类。

- provider模块aop包包含了切面类，目前有统一日志处理类；config包下主要是相关的全局配置类；mapper包包含了orm持久层框架的dao接口类；service包内容为具体的业务接口实现类，其中service.rest为restful风格接口类和实现，service.rpc包含了rpc接口的具体实现类。

- provider模块的resources目录包含了工程的配置文件。

- 根目录下的Dockerfile和start-code.sh为docker运行的配置文件和启动脚本。


