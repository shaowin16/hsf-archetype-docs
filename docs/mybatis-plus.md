# Mybatis-Plus

> Mybatis-Plus（简称MP）是一个 Mybatis 的增强工具，在 Mybatis 的基础上只做增强不做改变，为简化开发、提高效率而生。

## 集成配置

DataSourceConfig配置类内容如下：

```java
@Configuration
@MapperScan("com.dtyunxi.stonehenge.mapper")
public class DataSourceConfig {

    @Bean(name = "dataSource", destroyMethod = "close")
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource dataSource() {
        return new DruidDataSource();
    }

    /**
     * 配置事物管理器
     */
    @Bean(name = "transactionManager")
    public DataSourceTransactionManager transactionManager() {
        return new DataSourceTransactionManager(dataSource());
    }

    /**
     * 數據源初始化配置
     * @param dataSource
     * @return
     * @throws Exception
     */
    @Bean
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        MybatisSqlSessionFactoryBean factory = new MybatisSqlSessionFactoryBean();
        factory.setDataSource(dataSource);
        return factory.getObject();
}
    /**
     * mybatis-plus 分页插件
     */
    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor page = new PaginationInterceptor();
        page.setDialectType("mysql");
        return page;
    }

}
```

## 基本使用

> MP在mybatis的基础上封装了通用crud方法。

- **实体注解**
![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284228066878.jpg)

*表名注解：* @TableName      
*主键注解：* @TableId        
*字段注解：* @TableField

- **DAO接口**

!> 假设我们已存在一张 User 表，且已有对应的实体类 User，实现 User 表的 CRUD 操作我们需要做什么呢？

```java
/** User 对应的 Mapper 接口 */
public interface UserMapper extends BaseMapper<User> { }
```

- **自定义查询**
![](http://p9vs76p49.bkt.clouddn.com/2018-06-08-15284235435379.jpg)

Mybatis 原生已支持通过注解方式进行自定义查询。

!> MP 还提供了 *代码生成器* 和 *条件构造器* 等功能，详情请参考[官方文档](http://mp.baomidou.com/)。


