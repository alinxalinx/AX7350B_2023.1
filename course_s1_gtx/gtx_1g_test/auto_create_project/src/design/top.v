`timescale 1ns / 1ps
module top 
(
    output[1:0]   tx_disable,        
	input         rst_n,
	input         sys_clk,
    output        fan_pwm,
	inout         si5338_scl, //i2c clock
    inout         si5338_sda, //i2c data
    output        si5338_i2c_lsb,
    input         Q2_CLK0_GTREFCLK_PAD_N_IN,
    input         Q2_CLK0_GTREFCLK_PAD_P_IN,    
    input [1:0]   RXN_IN,
    input [1:0]   RXP_IN,
    output[1:0]   TXN_OUT,
    output[1:0]   TXP_OUT
);

wire tx0_clk;
wire gt0_txfsmresetdone;
wire[31:0] tx0_data;
wire[3:0] tx0_kchar;
wire tx1_clk;
wire[31:0] tx1_data;
wire[3:0] tx1_kchar; 


wire rx0_clk;
wire[31:0] rx0_data;
wire[3:0] rx0_kchar;
wire rx1_clk;
wire[31:0] rx1_data;
wire[3:0] rx1_kchar; 



wire[31:0] data_tx;
wire[3:0] data_ctrl;
reg[7:0] cnt;
wire tx_packet_data_rd;
wire rx_clk;


assign tx_disable = 4'd0;
assign fan_pwm    = 1'b0;
assign si5338_i2c_lsb = 1'b0;

assign rx_clk = rx0_clk;
assign tx0_data = data_tx;
assign tx0_kchar = data_ctrl;
assign tx1_data = data_tx;
assign tx1_kchar = data_ctrl;
	
always @ (posedge tx0_clk)
begin
    if(tx_packet_data_rd)
        cnt <= cnt + 8'd1;
    else
        cnt <= 8'd0;
end



wire clk_100Mhz;
sys_clock sys_clock_m0
(
   .clk_in1(sys_clk),
   .clk_out1(clk_100Mhz),  
   .reset(1'b0), 
   .locked()  

);   

si5338#
(
	.kInitFileName                  ("si5338.mif"),
	.input_clk                      (100000000                 ),
	.i2c_address                    (7'b1110000               ),
	.bus_clk                        (400000                   )
)
si5338_inst(
	.clk                            (clk_100Mhz                  ),
	.reset                          (1'b0                 ),
	.done                           (                     ),
	.error                          (                         ),
	.SCL                            (si5338_scl               ),
	.SDA                            (si5338_sda               )
	);


wire gt0_txfsmresetdone_w;
proc_sys_reset_0 reset_m0 
(
   .slowest_sync_clk(tx0_clk),          // input wire slowest_sync_clk
   .ext_reset_in(gt0_txfsmresetdone),                  // input wire ext_reset_in
   .aux_reset_in(1'b0),                  // input wire aux_reset_in
   .mb_debug_sys_rst(1'b0),          // input wire mb_debug_sys_rst
   .dcm_locked(1'b1),                      // input wire dcm_locked
   .mb_reset(),                          // output wire mb_reset
   .bus_struct_reset(),          // output wire [0 : 0] bus_struct_reset
   .peripheral_reset(),          // output wire [0 : 0] peripheral_reset
   .interconnect_aresetn(),  // output wire [0 : 0] interconnect_aresetn
   .peripheral_aresetn(gt0_txfsmresetdone_w)      // output wire [0 : 0] peripheral_aresetn
 );
  
 
packet_send packet_send_m0(
    .rst(~gt0_txfsmresetdone_w),
    .tx_clk(tx0_clk),
    .tx_packet_req(1'b1),
    .tx_packet_len(256),
    .tx_packet_done(),
    .tx_packet_type(8),
    .tx_packet_data({cnt,cnt,cnt,cnt}),
    .tx_packet_data_rd(tx_packet_data_rd),
    
    .gt_tx_data(data_tx),
    .gt_tx_ctrl(data_ctrl)
);
wire[31:0] rx_data_align;
wire[3:0] rx_ctrl_align;
wire[31:0] error_packet_cnt_o;
wire[31:0] packet_cnt_o;
packet_rec packet_rec_m0(
    .rst(1'b0),
    .rx_clk(rx_clk), 
    .gt_rx_data(rx_data_align),
    .gt_rx_ctrl(rx_ctrl_align),
    .packet_cnt_o(packet_cnt_o),
    .error_packet_cnt_o(error_packet_cnt_o)
);
word_align word_align_m0(
    .rst(1'b0),
    .rx_clk(rx_clk),
    .gt_rx_data(rx0_data),
    .gt_rx_ctrl(rx0_kchar),
    .rx_data_align(rx_data_align),
    .rx_ctrl_align(rx_ctrl_align)
);
ila_0 u0(
    .clk(rx_clk),
    .probe0(rx_data_align),
    .probe1(rx_ctrl_align),
    .probe2(rx0_data),
    .probe3(rx0_kchar),
    .probe4(packet_cnt_o),
    .probe5(error_packet_cnt_o)
);
gtx_exdes gtx_exdes_m0
    (
	
    .tx0_clk(tx0_clk),
    .gt0_txfsmresetdone(gt0_txfsmresetdone),
    .tx0_data(tx0_data),
    .tx0_kchar(tx0_kchar),   
    .rx0_clk(rx0_clk),
    .rx0_data(rx0_data),
    .rx0_kchar(rx0_kchar),

    .gt1_txfsmresetdone(),
    .tx1_data(tx1_data),
    .tx1_kchar(tx1_kchar),   
    .rx1_clk(rx1_clk),
    .rx1_data(rx1_data),
    .rx1_kchar(rx1_kchar),
    
                        
    .Q2_CLK0_GTREFCLK_PAD_N_IN(Q2_CLK0_GTREFCLK_PAD_N_IN),
    .Q2_CLK0_GTREFCLK_PAD_P_IN(Q2_CLK0_GTREFCLK_PAD_P_IN),
	.drp_clk(clk_100Mhz),
    .RXN_IN(RXN_IN),
    .RXP_IN(RXP_IN),
    .TXN_OUT(TXN_OUT),
    .TXP_OUT(TXP_OUT)
);
    
    
    
endmodule