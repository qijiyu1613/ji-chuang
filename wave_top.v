module wave_top (
    input wire sys_clk,
    input wire rst_n,
    input wire [3:0] key,
    input wire  EOC,
    input wire dac_en,
    output [7:0] data,
	output [23:0]VGA_RGB, 
    output VGA_HS,
	output VGA_VS,
	output VGA_BLK,		//VGA 场消隐信号
	output VGA_CLK,		//VGA DAC输出时钟          
    output OE, 
    output start,
    output ad_clk 
);
    wire dac_clk ;
    wire [7:0] dac_data ;
    wire ClkDisp;

assign dac_clk = ~sys_clk;



 DDS  DDS_inst(
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .key(key),

    .dac_en(dac_en),
    .dac_clk(dac_clk),
    .dac_data(dac_data)
);

VGA_CTRL_test VGA_CTRL_test_inst(
	.Clk(sys_clk), 	//50MHZ时钟
	.Rst_n(rst_n),
	.VGA_RGB(VGA_RGB),//TFT数据输出
	.VGA_HS(VGA_HS),	//TFT行同步信号
	.VGA_VS(VGA_HS),	//TFT场同步信号
	.VGA_BLK(VGA_BLK),		//VGA 场消隐信号
	.VGA_CLK(ClkDisp)		//VGA DAC输出时钟
);

vga_test_pll vga_test_pll(
		.inclk0(sys_clk),
		.c0(ClkDisp)
	);


adc0809 adc0809_inst ( 
    .clk(sys_clk)     ,                   //系统时钟
    .D(dac_data)         ,                   //ADC0809传进来的数据
    .EOC(EOC)       ,                   //ADC0809转换完成信号标志
    .rst_n(rst_n)     ,                   //系统 复位   
    .data(data)      ,             
    .OE(OE)        ,             //FPGA给ADC0809的使能信号
    .start(start)     ,             //ADC0809 转换开始信号
    .ad_clk(ad_clk)                  //ADC0809时钟信号

);        

endmodule