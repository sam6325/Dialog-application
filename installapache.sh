#!/bin/bash

# 取得本機 IP
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# 安裝 dialog（如果尚未安裝）
if ! command -v dialog &> /dev/null; then
    echo "dialog 未安裝，正在安裝..."
    sudo apt install dialog -y
fi

# 變數：檢查 Apache 是否安裝
APACHE_INSTALLED=false

# 問題函數
ask_user() {
    dialog --title "$1" --yesno "$2" 10 50
    return $?  # 0 = Yes, 1 = No
}

# 安裝 Apache2
ask_user "安裝 Apache2" "是否要安裝 Apache2 網頁伺服器？"
if [ $? -eq 0 ]; then
    sudo apt install apache2 -y &> /dev/null
    dialog --msgbox "Apache2 安裝完成！" 6 40
    APACHE_INSTALLED=true
else
    dialog --msgbox "跳過 Apache2 安裝！\n無法繼續安裝網站模板。" 6 50
fi

# 如果 Apache 沒有安裝，則結束腳本
if [ "$APACHE_INSTALLED" = false ]; then
    exit 0
fi

# 下載網站模板
ask_user "下載網站模板" "是否要下載網站模板 (listrace)？"
if [ $? -eq 0 ]; then
    wget https://www.free-css.com/assets/files/free-css-templates/download/page296/listrace.zip &> /dev/null
    dialog --msgbox "模板下載完成！" 6 40
else
    dialog --msgbox "跳過模板下載！" 6 40
    exit 0
fi

# 解壓並移動文件
ask_user "安裝網站模板" "是否要安裝下載的網站模板？"
if [ $? -eq 0 ]; then
    unzip listrace.zip &> /dev/null
    sudo mv listrace-v1.0/* /var/www/html/
    dialog --msgbox "網站模板已安裝！" 6 40
else
    dialog --msgbox "跳過網站模板安裝！" 6 40
    exit 0
fi

# 顯示訪問網址
dialog --msgbox "您可以訪問您的網站：\n\n http://$IP_ADDRESS" 10 50

