# Swagger

> hsf模板工程使用Swagger2对RESTFUL接口文档在线自动生成和进行功能测试。

## SwaggerConfig的配置

provider模块下config包，JaxrsApplication类对Swagger进行了相关配置，如下图：

![](http://p9vs76p49.bkt.clouddn.com/2018-07-10-15312347348086.jpg)

其中，BeanConfig类包含了创建该Api的基本信息（这些基本信息会展现在文档页面中）。

## 配置API

通过在rest接口的实现类上添加注解的方式配置，如下图所示：

![](http://p9vs76p49.bkt.clouddn.com/2018-07-10-15312347970870.jpg)

#### 常用注解说明：

- **@Api**：用在类上，说明该类的作用

- **@ApiOperation**：用在方法上，说明方法的作用，标注在具体请求上，value和notes的作用差不多，都是对请求进行说明；tags则是对请求进行分类的，比如你有好几个controller，分别属于不同的功能模块，那这里我们就可以使用tags来区分了

- **@ApiImplicitParams**：用在方法上包含一组参数说明

- **@ApiImplicitParam**：用在@ApiImplicitParams注解中，指定一个请求参数的各个方面

　　*paramType*：参数放在哪个地方       
　　*header 请求参数的获取*：@RequestHeader       　  
　　*query 请求参数的获取*：@RequestParam     　　      
　　*path（用于restful接口）请求参数的获取*：@PathVariable      
　　*body*（不常用）       
　　*form*（不常用）     
　　*name*：参数名      
　　*dataType*：参数类型       
　　*required*：参数是否必须传        
　　*value*：参数的意思     
　　*defaultValue*：参数的默认值

- **@ApiResponses**：用于表示一组响应

- **@ApiResponse**：用在@ApiResponses中，一般用于表达一个错误的响应信息

　　*code*：数字，例如400       
　　*message*：信息，例如"请求参数没填好"      
　　*response*：抛出异常的类

- **@ApiModel**：描述一个Model的信息，表明这是一个被swagger框架管理的model，用于class上

- **@ApiModelProperty**：描述一个model的属性，就是标注在被标注了@ApiModel的class的属性上，这里的value是对字段的描述，example是取值例子

## 访问文档

启动程序后，通过http方式访问`http://localhost:8088/swagger.json`可获取到json格式的API文档。

!> hsf工程模板swagger结合yapi对API文档进行展示，本身并没有集成Swagger-UI，若开发者有需要可以自行接入Swagger-UI。


