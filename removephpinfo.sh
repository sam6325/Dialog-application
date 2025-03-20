#!/bin/bash

# 安裝 dialog（如果尚未安裝）
if ! command -v dialog &> /dev/null; then
    echo "dialog 未安裝，正在安裝..."
    sudo apt install dialog -y
fi

# 提示使用者是否刪除 v3.4.4.zip
dialog --title "刪除 v3.4.4.zip" --yesno "是否刪除 v3.4.4.zip 安裝檔案？" 8 50
if [ $? -eq 0 ]; then
    rm -rf v3.4.4.zip
    dialog --msgbox "v3.4.4.zip 已刪除！" 6 40
else
    dialog --msgbox "跳過刪除 v3.4.4.zip！" 6 40
fi

# 提示使用者是否刪除 /var/www/ 目錄（網站資料）
dialog --title "刪除 /var/www/" --yesno "是否刪除 /var/www/ 目錄（所有網站資料）？" 8 50
if [ $? -eq 0 ]; then
    sudo rm -rf /var/www/
    dialog --msgbox "/var/www/ 目錄已刪除！" 6 40
else
    dialog --msgbox "跳過刪除 /var/www/ 目錄！" 6 40
fi

# 提示使用者是否移除 Apache2
dialog --title "移除 Apache2" --yesno "是否移除 Apache2 網頁伺服器？" 8 50
if [ $? -eq 0 ]; then
    sudo apt remove apache2 -y &> /dev/null
    dialog --msgbox "Apache2 已成功移除！" 6 40
else
    dialog --msgbox "跳過移除 Apache2！" 6 40
fi

# 提示使用者是否移除 PHP
dialog --title "移除 PHP" --yesno "是否移除 PHP 相關套件？" 8 50
if [ $? -eq 0 ]; then
    sudo apt remove php php-xml php-json -y &> /dev/null
    dialog --msgbox "PHP 已成功移除！" 6 40
else
    dialog --msgbox "跳過移除 PHP！" 6 40
fi

dialog --msgbox "清理完成！" 6 40

