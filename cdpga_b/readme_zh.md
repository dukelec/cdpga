FPGA ICE40UL1K-CM36A 最小系統板
=======================================

1. [介紹](#介紹)
2. [操作示範](#操作示範)
6. [相關資料](#相關資料)

<img src="img/cdctl_bx.jpg" width="60%">


## 介紹

CDPGA_BX 爲 Lattice 之 iCE40 UL 系列 FPGA (ICE40UL1K-CM36A) 最小系統板（爲 CDCTL_BX 匯流排控製器未燒寫版本），板上資源含有：
 - 引出 12 個 IO 埠（其中 4 個與配置埠復用）；
 - 16 M 時鐘，可經內部 PLL 輸出更高頻率；
 - 只需外部供電 3.3 V 即可使用。

Lattice 器件使用較爲便捷：
 - 價格便宜，體積小，封裝選擇多；
 - 可內部配置，防止破解；
 - 無需私有燒錄工具，使用任意 FT232H 系列 USB 轉 SPI 工具即可；
 - 開發軟體和燒錄工具免費且相對小巧，支援 Linux 和 Windows 平臺（Linux 版本開發軟體不足 400 MByte）。

模組支持 3 種配置方式：
 - 由外部 MCU 或燒錄工具寫入 SRAM, 官方提供 SPI 寫入時序和示例代碼，FPGA 做從，這種方式不限制寫入次數，還可以隨時切換韌體，但掉電韌體會丟失；
 - 由外部 SPI FLASH 配置晶片提供，FPGA 做主，上電自動讀取韌體（FLASH 數據可由燒錄工具直接寫入）；
 - 燒寫 FPGA 內部 NVCM OTP 存儲器，只可燒寫一次，燒錄後上電可默認由內部 NVCM 配置；而且依然可以通過 MCU 配置，但無法再使用外部 SPI FLASH 配置方式。


## 操作示範

### 建立項目
下載安裝 Lattice iCEcube2 軟體，然後 File -> New Project 以新建項目：
<img src="img/a1 creat project.png" width="80%">

填寫項目名和路徑後，然後點擊 Next 會彈出添加檔案的視窗，
需要添加 HDL 代碼、SDC 時序約束、PCF 管腳定義，完成後點擊 Finish 即可，檔案也可在項目建立完畢之後再添加。
<img src="img/a2 add files.png" width="80%">

然後點擊 Run Synplify Pro Synthesis 進行綜合：
<img src="img/a3 synthesis.png" width="80%">

然後點擊 Run P & R 佈線並生成燒錄檔案：
<img src="img/a4 placer router.png" width="80%">

最後檢查時序是否滿足：
對於 FPGA 開發，只要 RTL 模擬通過，時序約束亦滿足，那麼就基本不會出問題，（譬如 Altera 公司較新版 Quartus 對很多器件都不再支援 post-route simulation）。
<img src="img/a5 timing analysis.png" width="80%">


### 查看電路
<img src="img/b1 open synplify.png" width="80%">
<img src="img/b2 rtl view.png" width="80%">


### 下載韌體
通過 FT232H 系列的 USB 轉 SPI 工具連接電路：  
（人頭是一個免銲接的轉接板，引出核心板所有引腳，鼻子晶片是 MAX3485, 默認未接入電路）  
具體接線方式請參考器件相關資料，譬如：`iCE40 Ultra Breakout Board Users Guide`.

<img src="img/c1 connect device.jpg" width="80%">
<img src="img/c2 wiring.jpg" width="80%">
<img src="img/c3 open programmer.png" width="40%">
<img src="img/c4 select mode.png" width="80%">
<img src="img/c5 programming.png" width="80%">

Linux 用家需要把 ftdi_sio driver 屏蔽，否則會把 FT232H 默認識別爲串口：
```sh
$ cd /lib/modules/`uname -r`/kernel/drivers/usb/serial/
$ sudo mv ftdi_sio.ko ftdi_sio.ko.bk
$ sudo rmmod ftdi_sio
```

### 模擬測試
你可以使用自己習慣的模擬方式和工具，譬如你可以直接使用 ModelSim, 或者通過 Quartus, ISE 等 IDE 來測試代碼之功能。
這裡僅給出我偏好的方式和官方提供的方式。

#### 通過 python 模擬測試
安裝軟體 `iverilog` (>= v10) 和下載 `cocotb`, 進入 `test_python/` 目錄，通過以下命令即可完成模擬執行：
```sh
$ COCOTB=/path/to/cocotb make
```
最後通過 GTKWave 查看輸出的波形檔案：
<img src="img/d1 cocotb.png" width="100%">
修改代碼再次模擬執行後，只需點擊 GTKWave 的 Reload 按鈕即可更新視窗。

關於 cocotb 具體用法請自行前往其項目專頁查閱相關文檔。

#### iCEcube2 模擬測試

iCEcube2 中包含的 Active-HDL 模擬工具僅存在於 Windows 版本，具體使用方式在新的頁面中查看：[iCEcube2 Simulation](icecube2_sim.md).


## 相關資料
 - [原理圖](files/cdctl_bx_sch.pdf)
 - [位置圖](files/cdctl_bx_component.png)

### 尺寸圖

<img src="files/cdctl_b1_dimension.svg" style="max-width:100%">


