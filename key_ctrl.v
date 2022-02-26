module key_ctrl (
    input wire sys_clk,
    input wire rst_n,
    input wire [3:0] key ,

    output reg [3:0] wave_sel

);
    wire key3;
    wire key2;
    wire key1;
    wire key0;

parameter sin_wave = 4'b0001, //正弦波
          saw_wave = 4'b0010, //锯齿波
          tri_wave = 4'b0100, //三角波
          squ_wave = 4'b1000; //方波

parameter CNT_MAX = 20'd999999 ;

always @(posedge sys_clk or negedge rst_n) begin
    if(!rst_n) begin
        wave_sel <= 4'b0000;
    end else if (key0 == 1'b1) begin
        wave_sel <= sin_wave;
    end else if (key1 == 1'b1) begin
        wave_sel <= tri_wave;
    end else if (key2 == 1'b1) begin
        wave_sel <= saw_wave; 
    end else if (key3 == 1'b1) begin
        wave_sel <= squ_wave;
    end else begin
        wave_sel <= wave_sel;
    end
        
end

//消抖模块例化 暂且定为4个波形
 key_debounce
 #(
     .cnt_MAX  (20'd999999)  //20ms
 )
  key_debounce_inst3(
     .clk_50(sys_clk),
     .rst_n(rst_n),
     .key_in(key[3]),

     .key_flag(key3)
 );

key_debounce
#(
    .cnt_MAX  (CNT_MAX)  //20ms
)
 key_debounce_inst2(
    .clk_50(sys_clk),
    .rst_n(rst_n),
    .key_in(key[2]),

    .key_flag(key2)
);

key_debounce
#(
    .cnt_MAX  (CNT_MAX)  //20ms
)
 key_debounce_inst1(
    .clk_50(sys_clk),
    .rst_n(rst_n),
    .key_in(key[1]),

    .key_flag(key1)
);

key_debounce
#(
    .cnt_MAX  (CNT_MAX)  //20ms
)
 key_debounce_inst0(
    .clk_50(sys_clk),
    .rst_n(rst_n),
    .key_in(key[0]),

    .key_flag(key0)
);



endmodule