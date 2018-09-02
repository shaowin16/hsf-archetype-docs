# 简单开发示例

> 这里以开发一个用户表的增删改查接口为例说明。

1. 通过前面的步骤生成模板工程后，选择使用idea导入：      

 ![](http://p9vs76p49.bkt.clouddn.com/2018-07-10-15311897970065.jpg)

2. 新建product实体类，添加hibernate注解，在配置的数据库里添加对应product表：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358721935476.jpg)

3. 编写mapper类
mapper类只需要写自定义查询即可，单表crud无需自己编写，这里写了根据id查询的方法，通过resource下的mapper文件夹统一存放编写有sql的xml文件：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358723390455.jpg)
 
 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358724297266.jpg)

4. 编写接口类和实现类
工程支持REST接口和RPC接口，若无需提供RPC接口，只需编写REST接口和实现类即可，如下图所示，提供了REST和RPC接口及其实现类，其中RPC接口类放在api模块的api包下：
 
 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358725859454.jpg)

 为了防止代码重复，REST接口实现类通过内部调用RPC接口的方式，再在RPC接口实现类内部调用mapper实现数据查询和持久化。

 > RPC接口按类型分为查询接口和写入接口放在两个包下，方便后期读写分离扩展。
 
5. 若需要暴露RPC接口，提供远程服务调用，则需要在RPC接口的实现类上通过注解的方式声明暴露：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358728175982.jpg)

6. 启动运行

    * 启动轻量级配置中心
    * 右键*StartupApplication*类运行，即可启动应用程序。

 ![](http://p9vs76p49.bkt.clouddn.com/2018-07-10-15312333702425.jpg)


!> 若启动报HSF-0016错误，请在idea的JVM启动参数添加-Dhsf.server.ip=你本地网卡的ip，一般本地ip可以填写127.0.0.1即可。
 
成功启动如下图所示：
 
![6月-08-2018 15-14-41](http://p9vs76p49.bkt.clouddn.com/2018-06-08-6月-08-2018 15-14-41.gif)

6. 验证

 - 通过接口调用测试接口是否正常运行。

 新增用户：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284425842634.jpg)

 根据id查询：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284426530345.jpg)

 分页查询：

 ![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284426781377.jpg)

 rest接口正常调用。
 
 至此，一个简单的用户增删改查功能已经完成。更多配置使用详情请参考使用手册部分的文档。
 
- rpc接口验证：
 
 启动服务，在轻量级配置中心可以看到对外暴露的RPC接口列表：
 
 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358741137979.jpg)
 
 将服务生产者打包，上传到maven私服，只需要打包api模块即可：
 
 ```
 mvn clean deploy -pl optimus-api
 ```
 
 在服务消费方项目provider模块pom文件内引入刚刚打包上传的依赖：
 
 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358751731444.jpg)
 
 修改消费方的HsfConfig配置类：
 
 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358758725768.jpg)

消费方即可像使用本地service类一样通过@Autowired 注解的方式引入使用ProductService了。

