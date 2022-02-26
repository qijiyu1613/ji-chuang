module adc0809 ( 
input             clk       ,                   //系统时钟
input    [7:0]    D         ,                   //ADC0809传进来的数据
input             EOC       ,                   //ADC0809转换完成信号标志
input             rst_n     ,                   //系统 复位
    
output  reg   [19:0]    data      ,             //FPGA给数码管的数据
output  reg             OE        ,             //FPGA给ADC0809的使能信号
output  reg             start     ,             //ADC0809 转换开始信号
output  reg             ad_clk                  //ADC0809时钟信号

);                              

parameter   IDLE = 3'b000;                      //6个状态
parameter   st1  = 3'b001;
parameter   st2  = 3'b010;
parameter   st3  = 3'b011;
parameter   st4  = 3'b100;
parameter   st5  = 3'b101;
                          
reg     [7:0]       count     ;    
reg     [2:0]       state     ;
reg     [2:0]       n_state   ;

always @(posedge clk or negedge rst_n)          //50MHz时钟分频为750kHz输出
begin
    if(!rst_n) 
    begin
        state <= IDLE;      
        count <= 8'b0;
        ad_clk <= 1'b0;
    end
    else    
    begin 
        count <= count + 1'b1;
        if (count >= 8'b0100_0010) 
        begin 
            count <= 8'b0;
            ad_clk <= ~ad_clk;                  //AD芯片时钟信号
            state <= n_state;                   //进入下一个状态
        end
        
    end
end   


always @(posedge clk or negedge rst_n)
begin
    case(state)
    IDLE    :   begin                           //初始状态
                start <= 1'b0;
                OE <= 1'b0;
                n_state <= st1;
                end
    st1     :   begin                           //ST、ALE信号置高电平
                start <= 1'b1;
                OE <= 1'b0;
                n_state <= st2;
                end      
    st2     :   begin
                start <= 1'b0;
                OE <= 1'b0;
                if(EOC)
                    n_state <= st2;             //若EOC为低电平，进入下个状态
                else
                    n_state <= st3;
                end       
    st3     :   begin
                start <= 1'b0;
                OE <= 1'b0;
                if(!EOC)                        //等待EOC变为高电平，即AD转换结束
                    n_state <= st3;
                else
                    n_state <= st4;
                end       
    st4     :   begin
                start <= 1'b0;
                OE <= 1'b1;                     //OE置为高电平，准备接收数据
                n_state <= st5;
                end       
    st5     :   begin
                start <= 1'b0;
                OE <= 1'b1;
                data <= D*500/255;              //接收转换的数据并处理输出给seg模块
                n_state <= IDLE;
                end       
    default :   begin
                start <= 1'b0;
                OE <= 1'b0;
                n_state <= IDLE;
                end       
    endcase
end

  
endmodule
       
