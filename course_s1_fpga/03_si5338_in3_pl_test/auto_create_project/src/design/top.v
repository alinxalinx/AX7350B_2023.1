//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//  Author: meisq                                                               //
//          msq@qq.com                                                          //
//          ALINX(shanghai) Technology Co.,Ltd                                  //
//          heijin                                                              //
//     WEB: http://www.alinx.cn/                                                //
//     BBS: http://www.heijin.org/                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
// Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
//                    All rights reserved                                       //
//                                                                              //
// This source file may be used and distributed without restriction provided    //
// that this copyright statement is not removed from the file and that any      //
// derivative work contains the original copyright notice and the associated    //
// disclaimer.                                                                  //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////

//================================================================================
//  Revision History:
//  Date          By            Revision    Change Description
//--------------------------------------------------------------------------------
//  2017/9/1      meisq          1.0         Original
//*******************************************************************************/
 
module top(
	input                       sys_clk,
	input                       rst_n,
	//si5338
	input                       clk0_p,
	input                       clk0_n,
	input                       clk1_p,
	input                       clk1_n,
	input                       clk2_p,
	input                       clk2_n,

	inout                       si5338_scl,          //i2c clock
	inout                       si5338_sda,          //i2c data
	output                      si5338_i2c_lsb,
	//led
	output[3:0]                 led
	
);
wire sys_clk;
wire clk0;
wire clk1;
wire clk2;
assign led[3] = 1'b1;
assign si5338_i2c_lsb = 1'b0;
IBUFDS clk0_ibufgds
(
	.O  (clk0),
    .I  (clk0_p),
    .IB (clk0_n)
);

IBUFDS_GTE2 IBUFDS_GTE2_m0
(
	.O            (clk1),
	.ODIV2        (),
	.CEB          (1'b0),
	.I            (clk1_p),
	.IB           (clk1_n)
);
IBUFDS_GTE2 IBUFDS_GTE2_m1
(
	.O            (clk2),
	.ODIV2        (),
	.CEB          (1'b0),
	.I            (clk2_p),
	.IB           (clk2_n)
);

  

led_test#(.LED_MAX(200000000))led_test_m0
(
	.rst(~rst_n),
	.clk(clk0),
	.led(led[0])
);

led_test#(.LED_MAX(100000000))led_test_m1
(
	.rst(~rst_n),
	.clk(clk1),
	.led(led[1])
);

led_test#(.LED_MAX(156250000))led_test_m2
(
	.rst(~rst_n),
	.clk(clk2),
	.led(led[2])
);

si5338# 
(
	.kInitFileName              ("si5338.mif"           ),
	.input_clk                  (50000000                 ),
	.i2c_address		        (7'b1110000               ), 
	.bus_clk   		            (400000                   )
)
si5338_inst(
	.clk     		            (sys_clk                  ),
	.reset			            (1'b0                     ),
	.done			            (                         ),
	.error			            (                         ),
	.SCL 			            (si5338_scl               ),
	.SDA 			            (si5338_sda               )
	);

endmodule