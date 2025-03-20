# phpsysinfo 安裝與系統資訊查詢腳本

本腳本用於安裝 `Apache2` 和 `PHP`，並自動下載與設定 `phpsysinfo`。

## 使用方法

### 1. 執行腳本
請確保您的系統已安裝 `dialog`，然後執行腳本：
```bash
安裝
bash installapache.sh
bash installphpinfo.sh
移除
bash removeapache.sh
bash removephpinfo.sh
簡易算盤
bash calculator.sh
```

### 2. 操作流程
- **安裝 `Apache2` 和 `PHP`**：程式會自動安裝 Web 伺服器與 PHP 環境。
- **下載 `phpsysinfo`**：從 GitHub 下載 `phpsysinfo`，並自動解壓與配置。
- **選擇運算法，輸入第一和第二個數字，確認算式，顯示運算結果。
## `phpsysinfo` 介面
安裝完成後，請在瀏覽器開啟：
```
http://<你的IP>/phpsysinfo
```
查看伺服器的系統資訊。

## 注意事項
- 此腳本會執行 `sudo` 命令，因此請確保有管理員權限。
- 執行前請確保 `dialog` 指令可用，若無則安裝：
  ```bash
  sudo apt install dialog -y
  ```
- `phpsysinfo` 下載自 GitHub，若官方更新版本，請手動調整下載鏈接。

## 參考
- [phpsysinfo 官方 GitHub](https://github.com/phpsysinfo/phpsysinfo)

作者: Sam版本: 1.0
更新日期: 2025-03-20
