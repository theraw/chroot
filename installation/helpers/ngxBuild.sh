clear
./configure \
--prefix=/nginx \
--sbin-path=/usr/sbin/nginx \
--conf-path=/nginx/nginx.conf \
--error-log-path=/var/nginx/logs/error.log \
--http-log-path=/var/nginx/logs/access.log \
--pid-path=/var/run/nginx.pid \
--lock-path=/var/run/nginx.lock \
--http-client-body-temp-path=/var/nginx/cache/client_tmp \
--http-proxy-temp-path=/var/nginx/cache/proxy_tmp \
--http-fastcgi-temp-path=/var/nginx/cache/fastcgi_tmp \
--http-uwsgi-temp-path=/var/nginx/cache/uwsgi_tmp \
--http-scgi-temp-path=/var/nginx/cache/scgi_tmp \
--user=nginx \
--group=nginx \
--with-threads \
--with-file-aio \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_addition_module \
--with-http_xslt_module \
--with-http_image_filter_module \
--with-http_geoip_module \
--with-http_sub_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_mp4_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_auth_request_module \
--with-http_random_index_module \
--with-http_secure_link_module \
--with-http_degradation_module \
--with-http_slice_module \
--with-http_stub_status_module \
--with-stream \
--with-stream_ssl_module \
--with-stream_realip_module \
--with-stream_geoip_module \
--with-stream_ssl_preread_module \
--with-pcre \
--with-pcre=/opt/nginx/helpers/pcre \
--with-pcre-jit \
--with-zlib=/opt/nginx/helpers/zlib \
--with-ld-opt="-Wl,-rpath,/usr/local/lib/" \
--add-module=/opt/nginx/mods/ngx_brotli \
--add-module=/opt/nginx/mods/ModSecurity-nginx
