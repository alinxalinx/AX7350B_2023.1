# Xilinx Zynq 7000 系列开发板AX7350、AX7350B  
## 开发板介绍
### 开发板简介
开发板主要由 ZYNQ 7Z035 主芯片，4 个 DDR3，1 片 eMMC，1 个 QSPI FLASH 和一
些外设接口组成。ZYNQ 7Z035 采用 Xilinx 公司的 Zynq7000 系列的芯片，型号为
XC7Z035-2FFG676。ZYNQ7Z035 芯片可分成处理器系统部分 Processor System（PS）和
可编程逻辑部分 Programmable Logic（PL）。在 ZYNQ7350 芯片的 PS 端和 PL 端分别挂了
2 片 DDR3，每片 DDR3 容量高达 512M 字节，使得 ARM 系统和 FPGA 系统能独立处理和
存储的数据的功能。PS 端的 8GB eMMC FLASH 存储芯片和 256Mb 的 QSPI FLASH 用来静
态存储 ZYNQ 的操作系统、文件系统及用户数据。
AX7350B 开发板扩展了丰富的外围接口，其中包含 1 个 PCIex4 插槽、2 路光纤接口、2
路千兆以太网接口、4 路 USB2.0 HOST 接口、1 路 HDMI 输出接口，1 路 UART 串口接口、
1 路 SD 卡接口、1 个 FMC 扩展接口和一些按键 LED。
### 关键特性
  1. Xilinx ARM+FPGA 芯片 Zynq-7000 XC7Z035-2FFG676。
  2. 带有四片大容量的 512M 字节（共 2GB）高速 DDR3 SDRAM。其中两片挂载在 PS 端，可作为 ZYNQ 芯片数据的缓存，也可以作为操作系统运行的内存; 另外两片挂在 PL 端，可作为 FPGA 的数据存储，图像分析缓存，数据处理。  
  3. PS 端挂载一片 8GB eMMC FLASH 存储芯片，用户存储操作系统文件或者其他用户数据。
  4. 一片 256Mbit 的 QSPI FLASH 存储芯片, 可用作 ZYNQ 芯片的 Uboot 文件，系统文件和用户数据的存储;   
  5. 一路标准的 PCIEx8 的主机插槽用于 PCIE2.0 x4 通信, 可用于连接 PCIE2.0 x4, x2, x1 的 PCIE 板卡，实现 PCIE 数据通信。支持 PCI Express 2.0 标准，单通道通信速率可高达 5GBaud。 
  6. ZYNQ 的 GTX 收发器的 2 路高速收发器连接到 2 个光模块的发送和接收，实现 2 路高速的光纤通信接口。每路的光纤数据通信接收和发送的速度高达 10Gb/s。 
  7. 2 路 10/100M/1000M 以太网 RJ45 接口，用于和电脑或其它网络设备进行以太网数据交换。网络接口芯片采用景略半导体的 JL2121 工业级 GPHY 芯片，1 路以太网连接到 ZYNQ 芯片的 PS 端，1 路以太网连接到 ZYNQ 芯片的 PL 端。  
  8. 1 路 HDMI 视频输出接口，我们选用了 ANALOG DEVICE 公司的 ADV7511 HDMI 编码芯片，最高支持 1080P@60Hz 输出，支持 3D 输出。
  9. 通过 USB Hub 芯片扩展 4 路 USB HOST 接口，用于连接外部的 USB 从设备，比如连接鼠标，键盘，U 盘等等。USB 接口采用扁型 USB 接口(USB Type A)。 
  10. 2 路 Uart 转 USB 接口，用于和电脑通信，方便用户调试。1 路在核心板上，核心板独立工作是使用，1 路在底板上， 整板调试时使用。串口芯片采用 Silicon Labs CP2102GM 的 USB-UAR 芯片, USB 接口采用 MINI USB 接口。 
  11. 1 路 Micro SD 卡座，用于存储操作系统镜像和文件系统。
  12. 1 个标准的 FMC LPC 的扩展口，可以外接 XILINX 或者我们黑金的各种 FMC 模块（HDMI 输入输出模块，双目摄像头模块，高速 AD 模块等等）。FMC 扩展口包含 34 对差分 IO 信号和一路高速 GTX 收发信号。
  13. 一路 USB JTAG 口，通过 USB 线及板载的 JTAG 电路对 ZYNQ 系统进行调试和下载
  14. 板载一个 33.333Mhz 的有源晶振，给 PS 系统提供稳定的时钟源，一个 50MHz 的有源晶振，为 PL 逻辑提供额外的时钟；另外板上有一个可编程的时钟芯片给 GTX 提供时钟源，为 PCIE，光纤和 DDR 工作提供参考时钟。
  15. 9 个发光二极管 LED, 1 个电源指示灯；1 个 DONE 配置指示灯；2 个串口通信指示灯，1 个 PS 控制 LED 灯，4 个 PL 控制指示灯。   
  16. 6 个按键，1 个复位按键，1 个 PS 用户按键，4 个 PL 用户按键。


# AX7350B、AX7350B 文档教程链接
https://ax7350b-20231-v101.readthedocs.io/zh-cn/latest/7350B_S1_RSTdocument_CN/00_%E5%85%B3%E4%BA%8EALINX_CN.html

 注意：文档的末尾页脚处可以切换中英文语言

# AX7350,AX7350B 例程
## 例程描述
此项目为开发板出厂例程，支持板卡上的大部分外设。
## 开发环境及需求
* Vivado 2023.1
* AX7350/AX7350B 开发板
## 创建Vivado工程
* 下载最新的ZIP包。
* 创建新的工程文件夹.
* 解压下载的ZIP包到此工程文件夹中。


有两种方法创建Vivado工程，如下所示：
### 利用Vivado tcl console创建Vivado工程
1. 打开Vivado软件并且利用**cd**命令进入"**auto_create_project**"目录，并回车
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. 输入 **source ./create_project.tcl** 并且回车
```
source ./create_project.tcl
```

### 利用bat创建Vivado工程
1. 在 "**auto_create_project**" 文件夹, 有个 "**create_project.bat**"文件, 右键以编辑模式打开，并且修改vivado路径为本主机vivado安装路径，保存并关闭。
```
CALL E:\XilinxVitis\Vivado\2023.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. 在Windows下双击bat文件即可。


更多信息, 请访问[ALINX网站](https://www.alinx.com)