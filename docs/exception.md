# 异常处理

> RestEasy提供了一个ExceptionMapper接口异常处理。

ExceptionMapper注册有多用方式有基于@Provider注解的，有基于web.xml的，这里使用基于注解的方式。

```java
@Component
@Provider
public class MyApplicationExceptionHandler implements ExceptionMapper<Exception> {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Override
    public Response toResponse(Exception exception) {
        logger.warn(exception.getMessage());

        //http返回码
        Response.ResponseBuilder responseBuilder = Response.status(Response.Status.INTERNAL_SERVER_ERROR);
        //返回的数据
        responseBuilder.entity(new Error(String.valueOf(Response.Status.INTERNAL_SERVER_ERROR.getStatusCode()), exception.getMessage()));
        //返回的数据类型
        responseBuilder.type(MediaType.APPLICATION_JSON);
        return responseBuilder.build();
    }

    private class Error {
        /**
         * 错误码
         */
        private String errorCode;
        /**
         * 错误消息
         */
        private String errorMessage;

        public Error(String errorCode, String errorMessage) {
            super();
            this.errorCode = errorCode;
            this.errorMessage = errorMessage;
        }

        public String getErrorCode() {
            return errorCode;
        }

        public void setErrorCode(String errorCode) {
            this.errorCode = errorCode;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
    }
}
```

!>  默认情况下，resteasy使用jackson来实现json格式的序列化。应用启动时，会自动扫描带@Provider的包，找到最合适的provider。

## 自定义异常

对于正常的业务异常，可以通过自定义异常类进行处理。

```java
public class ApplicationException extends RuntimeException implements Serializable {

    private static final long serialVersionUID = -7110316208734638051L;

    protected Logger logger = LoggerFactory.getLogger(this.getClass());


    public ApplicationException() {
        super();
    }

    public ApplicationException(Response.Status status, String msg) {
        super(status.getStatusCode() + "@" + msg);
    }

    public ApplicationException(Response.Status status, String msg, Exception e) {
        super(status.getStatusCode() + "@" + msg, e);
    }
}
```

通过继承RuntimeException，通过自定义构造函数，对异常信息进行处理返回。


