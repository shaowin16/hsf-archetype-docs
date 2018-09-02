# Mybatis

> MyBatis 是一款优秀的持久层框架，它支持定制化 SQL、存储过程以及高级映射。MyBatis 可以使用简单的 XML 或注解来配置和映射原生信息，将接口和 Java 的 POJOs(Plain Ordinary Java Object,普通的 Java对象)映射成数据库中的记录。

## 集成配置

DataSourceConfig配置类内容如下：

```java
@Configuration
public class DataSourceConfig {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private Environment env;

    @Bean(name = "dataSource", destroyMethod = "close")
    @ConfigurationProperties(prefix = "spring.datasource")
    public DataSource dataSource() {
        return new DruidDataSource();
    }

    @Bean
    public SqlSessionFactory sqlSessionFactoryBean(@Qualifier("dataSource") DataSource dataSource) throws Exception {
        org.apache.ibatis.session.Configuration config = new org.apache.ibatis.session.Configuration();
        config.setMapUnderscoreToCamelCase(true);

        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(dataSource);
        sqlSessionFactoryBean.setConfiguration(config);

        //分页插件
        PageInterceptor pageInterceptor = new PageInterceptor();
        Properties properties = new Properties();
        properties.setProperty("helperDialect", "mysql");
        properties.setProperty("offsetAsPageNum", "true");
        properties.setProperty("rowBoundsWithCount", "true");
        pageInterceptor.setProperties(properties);
        //添加分页插件
        sqlSessionFactoryBean.setPlugins(new Interceptor[]{pageInterceptor});

        try {
            //指定基包
            sqlSessionFactoryBean.setTypeAliasesPackage(env.getProperty("mybatis.type-aliases-package"));
            sqlSessionFactoryBean.setMapperLocations(new PathMatchingResourcePatternResolver().getResources("classpath*:/mapper/*.xml"));
            return sqlSessionFactoryBean.getObject();
        } catch (Exception e) {
            logger.error("sqlSessionFactoryBean初始化失败：", e);
            return null;
        }
    }

}
```

## 基本使用

- **自定义查询**

 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358776875306.jpg)

 ![](http://p9vs76p49.bkt.clouddn.com/2018-09-02-15358779637016.jpg)

Mybatis 原生已支持通过注解方式进行自定义查询，但为了便于管理sql框架统一使用xml的方式对sql进行管理，xml统一放在resource目录的mapper文件夹下。

