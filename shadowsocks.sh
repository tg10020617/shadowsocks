#! /bin/sh

# 更新yum
yum update -y

# 安装pip
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
python get-pip.py

# 安装shadowsocks
pip install --upgrade pip
pip install shadowsocks

# 写入配置文件
touch /etc/shadowsocks.json

echo -e "{" >> /etc/shadowsocks.json
echo -e "\"server\": \"0.0.0.0\"," >> /etc/shadowsocks.json
echo -e "\"server_port\": 8388," >> /etc/shadowsocks.json
echo -e "\"password\": \"Q5konCq7rfUQ1KAd\"," >> /etc/shadowsocks.json
echo -e "\"method\": \"aes-256-cfb\"" >> /etc/shadowsocks.json
echo -e "}" >> /etc/shadowsocks.json

#cat > /etc/shadowsocks.json <<-EOF
#{
#    "server":"0.0.0.0",
#    "local_address":"127.0.0.1",
#    "local_port":1080,
#    "port_password": {
#        "9377":"gRvR04C988VB",
#        "9001":"2MgdE27klL9N",
#        "9820":"wDexVhSTJoEC"
#    },
#    "timeout":300,
#    "method":"aes-256-cfb",
#    "fast_open":false
#}
#EOF

# 写入启动脚本文件
touch /etc/systemd/system/shadowsocks.service

echo -e "[Unit]" >> /etc/systemd/system/shadowsocks.service
echo -e "Description=Shadowsocks" >> /etc/systemd/system/shadowsocks.service
echo -e >> /etc/systemd/system/shadowsocks.service
echo -e "[Service]" >> /etc/systemd/system/shadowsocks.service
echo -e "TimeoutStartSec=0" >> /etc/systemd/system/shadowsocks.service
echo -e "ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json" >> /etc/systemd/system/shadowsocks.service
echo -e >> /etc/systemd/system/shadowsocks.service
echo -e "[Install]" >> /etc/systemd/system/shadowsocks.service
echo -e "WantedBy=multi-user.target" >> /etc/systemd/system/shadowsocks.service

# 启动shadowsocks服务
systemctl enable shadowsocks
systemctl start shadowsocks
