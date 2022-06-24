```shell
mkdir ~/msyqlData

// 创建mysql

docker run -it --link sugar-mysql:mysql --rm mysql:5.7 sh -c 'exec mysql -h"$MYSQL_PORT_3306_TCP_ADDR" -P"$MYSQL_PORT_3306_TCP_PORT" -uroot -p"$MYSQL_ENV_MYSQL_ROOT_PASSWORD"'

CREATE DATABASE IF NOT EXISTS `sugarbi` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

//更改sugar配置。 更改sugar host改为sugar-mysql和license

// 创建sugar

```



1、同步数据库

http://127.0.0.1:8000/migration



2、更改sugar配置。

无论是 Docker 单机还是 Docker 集群模式运行Sugar BI，基本都是配置一些 env 环境变量，下面对这些环境变量配置进行说明：

- `sugar_can_connect_local_ip`：用来控制Sugar BI的数据源中是否能够连接局域网的 ip，一般私有部署情况下，配置为`true`即可，配置`false`可以让Sugar BI只能连接公网域名和 ip

- MySQL 数据库相关，这块是用来配置Sugar BI所依赖的 MySQL 数据库，详见[Sugar BI 所需的软件环境](https://cloud.baidu.com/doc/SUGAR/s/Gjyth5q2n#软件环境)

    - `sugar_db_username`: 用户名
    - `sugar_db_password`: 密码
    - `sugar_db_database`: 数据库名称
    - `sugar_db_host`: 填写您安装 MySQL 机器的 IP，即使是本机也不能使用 localhost 和 127.0.0.1
    - `sugar_db_port`: 端口号

- License 配置，详见[申请试用 License](https://cloud.baidu.com/doc/SUGAR/s/Wkkcfcpcc)

    - `sugar_company`: 组织代码
    - `sugar_license`: 详细的 License 内容（长串字符）

- 登录形式，支持 demo、email、password、oauth、token、ldap
  如果是最初步的测试，可以使用demo方式，后面的其他登录方式的配置都可以不用填写
  sugar_login_type=demo

  