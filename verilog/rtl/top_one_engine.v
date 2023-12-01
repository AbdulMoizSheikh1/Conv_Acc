module top_one_engine(

input clk,
input rst,
input en,

input [63:0] in_data,
input [2:0] addr_in,
input we_in,

output [15:0] outa,
output [15:0] outb,
input [71:0] wi,

output wire flag_v_int,
output wire state_flag,
output wire [2:0] addr_in_flag, 
output wire [2:0] addr_out_flag,
output wire we_in_flag,
output wire out_en_flag,

output [71:0] wi_pl,
output [63:0] data_out_buff_pl,
output [63:0] data_in_buff_pl,
output [15:0] outa_pl,
output [15:0] outb_pl

);


wire [63:0] out_data_inter;
wire [1:0] state_inter;
wire v_flag_inter;

wire [71:0] wi_interm;
wire [63:0] in_data_interm;


assign wi_interm=wi;
assign wi_pl=wi_interm;

assign in_data_interm=in_data;
assign data_in_buff_pl=in_data_interm;

assign data_out_buff_pl=out_data_inter;
assign outa_pl=outa;
assign outb_pl=outb;

assign flag_v_int=v_flag_inter;
assign state_flag=(state_inter==2'b11)?1'b1:1'b0;






controller_buff_top con1
(
.clk(clk),
.rst(rst),
.en(en),
.in_data(in_data),
.out_data(out_data_inter),
.state(state_inter),
.v_flag(v_flag_inter),
.addr_in(addr_in),
.we_in(we_in),
.addr_in_flag(addr_in_flag),
.addr_out_flag(addr_out_flag),
.we_in_flag(we_in_flag),
.out_en_flag(out_en_flag)
);



engine_3x3_2_2 a1
(
.clk(clk),
.rst(rst),
.en(en),
.fin(out_data_inter),
.outa(outa),
.outb(outb),
.wi(wi),
.control(state_inter),
.v_flag(v_flag_inter)
);



endmodule
