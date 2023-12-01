module top_wb_1(

input clk,
input rst,
input [7:0] addr,
input [31:0] data_in,
output [31:0] data_out,
output ack,
input cyc,
input we,
input str,

output [7:0] la_out_test,
output v_flag_io,
output state_flag_io,

output data_in_flag,
output data_out_flag,
output weight_flag_1,
output weight_flag_2,
output weight_flag_3,
output out_a_flag,
output out_b_flag
);


assign data_in_flag=(data_in_pl_buff!=0)?1'b1:1'b0;
assign data_out_flag=(data_out_pl_buff!=0)?1'b1:1'b0;
assign weight_flag_1=(wi_pl[31:0]!=0)?1'b1:1'b0;
assign weight_flag_2=(wi_pl[63:32]!=0)?1'b1:1'b0;
assign weight_flag_3=(wi_pl[71:64]!=0)?1'b1:1'b0;
assign out_a_flag=(outa_pl!=0)?1'b1:1'b0;
assign out_b_flag=(outb_pl!=0)?1'b1:1'b0;



wire [63:0] data_out_pl_buff; 
wire [63:0] data_in_pl_buff;
wire [71:0] wi_pl;
wire [15:0] outa_pl;
wire [15:0] outb_pl;

reg [31:0] data_out_reg;
reg [63:0] in_data;
reg [71:0] wi;
reg [2:0] addr_in;
reg we_in;
wire [15:0] outa;
wire [15:0] outb;

wire [2:0] addr_in_flag, addr_out_flag;
wire out_en_flag,in_en_flag;

wire v_io, state_io;




assign la_out_test={addr_in_flag,in_en_flag,addr_out_flag,out_en_flag};
assign v_flag_io=v_io;
assign state_flag_io=state_io;



assign data_out = data_out_reg;
assign ack=(cyc&&str&&we)?1'b1:1'b0;

top_one_engine te1(

.clk(clk),
.rst(rst),
.en(addr[7]),

.in_data(in_data),
.addr_in(addr_in),
.we_in(we_in),

.outa(outa),
.outb(outb),
.wi(wi),

.flag_v_int(v_io),
.state_flag(state_io),
.addr_in_flag(addr_in_flag), 
.addr_out_flag(addr_out_flag),
.we_in_flag(in_en_flag),
.out_en_flag(out_en_flag),

.wi_pl(wi_pl),
.data_out_buff_pl(data_out_pl_buff),
.data_in_buff_pl(data_in_pl_buff),
.outa_pl(outa_pl),
.outb_pl(outb_pl)
);



always @ (posedge clk, posedge rst)
begin
if(rst)
begin
in_data=0;
we_in=0;
addr_in=0;
end
else
begin
if(cyc && str && we && addr[7:4]==4'b1100)
begin
we_in=1;
addr_in=addr[2:0];
case(addr[3])
0:begin
in_data[31:0]=data_in;
end
1:begin
in_data[63:32]=data_in;
end
endcase
end
else
begin
we_in=0;
in_data=in_data;
addr_in=addr_in;
end
end
end




/////data for weights
always @ (posedge clk, posedge rst)
begin
if(rst)
begin
wi=0;
end
else
begin
if( cyc && str )
begin
if(we)
begin
if(addr[6:2]==5'b10100)
begin
case (addr[1:0])

2'b01:begin
wi[31:0]=data_in[31:0];
end

2'b10:begin
wi[63:32]=data_in[31:0];
end

2'b11:begin
wi[71:64]=data_in[31:24];
end

default:begin
wi=wi;
end

endcase
end

else
begin
wi=wi;
end
end
end
end
end



always @ (posedge clk, posedge rst)
begin
if(rst)
begin
data_out_reg=0;
end
else
begin
if(cyc && str && !we )
begin
case (addr)

8'b10000001:begin
data_out_reg=32'h414d5331;     //"AMS1"
end

8'b10000010:begin
data_out_reg=32'h43454149;  //"CEAI"
end

8'b10000011:begin
data_out_reg=32'h312e3030;  //"1.00"
end

8'b10100000:begin
data_out_reg={outb,outa};    //result output 
end

default: begin
data_out_reg=data_out_reg;   //retainment
end
endcase
end
else
begin
data_out_reg=0;
end
end
end


endmodule
