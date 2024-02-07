module led_test
(
	input          rst,
	input          clk,
	output reg     led
);
parameter LED_MAX = 32'd100_000_000;
reg[31:0] led_cnt;
always@(posedge clk or posedge rst)
begin
	if(rst == 1'b1)
	begin
		led_cnt <= 32'd0;
		led <= 1'b0;
	end
	else if(led_cnt >= LED_MAX - 32'd1)
	begin
		led_cnt <= 32'd0;
		led <= ~led;
	end	
	else
	begin
		led_cnt <= led_cnt + 32'd1;
	end		
end

endmodule 