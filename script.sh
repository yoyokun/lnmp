# 备份本地源
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
# 更换阿里源
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
# 清空yum缓存
yum clean all
# 创建yum缓存，可能失败，多试几次
yum makecache
yum makecache
yum makecache
# GPG密钥可能错误，似乎可以通过执行以下命令来解决
curl -L https://yum.puppetlabs.com/RPM-GPG-KEY-puppet -o /tmp/RPM-GPG-KEY-puppet
sudo gpg --with-fingerprint "/tmp/RPM-GPG-KEY-puppet"
sudo cp /tmp/RPM-GPG-KEY-puppet /etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs-PC1
# 更新yum，可能失败，多试几次
yum update -y
yum update -y
yum update -y
# 更换PHP源
yum -y install epel-release && rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
# 安装vim
yum -y install vim
# 安装PHP
yum -y install php72w php72w-cli php72w-common php72w-devel php72w-embedded php72w-gd php72w-mbstring php72w-mysqlnd php72w-pdo php72w-pecl-memcached php72w-pecl-mongodb php72w-mcrypt php72w-odbc php72w-pdo_dblib php72w-pear php72w-pecl-apcu php72w-pecl-imagick php72w-phpdbg php72w-process php72w-bcmath php72w-pecl-redis
# 创建下载文件目录 & WEB目录
mkdir DownLoad
mkdir www
# 设置目录权限
chown vagrant:vagrant DownLoad
chown vagrant:vagrant www
# 安装解压插件
yum -y install unzip
# 下载和安装phpredis
cd DownLoad
wget https://codeload.github.com/phpredis/phpredis/zip/develop
unzip develop
cd phpredis-develop
phpize
./configure --with-php-config=/usr/bin/php-config
make && make install
# 下载和安装composer
cd ../
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
# 安装git克隆swoole，安装swoole
yum -y install git
git clone https://gitee.com/swoole/swoole.git
cd swoole
yum -y install openssl-devel
phpize
./configure --enable-openssl --enable-http2 --enable-sockets --enable-mysqlnd -with-openssl- dir=/usr/local/lib64
make && make install
# vi /etc/php.d/swoole.ini < EOF
#   i # 进入 insert 模式
#   extension = swoole.so # 输入文本内容
#   ^[ # 意为按下ESC退出编辑模式
#   :wq # 保存退出
# EOF
# 安装nginx
yum -y install nginx
# cat www.mythinkphp6.com.access.log | grep 'api/smscode' | awk '{print $ 4}' | uniq -c | sort -r
# 安装数据库mariadb
yum -y install mariadb mariadb-server
yum -y install vsftpd
# vi /etc/vsftpd/vsftpd.conf < EOF
#   i # 进入 insert 模式
#   extension = swoole.so # 输入文本内容
#   ^[ # 意为按下ESC退出编辑模式
#   :wq # 保存退出
# EOF
# touch /etc/vsftpd/chroot_list
# service vsftpd start
# 
# service mariadb start
# mysql_secure_installation
# mysql -uroot -p
# 安装redis
cd ../../
chown -R vagrant:vagrant *
cd DownLoad
wget http://download.redis.io/releases/redis-stable.tar.gz
tar xzf redis-stable.tar.gz
cd redis-stable
make MALLOC=libc
cp redis.conf /etc
cd src
cp redis-benchmark redis-cli redis-server /usr/bin
