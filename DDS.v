module DDS (
    input wire sys_clk,
    input wire rst_n,
    input wire [3:0] key,

    output wire dac_en,
    output wire dac_clk,
    output wire [7:0] dac_data
);

wire [3:0] wave_sel ;
assign dac_clk = ~sys_clk;
assign dac_en = 1'b1;

key_ctrl  key_ctrl_inst 
(
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .key(key),

    .wave_sel(wave_sel)

);


DDS_ctrl DDS_ctrl_inst(
    .sys_clk(sys_clk),
    .rst_n(rst_n),
    .wave_sel(wave_sel),

    .dac_data(dac_data)
);


    
endmodule