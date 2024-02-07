/*
-- Company: 		Trenz Electronic
-- Engineer: 		Oleksandr Kiyenko
 */
#include "si5338.h"
#include "xiicps.h"
#include "xil_printf.h"
#define code
#include "register_map.h"

int si5338_write(XIicPs *InstancePtr, char Addr, char Data)
{
	int Status;
	u8 SendBuffer[2];

	SendBuffer[0] = Addr;
	SendBuffer[1] = Data;
	Status = XIicPs_MasterSendPolled(InstancePtr, SendBuffer, 2, IIC_ADDR);
	while (XIicPs_BusIsBusy(InstancePtr));

	return Status;
}

char si5338_read(XIicPs *InstancePtr, char Addr)
{
	u8 wr_data, rd_data;

	wr_data = Addr;
	XIicPs_MasterSendPolled(InstancePtr, &wr_data, 1, IIC_ADDR);
	XIicPs_MasterRecvPolled(InstancePtr, &rd_data, 1, IIC_ADDR);
	while (XIicPs_BusIsBusy(InstancePtr));
	return rd_data;
}

int si5338_write_mask(XIicPs *InstancePtr, char Addr, char Data, char Mask)
{
	u8 reg_val;

	if(Mask == 0xFF){	// All bits
		si5338_write(InstancePtr, Addr, Data);
	}
	else{						// Write by mask
		reg_val = si5338_read(InstancePtr, Addr);
		reg_val &= ~Mask;	// Clear bits to write
		reg_val |= Data & Mask;	// Set bits by mask
		si5338_write(InstancePtr, Addr, reg_val);
	}
	return XST_SUCCESS;
}

int si5338_delay(int delay_ms)
{
	volatile int i;
	for(i=0;i<(delay_ms*1000000);i++);
	return XST_SUCCESS;
}

int si5338_init(short DeviceID, char Bus, char ChipAddr)
{
	XIicPs_Config *Config;
	int Status, i;
	Reg_Data rd;
	u8 reg_val, test_addr, test_data;

	Config = XIicPs_LookupConfig(DeviceID);
	if (NULL == Config) {
		xil_printf("Si5338 XIicPs_LookupConfig failure\r\n");
		return XST_FAILURE;
	}

	Status = XIicPs_CfgInitialize(&Iic, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		xil_printf("Si5338 XIicPs_CfgInitialize failure\r\n");
		return XST_FAILURE;
	}
	XIicPs_SetSClk(&Iic, IIC_SCLK_RATE);
	// Check chip by reading Revision reg 0x00
	test_addr = 0x00;		// Address of test register
	Status = XIicPs_MasterSendPolled(&Iic, &test_addr, 1, IIC_ADDR);
	if (Status != XST_SUCCESS) {
		xil_printf("Si5338 XIicPs_MasterSendPolled failure\r\n");
		return XST_FAILURE;
	}
	Status = XIicPs_MasterRecvPolled(&Iic, &test_data, 1, IIC_ADDR);
	if (Status != XST_SUCCESS) {
		xil_printf("Si5338 XIicPs_MasterRecvPolled failure\r\n");
		return XST_FAILURE;
	}
	while (XIicPs_BusIsBusy(&Iic));	// Wait
	xil_printf("Si5338 Rev %d Initialization\t\t",test_data);

	// I2C Programming Procedure
	si5338_write(&Iic, 246, 0x01);					//Hard reset
	// Disable Outputs
	si5338_write_mask(&Iic, 230, EOB_ALL, EOB_ALL);	// EOB_ALL = 1
	// Pause LOL
	si5338_write_mask(&Iic, 241, DIS_LOL, DIS_LOL);	// DIS_LOL = 1
	// Write new configuration to device accounting for the write-allowed mask
	for(i=0; i<NUM_REGS_MAX; i++){
		rd = Reg_Store[i];
		si5338_write_mask(&Iic, rd.Reg_Addr, rd.Reg_Val, rd.Reg_Mask);
	}
	// Validate clock input status
	reg_val = si5338_read(&Iic, 218) & LOS_MASK;
	while(reg_val != 0){
		reg_val = si5338_read(&Iic, 218) & LOS_MASK;
	}
	// Configure PLL for locking
	si5338_write_mask(&Iic, 49, 0, FCAL_OVRD_EN);	//FCAL_OVRD_EN = 0
	// Initiate Locking of PLL
	si5338_write(&Iic, 246, SOFT_RESET);			//SOFT_RESET = 1
	si5338_delay(25);								// Wait 25 ms
	// Restart LOL
	si5338_write_mask(&Iic, 241, 0, DIS_LOL);		// DIS_LOL = 0
	si5338_write(&Iic, 241, 0x65);					// Set reg 241 = 0x65
	// Confirm PLL lock status
	reg_val = si5338_read(&Iic, 218) & LOCK_MASK;
	while(reg_val != 0){
		reg_val = si5338_read(&Iic, 218) & LOCK_MASK;
	}
	//copy FCAL values to active registers
	si5338_write_mask(&Iic, 47, si5338_read(&Iic, 237), 0x03);	// 237[1:0] to 47[1:0]
	si5338_write(&Iic, 46, si5338_read(&Iic, 236));	// 236[7:0] to 46[7:0]
	si5338_write(&Iic, 45, si5338_read(&Iic, 235));	// 235[7:0] to 45[7:0]
	si5338_write_mask(&Iic, 47, 0x14, 0xFC);		// Set 47[7:2] = 000101b
	// Set PLL to use FCAL values
	si5338_write_mask(&Iic, 49, FCAL_OVRD_EN, FCAL_OVRD_EN);	//FCAL_OVRD_EN = 1
	// Enable Outputs
	si5338_write(&Iic, 230, 0x00);					//EOB_ALL = 0
	xil_printf("Done\r\n");
	return XST_SUCCESS;
}

