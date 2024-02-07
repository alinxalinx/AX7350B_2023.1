# Xilinx Zynq 7000 series development boards AX7350, AX7350B
## Development board introduction
### Development board introduction
The development board mainly consists of ZYNQ 7Z035 main chip, 4 DDR3, 1 eMMC, 1 QSPI FLASH and a
It consists of some peripheral interfaces. ZYNQ 7Z035 uses Xilinx’s Zynq7000 series chip, model number is
XC7Z035-2FFG676. The ZYNQ7Z035 chip can be divided into the processor system part Processor System (PS) and
Programmable Logic (PL). The PS and PL ends of the ZYNQ7350 chip are hung up respectively.
2 pieces of DDR3, each piece of DDR3 has a capacity of up to 512M bytes, allowing the ARM system and FPGA system to independently process and
function of the stored data. The 8GB eMMC FLASH memory chip and 256Mb QSPI FLASH on the PS side are used to statically
State-of-the-art storage of ZYNQ's operating system, file system and user data.
The AX7350B development board expands a rich set of peripheral interfaces, including 1 PCIex4 slot, 2 optical fiber interfaces, 2
1 Gigabit Ethernet interface, 4 USB2.0 HOST interfaces, 1 HDMI output interface, 1 UART serial interface,
1 SD card interface, 1 FMC expansion interface and some button LEDs.
### Key Features
1. Xilinx ARM+FPGA chip Zynq-7000 XC7Z035-2FFG676.
2. Equipped with four large-capacity 512M bytes (total 2GB) high-speed DDR3 SDRAM. Two of them are mounted on the PS side and can be used as a cache for ZYNQ chip data and as a memory for operating system running; the other two are mounted on the PL side and can be used as FPGA data storage, image analysis cache, and data processing.
3. An 8GB eMMC FLASH memory chip is mounted on the PS side, and the user stores operating system files or other user data.
4. A 256Mbit QSPI FLASH memory chip, which can be used to store Uboot files, system files and user data of the ZYNQ chip;
5. One standard PCIEx8 host slot is used for PCIE2.0 x4 communication, which can be used to connect PCIE2.0 x4, x2, x1 PCIE boards to achieve PCIE data communication. Supports PCI Express 2.0 standard, single channel communication rate can be up to 5GBaud.
6. The 2-channel high-speed transceiver of ZYNQ's GTX transceiver is connected to the sending and receiving of 2 optical modules to realize 2-channel high-speed optical fiber communication interface. Each fiber optic data communication can receive and send at a speed of up to 10Gb/s.
7. 2-way 10/100M/1000M Ethernet RJ45 interface, used for Ethernet data exchange with computers or other network devices. The network interface chip uses Jinglue Semiconductor's JL2121 industrial-grade GPHY chip. One Ethernet channel is connected to the PS end of the ZYNQ chip, and one Ethernet channel is connected to the PL end of the ZYNQ chip.
8. For 1-channel HDMI video output interface, we chose ANALOG DEVICE's ADV7511 HDMI encoding chip, which supports up to 1080P@60Hz output and 3D output.
9. Expand the 4-way USB HOST interface through the USB Hub chip for connecting external USB slave devices, such as connecting mice, keyboards, U disks, etc. The USB interface adopts a flat USB interface (USB Type A).
10. 2-way Uart to USB interface, used to communicate with the computer to facilitate user debugging. Channel 1 is on the core board and is used when the core board works independently. Channel 1 is on the base board and is used when debugging the entire board. The serial port chip uses the USB-UAR chip of Silicon Labs CP2102GM, and the USB interface uses the MINI USB interface.
11. 1-way Micro SD card holder for storing operating system images and file systems.
12. 1 standard FMC LPC expansion port, which can be connected to XILINX or various FMC modules of our Black Gold (HDMI input and output module, binocular camera module, high-speed AD module, etc.). The FMC expansion port contains 34 pairs of differential IO signals and one high-speed GTX transceiver signal.
13. One USB JTAG port, debug and download the ZYNQ system through USB cable and onboard JTAG circuit
14. There is a 33.333Mhz active crystal oscillator on the board to provide a stable clock source for the PS system, and a 50MHz active crystal oscillator to provide an additional clock for the PL logic; in addition, there is a programmable clock chip on the board to provide a clock for the GTX Source, providing reference clock for PCIE, fiber optic and DDR operation.
15. 9 light-emitting diode LEDs, 1 power indicator light; 1 DONE configuration indicator light; 2 serial communication indicators, 1 PS control LED light, and 4 PL control indicator lights.
16. 6 buttons, 1 reset button, 1 PS user button, 4 PL user buttons.


# AX7350B、AX7350B document tutorial link


 Note: You can switch between Chinese and English languages at the footer at the end of the document

# AX7350, AX7350B routine
## Routine description
This project is the factory routine of the development board and supports most peripherals on the board.
## Development environment and requirements
* Vivado 2023.1
* AX7350/AX7350B development board
## Create Vivado project
* Download the latest ZIP package.
* Create a new project folder.
* Unzip the downloaded ZIP package into this project folder.


There are two ways to create a Vivado project, as follows:
### Use Vivado tcl console to create a Vivado project
1. Open the Vivado software and use the **cd** command to enter the "**auto_create_project**" directory and press Enter
```
cd \<archive extracted location\>/vivado/auto_create_project
```
2. Enter **source ./create_project.tcl** and press Enter
```
source ./create_project.tcl
```

### Use bat to create a Vivado project
1. In the "**auto_create_project**" folder, there is a "**create_project.bat**" file, right-click to open it in edit mode, and modify the vivado path to the vivado installation path of this host, save and close.
```
CALL E:\XilinxVitis\Vivado\2023.1\bin\vivado.bat -mode batch -source create_project.tcl
PAUSE
```
2. Double-click the bat file under Windows.


For more information, please visit [ALINX website](https://www.alinx.com)