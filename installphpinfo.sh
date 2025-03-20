#!/bin/bash

# 取得本機 IP
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# 安裝 dialog（如果尚未安裝）
if ! command -v dialog &> /dev/null; then
    echo "dialog 未安裝，正在安裝..."
    sudo apt install dialog -y
fi

# 問題函數
ask_user() {
    dialog --title "$1" --yesno "$2" 10 50
    return $?  # 0 = Yes, 1 = No
}

# 安裝 unzip
ask_user "安裝 unzip" "是否要安裝 unzip（用於解壓縮）？"
if [ $? -eq 0 ]; then
    sudo apt install unzip -y &> /dev/null
    dialog --msgbox "unzip 安裝完成！" 6 40
else
    dialog --msgbox "跳過 unzip 安裝！" 6 40
fi

# 安裝 Apache2
APACHE_INSTALLED=false
ask_user "安裝 Apache2" "是否要安裝 Apache2 網頁伺服器？"
if [ $? -eq 0 ]; then
    sudo apt install apache2 -y &> /dev/null
    dialog --msgbox "Apache2 安裝完成！" 6 40
    APACHE_INSTALLED=true
else
    dialog --msgbox "跳過 Apache2 安裝！\n無法繼續安裝 PHP 及 phpsysinfo。" 6 50
fi

# 如果 Apache 沒有安裝，則結束腳本
if [ "$APACHE_INSTALLED" = false ]; then
    exit 0
fi

# 安裝 PHP
ask_user "安裝 PHP" "是否要安裝 PHP（含 php-xml 及 php-json）？"
if [ $? -eq 0 ]; then
    sudo apt install php php-xml php-json -y &> /dev/null
    dialog --msgbox "PHP 安裝完成！" 6 40
    sudo service apache2 restart
else
    dialog --msgbox "跳過 PHP 安裝！\n無法繼續安裝 phpsysinfo。" 6 50
    exit 0
fi

# 下載 phpsysinfo
ask_user "下載 phpsysinfo" "是否要下載 phpsysinfo 伺服器監控工具？"
if [ $? -eq 0 ]; then
    wget https://github.com/phpsysinfo/phpsysinfo/archive/refs/tags/v3.4.4.zip &> /dev/null
    dialog --msgbox "phpsysinfo 下載完成！" 6 40
else
    dialog --msgbox "跳過 phpsysinfo 下載！" 6 40
    exit 0
fi

# 解壓 phpsysinfo
ask_user "安裝 phpsysinfo" "是否要解壓並安裝 phpsysinfo？"
if [ $? -eq 0 ]; then
    unzip v3.4.4.zip &> /dev/null
    sudo mv phpsysinfo-3.4.4/ /var/www/html/phpsysinfo
    sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini
    dialog --msgbox "phpsysinfo 已安裝！" 6 40
else
    dialog --msgbox "跳過 phpsysinfo 安裝！" 6 40
    exit 0
fi

# 顯示訪問網址
dialog --msgbox "您可以訪問 phpsysinfo：\n\n http://$IP_ADDRESS/phpsysinfo" 10 50

