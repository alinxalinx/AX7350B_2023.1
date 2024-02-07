/*
-- Company: 		Trenz Electronic
-- Engineer: 		Oleksandr Kiyenko
 */

#ifndef SI5338_H_
#define SI5338_H_

#include "xiicps.h"

#define IIC_SCLK_RATE			400000
#define IIC_ADDR				0x70
#define IIC_BUS					0

#define LOS_MASK_IN1IN2IN3		0x04
#define LOS_MASK				LOS_MASK_IN1IN2IN3
#define PLL_LOL					0x10
#define LOS_FDBK				0x08
#define LOS_CLKIN				0x04
#define SYS_CAL					0x01
#define LOCK_MASK				(PLL_LOL | LOS_CLKIN | SYS_CAL)
#define FCAL_OVRD_EN			0x80
#define SOFT_RESET				0x02
#define EOB_ALL					0x10
#define DIS_LOL					0x80
extern XIicPs Iic;		/**< Instance of the IIC Device */
int si5338_init(short DeviceID, char Bus, char ChipAddr);

#endif /* SI5338_H_ */
