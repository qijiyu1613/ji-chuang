/*VGA常见分辨率：
	Resolution_640x480
	Resolution_800x600
	Resolution_1024x768
	Resolution_1280x720
	Resolution_1920x1080
*/


`define MODE_RGB888
//`define MODE_RGB565

//以下7行预定义根据实际使用的分辨率，选择一个使能，另外6个使用注释的方式屏蔽

//`define Resolution_480x272 1	//时钟为9MHz
`define Resolution_640x480 1	//时钟为25.175MHz
//`define Resolution_800x480 1	//时钟为33MHz
//`define Resolution_800x600 1	//时钟为40MHz
//`define Resolution_1024x768 1	//时钟为65MHz
//`define Resolution_1280x720 1	//时钟为74.25MHz
//`define Resolution_1920x1080 1	//时钟为148.5MHz

//定义不同的颜色深度
`ifdef MODE_RGB888
	`define Red_Bits 8
	`define Green_Bits 8
	`define Blue_Bits 8
	
`elsif MODE_RGB565
	`define Red_Bits 5
	`define Green_Bits 6
	`define Blue_Bits 5
`endif

//定义不同分辨率的时序参数
`ifdef Resolution_480x272
	`define H_Total_Time  12'd525
	`define H_Right_Border  12'd0
	`define H_Front_Porch  12'd2
	`define H_Sync_Time  12'd41
	`define H_Back_Porch  12'd2
	`define H_Left_Border  12'd0

	`define V_Total_Time  12'd286
	`define V_Bottom_Border  12'd0
	`define V_Front_Porch  12'd2
	`define V_Sync_Time  12'd10
	`define V_Back_Porch  12'd2
	`define V_Top_Border  12'd0
	
`elsif Resolution_640x480
	`define H_Total_Time  12'd800
	`define H_Right_Border  12'd8
	`define H_Front_Porch  12'd8
	`define H_Sync_Time  12'd96
	`define H_Back_Porch  12'd40
	`define H_Left_Border  12'd8

	`define V_Total_Time  12'd525
	`define V_Bottom_Border  12'd8
	`define V_Front_Porch  12'd2
	`define V_Sync_Time  12'd2
	`define V_Back_Porch  12'd25
	`define V_Top_Border  12'd8

`elsif Resolution_800x480
	`define H_Total_Time 12'd1056
	`define H_Right_Border 12'd0
	`define H_Front_Porch 12'd40
	`define H_Sync_Time 12'd128
	`define H_Back_Porch 12'd88
	`define H_Left_Border 12'd0

	`define V_Total_Time 12'd525
	`define V_Bottom_Border 12'd8
	`define V_Front_Porch 12'd2
	`define V_Sync_Time 12'd2
	`define V_Back_Porch 12'd25
	`define V_Top_Border 12'd8

`elsif Resolution_800x600
	`define H_Total_Time 12'd1056
	`define H_Right_Border 12'd0
	`define H_Front_Porch 12'd40
	`define H_Sync_Time 12'd128
	`define H_Back_Porch 12'd88
	`define H_Left_Border 12'd0

	`define V_Total_Time 12'd628
	`define V_Bottom_Border 12'd0
	`define V_Front_Porch 12'd1
	`define V_Sync_Time 12'd4
	`define V_Back_Porch 12'd23
	`define V_Top_Border 12'd0

`elsif Resolution_1024x768
	`define H_Total_Time 12'd1344
	`define H_Right_Border 12'd0
	`define H_Front_Porch 12'd24
	`define H_Sync_Time 12'd136
	`define H_Back_Porch 12'd160
	`define H_Left_Border 12'd0

	`define V_Total_Time 12'd806
	`define V_Bottom_Border 12'd0
	`define V_Front_Porch 12'd3
	`define V_Sync_Time 12'd6
	`define V_Back_Porch 12'd29
	`define V_Top_Border 12'd0

`elsif Resolution_1280x720
	`define H_Total_Time 12'd1650
	`define H_Right_Border 12'd0
	`define H_Front_Porch 12'd110
	`define H_Sync_Time 12'd40
	`define H_Back_Porch 12'd220
	`define H_Left_Border 12'd0

	`define V_Total_Time 12'd750
	`define V_Bottom_Border 12'd0
	`define V_Front_Porch 12'd5
	`define V_Sync_Time 12'd5
	`define V_Back_Porch 12'd20
	`define V_Top_Border 12'd0
		
`elsif Resolution_1920x1080
	`define H_Total_Time 12'd2200
	`define H_Right_Border 12'd0
	`define H_Front_Porch 12'd88
	`define H_Sync_Time 12'd44
	`define H_Back_Porch 12'd148
	`define H_Left_Border 12'd0

	`define V_Total_Time 12'd1125
	`define V_Bottom_Border 12'd0
	`define V_Front_Porch 12'd4
	`define V_Sync_Time 12'd5
	`define V_Back_Porch 12'd36
	`define V_Top_Border 12'd0	
	
`endif

	

