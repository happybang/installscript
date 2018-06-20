# installation configuration
NGINX_VERSION=1.12.2
NGINX_SRC_PATH=/root
NGINX_BIN_PATH=/usr/local/nginx

# disable firewall
service iptables stop
setenforce 0

# $   yum install gcc-c++
# $   yum install pcre pcre-devel
# $   yum install zlib zlib-devel
# $   yum install openssl openssl--devel

# installation dependence
yum install -y  gcc-c++   pcre-devel zlib-devel openssl-devel

# download nginx source package
cd ${NGINX_SRC_PATH}
wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz

# unzip source package
tar -xzvf nginx-${NGINX_VERSION}.tar.gz
cd ./nginx-${NGINX_VERSION}

# install nginx
./configure --prefix=${NGINX_BIN_PATH} --with-http_ssl_module
make & make install

# add nginx to system service
ln -s ${NGINX_BIN_PATH}/sbin/nginx /usr/sbin/nginx
cd ${NGINX_BIN_PATH}
wget http://download.cloudhosts.xyz/linux/nginx/config/service-nginx #如果这个文件无法下载，请下文的service-nginx.sh文件代替
mv service-nginx /etc/init.d/nginx
cd /etc/init.d/
chmod 755 nginx

# test nginx service
# service nginx restart
systemctl status nginx.service
