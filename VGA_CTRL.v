module VGA_CTRL(
	Clk25M,	//系统输入时钟25MHZ
	Rst_n,	//复位输入，低电平复位
	data_in,	//待显示数据
	hcount,		//VGA行扫描计数器
	vcount,		//VGA场扫描计数器
	VGA_RGB,	//VGA数据输出
	VGA_HS,		//VGA行同步信号
	VGA_VS,		//VGA场同步信号
	VGA_BLK,		//VGA 场消隐信号
	VGA_CLK		//VGA DAC输出时钟
);
			
	//----------------模块输入端口----------------
	input  Clk25M;          //系统输入时钟25MHZ
	input  Rst_n;
	input  [23:0]data_in;     //待显示数据

	//----------------模块输出端口----------------
	output [9:0]hcount;
	output [9:0]vcount;
	output [23:0]VGA_RGB;  //VGA数据输出
	output VGA_HS;           //VGA行同步信号
	output VGA_VS;           //VGA场同步信号
	output VGA_BLK;		//VGA 场消隐信号
	output VGA_CLK;		//VGA DAC输出时钟
	
	//将VGA控制器时钟信号取反输出，作为DAC数据锁存信号
	assign VGA_CLK = ~Clk25M;

	//----------------内部寄存器定义----------------
	reg [9:0] hcount_r;     //VGA行扫描计数器
	reg [9:0] vcount_r;     //VGA场扫描计数器
	//----------------内部连线定义----------------
	wire hcount_ov;
	wire vcount_ov;
	wire dat_act;//有效显示区标定

	//VGA行、场扫描时序参数表
	parameter VGA_HS_end=10'd95,
				 hdat_begin=10'd143,
				 hdat_end=10'd783,
				 hpixel_end=10'd799,
				 VGA_VS_end=10'd1,
				 vdat_begin=10'd34,
				 vdat_end=10'd514,
				 vline_end=10'd524;

	assign hcount=dat_act?(hcount_r-hdat_begin):10'd0;
	assign vcount=dat_act?(vcount_r-vdat_begin):10'd0;

	//行扫描
	always@(posedge Clk25M or negedge Rst_n)
	if(!Rst_n)
		hcount_r<=10'd0;
	else if(hcount_ov)
		hcount_r<=10'd0;
	else
		hcount_r<=hcount_r+10'd1;

	assign hcount_ov=(hcount_r==hpixel_end);

	//场扫描
	always@(posedge Clk25M or negedge Rst_n)
	if(!Rst_n)
		vcount_r<=10'd0;
	else if(hcount_ov) begin
		if(vcount_ov)
			vcount_r<=10'd0;
		else
			vcount_r<=vcount_r+10'd1;
	end
	else 
		vcount_r<=vcount_r;
		
	assign 	vcount_ov=(vcount_r==vline_end);

	//数据、同步信号输出
	assign dat_act=((hcount_r>=hdat_begin)&&(hcount_r<hdat_end))
					&&((vcount_r>=vdat_begin)&&(vcount_r<vdat_end));
					
	assign VGA_BLK = dat_act;
					
	assign VGA_HS=(hcount_r>VGA_HS_end);
	assign VGA_VS=(vcount_r>VGA_VS_end);
	assign VGA_RGB=(dat_act)?data_in:24'h000000;
		
endmodule 
