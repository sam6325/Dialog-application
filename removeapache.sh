#!/bin/bash

# 安裝 dialog（如果尚未安裝）
if ! command -v dialog &> /dev/null; then
    echo "dialog 未安裝，正在安裝..."
    sudo apt install dialog -y
fi

# 提示使用者是否刪除 listrace 相關檔案
dialog --title "刪除 listrace" --yesno "是否刪除 listrace 相關檔案？" 8 50
if [ $? -eq 0 ]; then
    rm -rf lis*
    dialog --msgbox "listrace 檔案已刪除！" 6 40
else
    dialog --msgbox "跳過刪除 listrace 檔案！" 6 40
fi

# 提示使用者是否刪除 /var/www/ 目錄
dialog --title "刪除 /var/www/" --yesno "是否刪除 /var/www/ 目錄（網站資料）？" 8 50
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

dialog --msgbox "清理完成！" 6 40

