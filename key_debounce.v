module key_debounce
#(
    parameter cnt_MAX = 20'd999999  //20ms
)
 (
    input wire clk_50,
    input wire rst_n,
    input wire key_in,

    output reg key_flag
);
    reg [19:0] cnt_20ms;
 

//目的是计数器检测到低电平就计数，高电平就清零
always @(posedge clk_50 or negedge rst_n) begin
    if (!rst_n) begin
        cnt_20ms <= 1'd0;
    end else if (key_in == 1'b1) begin
        cnt_20ms <=1'b0;
    end else if (cnt_20ms == cnt_MAX) begin
        cnt_20ms <= cnt_MAX;
    end else 
        cnt_20ms <= cnt_20ms +1'b1;
end

//key_flag
always @(posedge clk_50 or negedge rst_n) begin
    if (!rst_n) begin
        key_flag <= 1'b0;
    end else if (cnt_20ms == cnt_MAX-1'b1) begin
        key_flag <= 1'b1;
    end else 
        key_flag <= 1'b0;
end

//后续操作就是根据key_flag 的状态才进行

    
endmodule 
