/* Verilog for cell '0_LC4_sim{sch}' from library 'LC4-v3' */
/* Created on Fri Feb 20, 2015 00:47:04 */
/* Last revised on Thu Apr 23, 2015 14:46:45 */
/* Written on Tue Apr 28, 2015 12:42:38 by Electric VLSI Design System, version 8.10 */

module LC4_v3__logic_1(out);
  output out;

  /* user-specified Verilog code */
  /**/ reg out;
  /**/ initial begin
  /**/    out = 1;
  /**/ end

endmodule   /* LC4_v3__logic_1 */

module LC4_v3__mux16_4x1(in00, in01, in10, in11, sel, out);
  input [15:0] in00;
  input [15:0] in01;
  input [15:0] in10;
  input [15:0] in11;
  input [1:0] sel;
  output [15:0] out;

  wire net_13;

  /* user-specified Verilog code */
  /*-------------
  * mux16_4x1
  *     16-bit, 4 input, 1 output MUX.
  *--------------*/
  /**/ reg [15:0] out;
  /**/ always @(sel or in00 or in01 or in10 or in11) begin
  /**/    #1 case (sel)
  /**/        2'b00: out = in00;
  /**/        2'b01: out = in01;
  /**/        2'b10: out = in10;
  /**/        2'b11: out = in11;
  /**/        default: out = in00;
  /**/    endcase
  /**/ end
  /**/ initial begin
  /**/    out = in00;
  /**/ end

endmodule   /* LC4_v3__mux16_4x1 */

module LC4_v3__add16(A, B, out);
  input [15:0] A;
  input [15:0] B;
  output [15:0] out;

  /* user-specified Verilog code */
  /*--------------
  * add16
  *    adds two 16-bit inputs
  *---------------*/
  /**/ reg [15:0] out;
  /**/
  /**/ always @(A or B) begin
  /**/    #1 out = A + B;
  /**/ end
  /**/
  /**/ initial begin
  /**/    out = 16'h0000;
  /**/ end

endmodule   /* LC4_v3__add16 */

module LC4_v3__and16(A, B, out);
  input [15:0] A;
  input [15:0] B;
  output [15:0] out;

  /* user-specified Verilog code */
  /*--------------
  * and16
  *    bitwise ANDs 2 16-bit inputs.
  *---------------*/
  /**/ reg [15:0] out;
  /**/ always @(A or B) begin
  /**/     #1 out = A & B;
  /**/ end

endmodule   /* LC4_v3__and16 */

module LC4_v3__const16_1(out);
  output [15:0] out;

  /* user-specified Verilog code */
  /**/ reg [15:0] out;
  /**/ initial begin
  /**/     out = 16'd1;
  /**/ end

endmodule   /* LC4_v3__const16_1 */

module LC4_v3__increment16(in, out);
  input [15:0] in;
  output [15:0] out;

  /* user-specified Verilog code */
  /*---------------
  *  add 1 to input,
  * 16-bit, unsigned arithmetic.
  *---------------
  /**/ reg[15:0] out;
  /**/ always @(in) begin
  /**/     #1 out = (in+1)%(1<<16);
  /**/ end

endmodule   /* LC4_v3__increment16 */

module LC4_v3__mux16_2x1(in0, in1, sel, out);
  input [15:0] in0;
  input [15:0] in1;
  input sel;
  output [15:0] out;

  /* user-specified Verilog code */
  /*-------------
  * mux16_2x1
  *     16-bit, 2 input, 1 output MUX.
  *--------------*/
  /**/ reg [15:0] out;
  /**/ always @(sel or in0 or in1) begin
  /**/    #1 case (sel)
  /**/        1'b0: out = in0;
  /**/        1'b1: out = in1;
  /**/        default: out = in0;
  /**/    endcase
  /**/ end
  /**/ initial begin
  /**/    out = in0;
  /**/ end

endmodule   /* LC4_v3__mux16_2x1 */

module LC4_v3__not16(in, out);
  input [15:0] in;
  output [15:0] out;

  /* user-specified Verilog code */
  /*--------------
  * not16
  *    bitwise NOTs 1 16-bit input.
  *---------------*/
  /**/ reg [15:0] out;
  /**/ always @(in) begin
  /**/    #1 out = ~in;
  /**/ end

endmodule   /* LC4_v3__not16 */

module LC4_v3__ALU(A, B, func, out);
  input [15:0] A;
  input [15:0] B;
  input [2:0] func;
  output [15:0] out;

  wire [15:0] ANDout;
  wire [15:0] add;
  wire [15:0] addB;
  wire [15:0] andA;
  wire [15:0] andB;
  wire [15:0] nS1;
  wire [15:0] nS2;
  wire [15:0] net_104;
  wire [15:0] net_108;
  wire [15:0] net_110;
  wire [15:0] net_111;
  wire [15:0] net_67;
  wire [15:0] net_69;
  wire [15:0] net_88;
  wire [15:0] net_96;
  wire [15:0] net_97;

  LC4_v3__mux16_4x1 MUX16_4x_0(.in00(add[15:0]), .in01(net_67[15:0]), 
      .in10(net_88[15:0]), .in11(net_110[15:0]), .sel(func[1:0]), 
      .out(out[15:0]));
  LC4_v3__add16 add16_0(.A(A[15:0]), .B(addB[15:0]), .out(add[15:0]));
  LC4_v3__add16 add16_1(.A(A[15:0]), .B(net_108[15:0]), .out(net_110[15:0]));
  LC4_v3__and16 and16_0(.A(andA[15:0]), .B(andB[15:0]), .out(ANDout[15:0]));
  LC4_v3__const16_1 const16__0(.out(net_104[15:0]));
  LC4_v3__increment16 incremen_0(.in(net_96[15:0]), .out(net_97[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_0(.in0(B[15:0]), .in1(net_111[15:0]), 
      .sel(func[2]), .out(addB[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_1(.in0(ANDout[15:0]), .in1(net_69[15:0]), 
      .sel(func[2]), .out(net_67[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_2(.in0(B[15:0]), .in1(nS2[15:0]), .sel(func[2]), 
      .out(andB[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_3(.in0(A[15:0]), .in1(nS1[15:0]), .sel(func[2]), 
      .out(andA[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_4(.in0(nS1[15:0]), .in1(ANDout[15:0]), 
      .sel(func[2]), .out(net_88[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_5(.in0(net_104[15:0]), .in1(net_97[15:0]), 
      .sel(func[2]), .out(net_108[15:0]));
  LC4_v3__not16 not16_0(.in(net_104[15:0]), .out(net_96[15:0]));
  LC4_v3__not16 not16_3(.in(ANDout[15:0]), .out(net_69[15:0]));
  LC4_v3__not16 not16_4(.in(A[15:0]), .out(nS1[15:0]));
  LC4_v3__not16 not16_5(.in(B[15:0]), .out(nS2[15:0]));
  LC4_v3__increment16 plus1_0(.in(nS2[15:0]), .out(net_111[15:0]));
endmodule   /* LC4_v3__ALU */

module LC4_v3__ALUInputMux(DR, IRInput, Rwe, SR, ALUMuxSel);
  input [2:0] DR;
  input [3:0] IRInput;
  input Rwe;
  input [2:0] SR;
  output ALUMuxSel;

  /* user-specified Verilog code */
  reg out;
  assign ALUMuxSel=out;
  always @(IRInput[3:0], DR[2:0], SR[2:0], Rwe)
  begin
      if((IRInput[3:0]==4'b0101 || IRInput[3:0]==4'b0000) && (DR==SR) && (Rwe==1))
  	out=1;
      else
  	out=0;
  end

endmodule   /* LC4_v3__ALUInputMux */

module LC4_v3__clk(out);
  output out;

  /* user-specified Verilog code */
  /*-------------
  * clk
  *     50% duty cycle
  *  clock generator.
  *--------------*/
  /**/      reg out;
  /**/      initial begin
  /**/          out = 1;
  /**/      end
  /**/      always begin
  /**/         #1000 out = 0;
  /**/         #1000 out = 1;
  /**/      end

endmodule   /* LC4_v3__clk */

module LC4_v3__buff16(in, out);
  input [15:0] in;
  output [15:0] out;

  wire buf_0_c, buf_10_c, buf_11_c, buf_12_c, buf_13_c, buf_14_c, buf_15_c;
  wire buf_1_c, buf_2_c, buf_3_c, buf_4_c, buf_5_c, buf_6_c, buf_7_c, buf_8_c;
  wire buf_9_c;

  buf buf_0(out[0], in[0]);
  buf buf_1(out[1], in[1]);
  buf buf_2(out[2], in[2]);
  buf buf_3(out[3], in[3]);
  buf buf_4(out[4], in[4]);
  buf buf_5(out[5], in[5]);
  buf buf_6(out[6], in[6]);
  buf buf_7(out[7], in[7]);
  buf buf_8(out[8], in[8]);
  buf buf_9(out[9], in[9]);
  buf buf_10(out[10], in[10]);
  buf buf_11(out[11], in[11]);
  buf buf_12(out[12], in[12]);
  buf buf_13(out[13], in[13]);
  buf buf_14(out[14], in[14]);
  buf buf_15(out[15], in[15]);
endmodule   /* LC4_v3__buff16 */

module LC4_v3__D_memory(RW, addr, clk, in, out, MMUinterface);
  input RW;
  input [15:0] addr;
  input clk;
  input [15:0] in;
  output [15:0] out;
  inout [50:0] MMUinterface;

  wire D_RW_out, D_Ready, D_Request_out, buf_0_c, buf_4_c, buf_5_c;
  wire [15:0] D_addr_out;
  wire [15:0] D_data_read;
  wire [15:0] D_data_write;

  /* user-specified Verilog code */
  //--------------------------
  //-- D_MEM read.
  //--------------------------
  /**/ always @( posedge clk ) begin
  /**/    #100
  /**/     if (RW == 0 ) begin
  /**/         #10
  /**/         D_Request = 1;
  /**/         @( posedge  D_Ready );
  /**/        out <= #5 D_data_read;
  /**/         #10
  /**/         D_Request = 0;
  /**/     end 
  /**/ end
  /*------------------------
  * data cache
  * 16-bit word, 16-bit address,
  *  word-addressable, RW memory.
  * The cache is faked: accesses go 
  * directly to the MMU.
  *-------------------------*/
  /**/ reg D_Request;
  /**/ reg [15:0] out;
  /**/ assign D_Request_out = D_Request;
  /**/ assign D_addr_out        = addr;
  /**/ assign D_RW_out          = RW;
  /**/ assign D_data_write     = in;
  //--------------------------
  //-- D_MEM write.
  //--------------------------
  /**/ always @( posedge clk ) begin
  /**/     #100
  /**/     if ( RW == 1 ) begin
  /**/         #10
  /**/         D_Request = 1;
  /**/         @( posedge  D_Ready );
  /**/         #10
  /**/         D_Request = 0;
  /**/     end
  /**/ end

  buf buf_0(MMUinterface[49], D_RW_out);
  buf buf_4(D_Ready, MMUinterface[0]);
  buf buf_5(MMUinterface[50], D_Request_out);
  LC4_v3__buff16 buff16_0(.in(D_addr_out[15:0]), .out(MMUinterface[48:33]));
  LC4_v3__buff16 buff16_1(.in(D_data_write[15:0]), .out(MMUinterface[32:17]));
  LC4_v3__buff16 buff16_2(.in(MMUinterface[16:1]), .out(D_data_read[15:0]));
endmodule   /* LC4_v3__D_memory */

module LC4_v3__logic_0(out);
  output out;

  /* user-specified Verilog code */
  /**/ reg out;
  /**/ initial begin
  /**/    out = 0;
  /**/ end

endmodule   /* LC4_v3__logic_0 */

module LC4_v3__mux1_2X1(X0, X1, sel, out);
  input X0;
  input X1;
  input sel;
  output out;

  wire and_0_yc, and_0_yt, and_1_yc, and_1_yt, buf_0_c, net_0, net_3, net_7;
  wire or_0_yc, or_0_yt;

  and and_0(net_3, net_7, X0);
  and and_1(net_0, sel, X1);
  not buf_0(net_7, sel);
  or or_0(out, net_0, net_3);
endmodule   /* LC4_v3__mux1_2X1 */

module LC4_v3__mux1_4X1(X00, X01, X10, X11, sel, out);
  input X00;
  input X01;
  input X10;
  input X11;
  input [1:0] sel;
  output out;

  wire net_0, net_3;

  LC4_v3__mux1_2X1 MUX1_2X1_0(.X0(X00), .X1(X01), .sel(sel[0]), .out(net_0));
  LC4_v3__mux1_2X1 MUX1_2X1_1(.X0(X10), .X1(X11), .sel(sel[0]), .out(net_3));
  LC4_v3__mux1_2X1 MUX1_2X1_2(.X0(net_0), .X1(net_3), .sel(sel[1]), 
      .out(out));
endmodule   /* LC4_v3__mux1_4X1 */

module LC4_v3__mux1_16X1(X0000, X0001, X0010, X0011, X0100, X0101, X0110, 
      X0111, X1000, X1001, X1010, X1011, X1100, X1101, X1110, X1111, sel, 
      out);
  input X0000;
  input X0001;
  input X0010;
  input X0011;
  input X0100;
  input X0101;
  input X0110;
  input X0111;
  input X1000;
  input X1001;
  input X1010;
  input X1011;
  input X1100;
  input X1101;
  input X1110;
  input X1111;
  input [3:0] sel;
  output out;

  wire net_44, net_48, net_52, net_56;

  LC4_v3__mux1_4X1 MUX1_4X1_4(.X00(X0000), .X01(X0001), .X10(X0010), 
      .X11(X0011), .sel(sel[1:0]), .out(net_44));
  LC4_v3__mux1_4X1 MUX1_4X1_6(.X00(X1000), .X01(X1001), .X10(X1010), 
      .X11(X1011), .sel(sel[1:0]), .out(net_52));
  LC4_v3__mux1_4X1 MUX1_4X1_7(.X00(X0100), .X01(X0101), .X10(X0110), 
      .X11(X0111), .sel(sel[1:0]), .out(net_48));
  LC4_v3__mux1_4X1 MUX1_4X1_8(.X00(X1100), .X01(X1101), .X10(X1110), 
      .X11(X1111), .sel(sel[1:0]), .out(net_56));
  LC4_v3__mux1_4X1 MUX1_4X1_11(.X00(net_44), .X01(net_48), .X10(net_52), 
      .X11(net_56), .sel(sel[3:2]), .out(out));
endmodule   /* LC4_v3__mux1_16X1 */

module LC4_v3__opL();
endmodule   /* LC4_v3__opL */

module LC4_v3__Decode(opcode, BR, DRmux, ILL, INmux, Mwe, Rwe, SYS);
  input [3:0] opcode;
  output BR;
  output DRmux;
  output ILL;
  output [1:0] INmux;
  output Mwe;
  output Rwe;
  output SYS;

  wire and_10_yc, and_10_yt, and_11_yc, and_11_yt, and_8_yc, and_8_yt, and_9_yc;
  wire and_9_yt, buf_1_c, buf_2_c, buf_5_c, buf_6_c, buf_7_c, net_1065;
  wire net_1067, net_1072, net_1074, net_1096, net_1097, net_1100, net_1102;
  wire net_1182, net_1186, net_1188, net_1193, net_1198, net_1210, net_1224;
  wire net_1228, net_364;

  /* user-specified Verilog code */
  
  
  

  and and_8(BR, net_1186, net_1198);
  and and_9(net_1186, opcode[2], net_1182, opcode[0]);
  and and_10(SYS, net_1210, net_1224);
  and and_11(net_1210, net_1228, opcode[1], opcode[2]);
  not buf_1(net_1198, opcode[3]);
  not buf_2(net_1182, opcode[1]);
  not buf_5(net_1224, opcode[0]);
  not buf_6(net_1228, opcode[3]);
  buf buf_7(ILL, opcode[3]);
  LC4_v3__logic_0 _0v_150(.out(net_364));
  LC4_v3__logic_1 _1v_27(.out(net_1067));
  LC4_v3__logic_1 _1v_33(.out(net_1074));
  LC4_v3__mux1_16X1 DRmux_(.X0000(net_1067), .X0001(net_364), .X0010(net_364), 
      .X0011(net_364), .X0100(net_364), .X0101(net_364), .X0110(net_364), 
      .X0111(net_364), .X1000(net_364), .X1001(net_364), .X1010(net_364), 
      .X1011(net_364), .X1100(net_364), .X1101(net_364), .X1110(net_364), 
      .X1111(net_364), .sel(opcode[3:0]), .out(DRmux));
  LC4_v3__mux1_16X1 INmux0(.X0000(net_364), .X0001(net_1097), .X0010(net_1100), 
      .X0011(net_364), .X0100(net_364), .X0101(net_364), .X0110(net_364), 
      .X0111(net_364), .X1000(net_364), .X1001(net_364), .X1010(net_364), 
      .X1011(net_364), .X1100(net_364), .X1101(net_364), .X1110(net_364), 
      .X1111(net_364), .sel(opcode[3:0]), .out(INmux[0]));
  LC4_v3__mux1_16X1 INmux1(.X0000(net_1072), .X0001(net_1096), .X0010(net_364), 
      .X0011(net_364), .X0100(net_364), .X0101(net_364), .X0110(net_364), 
      .X0111(net_364), .X1000(net_364), .X1001(net_364), .X1010(net_364), 
      .X1011(net_364), .X1100(net_364), .X1101(net_364), .X1110(net_364), 
      .X1111(net_364), .sel(opcode[3:0]), .out(INmux[1]));
  LC4_v3__mux1_16X1 Mwe_(.X0000(net_364), .X0001(net_364), .X0010(net_364), 
      .X0011(net_1188), .X0100(net_364), .X0101(net_364), .X0110(net_364), 
      .X0111(net_364), .X1000(net_364), .X1001(net_364), .X1010(net_364), 
      .X1011(net_364), .X1100(net_364), .X1101(net_364), .X1110(net_364), 
      .X1111(net_364), .sel(opcode[3:0]), .out(Mwe));
  LC4_v3__mux1_16X1 Rwe_(.X0000(net_1065), .X0001(net_1074), .X0010(net_1102), 
      .X0011(net_364), .X0100(net_1193), .X0101(net_364), .X0110(net_364), 
      .X0111(net_364), .X1000(net_364), .X1001(net_364), .X1010(net_364), 
      .X1011(net_364), .X1100(net_364), .X1101(net_364), .X1110(net_364), 
      .X1111(net_364), .sel(opcode[3:0]), .out(Rwe));
  LC4_v3__logic_1 logic_1_0(.out(net_1065));
  LC4_v3__logic_1 logic_1_1(.out(net_1072));
  LC4_v3__logic_1 logic_1_2(.out(net_1100));
  LC4_v3__logic_1 logic_1_3(.out(net_1096));
  LC4_v3__logic_1 logic_1_4(.out(net_1097));
  LC4_v3__logic_1 logic_1_5(.out(net_1102));
  LC4_v3__logic_1 logic_1_6(.out(net_1188));
  LC4_v3__logic_1 logic_1_7(.out(net_1193));
  LC4_v3__opL opL_0();
  LC4_v3__opL opL_1();
  LC4_v3__opL opL_2();
  LC4_v3__opL opL_3();
  LC4_v3__opL opL_4();
endmodule   /* LC4_v3__Decode */

module LC4_v3__I_memory(addr, clk, out, MMUinterface);
  input [15:0] addr;
  input clk;
  output [15:0] out;
  inout [33:0] MMUinterface;

  wire I_Ready, I_Request_out, buf_0_c, buf_4_c;
  wire [15:0] I_addr_out;
  wire [15:0] I_data_read;

  /* user-specified Verilog code */
  /*------------------------
  * instruction cache
  * 16-bit word, 16-bit address,
  *  word-addressable, ROM memory.
  * The cache is faked: accesses go directly to
  * the MMU.
  *-------------------------*/
  /**/ reg I_Request;
  /**/ reg [15:0] I_addr;
  /**/ reg [15:0] out;
  /**/ assign I_Request_out = I_Request;
  /**/ assign I_addr_out = I_addr;
  /**/
  /**/ always @( addr ) begin
  /**/     I_addr <= addr;
  /**/     #10
  /**/     I_Request = 1;
  /**/     @( posedge  I_Ready );
  /**/    out <= #5 I_data_read;
  /**/     I_Request = 0;
  /**/ end
  /**/
  /**/ initial begin
  /**/     I_Request = 0;
  /**/     out = 16'd0;
  /**/ end

  buf buf_0(MMUinterface[33], I_Request_out);
  buf buf_4(I_Ready, MMUinterface[0]);
  LC4_v3__buff16 buff16_0(.in(I_addr_out[15:0]), .out(MMUinterface[32:17]));
  LC4_v3__buff16 buff16_1(.in(MMUinterface[16:1]), .out(I_data_read[15:0]));
endmodule   /* LC4_v3__I_memory */

module LC4_v3__MemoryManagement(clk, D_interface, I_interface);
  input clk;
  inout [50:0] D_interface;
  inout [33:0] I_interface;

  wire D_RW, D_Ready_out, D_Request, I_Ready_out, I_Request, buf_1_c, buf_5_c;
  wire buf_6_c, buf_7_c, buf_9_c;
  wire [15:0] D_addr;
  wire [15:0] D_data_out;
  wire [15:0] D_in;
  wire [15:0] I_addr;
  wire [16:1] I_data_out;

  /* user-specified Verilog code */
  /*------------------------
  *  Memory
  *  64kX16
  *  word-addressable,
  * 16-bit words,
  * 16-bit address (64k words) .
  *-------------------------*/
  /**/ reg[15:0] data[ 0 : ((1<<16)-1)];
  /**/ reg[15:0] out;
  //------------------------
  //-- Startup: 
  //-- write hFFFF to all the memory words.
  //-- Read prog.bin to 0x200.
  //------------------
  /**/ integer i;
  /**/ initial begin
  /**/     for (i = 0; i < (1<<16); i = i+1) begin
  /**/         data[i] = 16'hFFFF;
  /**/     end
  /**/     $readmemb("prog.bin", data);    //-- load program
  /**/ end
  /*------------------------
  * IMEM read.
  *-------------------------*/
  /**/ always @( posedge I_Request ) begin
  /**/     I_out <= #10 data[ I_addr ];
  /**/     #20
  /**/     I_Ready = 1;
  /**/     #10
  /**/      I_Ready = 0;
  /**/ end
  /*------------------------
  * DMEM read.
  *-------------------------*/
  /**/ always @( posedge clk ) begin
  /**/     @( posedge D_Request )
  /**/     if ( D_RW == 0 ) begin
  /**/         D_out <= #10 data[ D_addr ];
  /**/         #20
  /**/          D_Ready = 1;
  /**/         #10
  /**/         D_Ready = 0;
  /**/     end
  /**/ end
  /*------------------------
  * DMEM write.
  *-------------------------*/
  /**/ always @( posedge clk ) begin
  /**/     @( posedge D_Request )
  /**/     if ( D_RW == 1 ) begin
  /**/         data[ D_addr ]  <= @(posedge clk) D_in;
  /**/         #30
  /**/          D_Ready = 1;
  /**/         #10
  /**/          D_Ready = 0;
  /**/     end
  /**/ end
  /**/
  /*------------------------
  * IMEM interface.
  *-------------------------*/
  /**/ reg I_Ready;
  /**/ reg [15:0] I_out;
  /**/ assign I_data_out    = I_out;
  /**/ assign I_Ready_out = I_Ready;
  /**/
  /**/ initial begin
  /**/     I_Ready = 0;
  /**/     I_out = 16'd0;
  /**/ end
  /*------------------------
  * DMEM interface.
  *-------------------------*/
  /**/ reg D_Ready;
  /**/ reg [15:0] D_out;
  /**/ assign D_Ready_out = D_Ready;
  /**/ assign D_data_out     = D_out;
  /**/
  /**/ initial begin
  /**/     D_Ready = 0;
  /**/     D_out = 16'd0;
  /**/ end

  buf buf_1(I_Request, I_interface[33]);
  buf buf_5(I_interface[0], I_Ready_out);
  buf buf_6(D_Request, D_interface[50]);
  buf buf_7(D_RW, D_interface[49]);
  buf buf_9(D_interface[0], D_Ready_out);
  LC4_v3__buff16 buff16_0(.in(I_interface[32:17]), .out(I_addr[15:0]));
  LC4_v3__buff16 buff16_1(.in(I_data_out[16:1]), .out(I_interface[16:1]));
  LC4_v3__buff16 buff16_2(.in(D_interface[48:33]), .out(D_addr[15:0]));
  LC4_v3__buff16 buff16_3(.in(D_interface[32:17]), .out(D_in[15:0]));
  LC4_v3__buff16 buff16_4(.in(D_data_out[15:0]), .out(D_interface[16:1]));
endmodule   /* LC4_v3__MemoryManagement */

module LC4_v3__PC(D, clk, we, Q);
  input [15:0] D;
  input clk;
  input we;
  output [15:0] Q;

  /* user-specified Verilog code */
  /*-------------------
  * PC
  *    16-bit D-ff w/ write enable.
  * Also presets to a specific output.
  *--------------------*/
  /**/ reg[15:0] Q;
  /**/ always @(posedge clk) begin
  /**/     if (we == 1)
  /**/        Q <= #1 D;
  /**/ end
  /**/ initial begin
  /**/    Q <= 16'h0200; //-- (See PP, App. A)
  /**/ end

endmodule   /* LC4_v3__PC */

module LC4_v3__d_ff_16(D, clk, we, Q);
  input [15:0] D;
  input clk;
  input we;
  output [15:0] Q;

  /* user-specified Verilog code */
  /*-------------------
  * D_ff_16
  *    16-bit D-ff w/ write enable.
  *--------------------*/
  /**/ reg[15:0] Q;
  /**/ always @(posedge clk) begin
  /**/     if (we == 1)
  /**/        Q <= #1 D;
  /**/ end
  /**/ initial begin
  /**/    Q <= 0;
  /**/ end

endmodule   /* LC4_v3__d_ff_16 */

module LC4_v3__demux3x8(in, sel, out000, out001, out010, out011, out100, 
      out101, out110, out111);
  input in;
  input [2:0] sel;
  output out000;
  output out001;
  output out010;
  output out011;
  output out100;
  output out101;
  output out110;
  output out111;

  /* user-specified Verilog code */
  /*-------------
  * demux3x8
  *    Sends input signal to one of 8 outputs
  * determined by "sel".
  * All other outputs held at 0.
  *-------------
  /**/ assign #1 out000 = (sel==3'b000)? in : 0;
  /**/ assign #1 out001 = (sel==3'b001)? in : 0;
  /**/ assign #1 out010 = (sel==3'b010)? in : 0;
  /**/ assign #1 out011 = (sel==3'b011)? in : 0;
  /**/ assign #1 out100 = (sel==3'b100)? in : 0;
  /**/ assign #1 out101 = (sel==3'b101)? in : 0;
  /**/ assign #1 out110 = (sel==3'b110)? in : 0;
  /**/ assign #1 out111 = (sel==3'b111)? in : 0;

endmodule   /* LC4_v3__demux3x8 */

module LC4_v3__mux16_8x1(in000, in001, in010, in011, in100, in101, in110, 
      in111, sel, out);
  input [15:0] in000;
  input [15:0] in001;
  input [15:0] in010;
  input [15:0] in011;
  input [15:0] in100;
  input [15:0] in101;
  input [15:0] in110;
  input [15:0] in111;
  input [2:0] sel;
  output [15:0] out;

  wire [15:0] net_32;
  wire [15:0] net_35;

  LC4_v3__mux16_2x1 MUX16_2x_0(.in0(net_32[15:0]), .in1(net_35[15:0]), 
      .sel(sel[2]), .out(out[15:0]));
  LC4_v3__mux16_4x1 MUX16_4x_2(.in00(in000[15:0]), .in01(in001[15:0]), 
      .in10(in010[15:0]), .in11(in011[15:0]), .sel(sel[1:0]), 
      .out(net_32[15:0]));
  LC4_v3__mux16_4x1 MUX16_4x_3(.in00(in100[15:0]), .in01(in101[15:0]), 
      .in10(in110[15:0]), .in11(in111[15:0]), .sel(sel[1:0]), 
      .out(net_35[15:0]));
endmodule   /* LC4_v3__mux16_8x1 */

module LC4_v3__RegFile(DR, IN, Rwe, S1, S2, clk, out1, out2);
  input [2:0] DR;
  input [15:0] IN;
  input Rwe;
  input [2:0] S1;
  input [2:0] S2;
  input clk;
  output [15:0] out1;
  output [15:0] out2;

  wire net_54, net_59, net_64, net_68, net_70, net_79, net_83, we111;
  wire [15:0] R0;
  wire [15:0] R1;
  wire [15:0] R2;
  wire [15:0] R3;
  wire [15:0] R4;
  wire [15:0] R5;
  wire [15:0] R6;
  wire [15:0] R7;

  /* user-specified Verilog code */
  /**-------------------
  ** regFile.showRegs()
  **    displays register contents.
  **-------------------**/
  /**/ task showRegs;
  /**/ begin
  /**/  $display( " R0[%h] R1[%h] R2[%h] R3[%h] R4[%h] R5[%h] R6[%h] R7[%h]"
  /**/  , R0, R1, R2, R3, R4, R5, R6, R7);
  /**/ end
  /**/ endtask
  

  LC4_v3__demux3x8 DeMux(.in(Rwe), .sel(DR[2:0]), .out000(net_54), 
      .out001(net_59), .out010(net_64), .out011(net_68), .out100(net_70), 
      .out101(net_83), .out110(net_79), .out111(we111));
  LC4_v3__mux16_8x1 MUX16_8x_0(.in000(R0[15:0]), .in001(R1[15:0]), 
      .in010(R2[15:0]), .in011(R3[15:0]), .in100(R4[15:0]), .in101(R5[15:0]), 
      .in110(R6[15:0]), .in111(R7[15:0]), .sel(S2[2:0]), .out(out2[15:0]));
  LC4_v3__mux16_8x1 MUX16_8x_1(.in000(R0[15:0]), .in001(R1[15:0]), 
      .in010(R2[15:0]), .in011(R3[15:0]), .in100(R4[15:0]), .in101(R5[15:0]), 
      .in110(R6[15:0]), .in111(R7[15:0]), .sel(S1[2:0]), .out(out1[15:0]));
  LC4_v3__d_ff_16 R0_(.D(IN[15:0]), .clk(clk), .we(net_54), .Q(R0[15:0]));
  LC4_v3__d_ff_16 R1_(.D(IN[15:0]), .clk(clk), .we(net_59), .Q(R1[15:0]));
  LC4_v3__d_ff_16 R2_(.D(IN[15:0]), .clk(clk), .we(net_64), .Q(R2[15:0]));
  LC4_v3__d_ff_16 R3_(.D(IN[15:0]), .clk(clk), .we(net_68), .Q(R3[15:0]));
  LC4_v3__d_ff_16 R4_(.D(IN[15:0]), .clk(clk), .we(net_70), .Q(R4[15:0]));
  LC4_v3__d_ff_16 R5_(.D(IN[15:0]), .clk(clk), .we(net_83), .Q(R5[15:0]));
  LC4_v3__d_ff_16 R6_(.D(IN[15:0]), .clk(clk), .we(net_79), .Q(R6[15:0]));
  LC4_v3__d_ff_16 R7_(.D(IN[15:0]), .clk(clk), .we(we111), .Q(R7[15:0]));
endmodule   /* LC4_v3__RegFile */

module LC4_v3__sext9x16(in, out);
  input [8:0] in;
  output [15:0] out;

  /* user-specified Verilog code */
  /*-------------
  * sext9x16
  *   Sign-extends 9 bits to 16 bits by
  * duplicating the input's sign bit to higher
  * order bits.
  *-------------*/
  /**/ assign #1 out = { in[8], in[8], in[8], in[8], in[8], in[8], in[8], in};

endmodule   /* LC4_v3__sext9x16 */

module LC4_v3__WORD_16_h1000(out);
  output [15:0] out;

  /* user-specified Verilog code */
  /**/ reg [15:0] out;
  /**/ initial out = 16'h1000;

endmodule   /* LC4_v3__WORD_16_h1000 */

module LC4_v3__WORD_16_h0000(out);
  output [15:0] out;

  /* user-specified Verilog code */
  /**/ reg [15:0] out;
  /**/ initial out = 16'h0000;

endmodule   /* LC4_v3__WORD_16_h0000 */

module LC4_v3__mux3_2X1(X0, X1, sel, out);
  input [2:0] X0;
  input [2:0] X1;
  input sel;
  output [2:0] out;

  LC4_v3__mux1_2X1 MUX0(.X0(X0[0]), .X1(X1[0]), .sel(sel), .out(out[0]));
  LC4_v3__mux1_2X1 MUX1(.X0(X0[1]), .X1(X1[1]), .sel(sel), .out(out[1]));
  LC4_v3__mux1_2X1 MUX2(.X0(X0[2]), .X1(X1[2]), .sel(sel), .out(out[2]));
endmodule   /* LC4_v3__mux3_2X1 */

module LC4_v3__0_LC4_Top();
  wire ALUsel1, ALUsel2, BR, DRmux, ILL, Mwe, PCmux, PipeMwe, PipeRwe, Rwe, SYS;
  wire SYS_ACT, SYS_CALL, SYS_RET, and_0_yc, and_0_yt, and_2_yc, and_2_yt;
  wire and_3_yc, and_3_yt, buf_10_c, buf_11_c, buf_12_c, buf_13_c, buf_2_c;
  wire buf_3_c, buf_4_c, buf_5_c, buf_6_c, buf_7_c, buf_8_c, buf_9_c, clk;
  wire net_126, net_452, net_459, net_468, net_473, net_481, net_487, net_494;
  wire net_501, net_509, net_513, net_516, or_0_yc, or_0_yt, or_3_yc, or_3_yt;
  wire [15:0] ALUctrl;
  wire [15:0] ALUctrl_in;
  wire [15:0] ALUinput1;
  wire [15:0] ALUinput2;
  wire [15:0] ALUout;
  wire [15:0] DMEMout;
  wire [15:0] DR;
  wire [15:0] DRDffInput;
  wire [50:0] D_interface;
  wire [15:0] DffSignal;
  wire [1:0] INmux;
  wire [15:0] IR;
  wire [33:0] I_interface;
  wire [15:0] InputForDff;
  wire [15:0] PCout;
  wire [15:0] PCplusOne;
  wire [15:0] PSR;
  wire [1:0] PipeINmux;
  wire [15:0] net_429;
  wire [15:0] net_432;
  wire [15:0] net_433;
  wire [15:0] net_437;
  wire [15:0] net_440;
  wire [15:0] net_441;
  wire [15:0] net_471;
  wire [15:0] net_475;
  wire [15:0] net_484;
  wire [15:0] net_493;
  wire [15:0] net_500;
  wire [15:0] net_505;
  wire [15:0] net_508;
  wire [15:0] newPSR;
  wire [15:0] nextPC;
  wire [15:0] out1;
  wire [15:0] out2;
  wire [15:0] reg_in;

  /* user-specified Verilog code */
  //-------------------------------------------
  //-- DEBUG INITIALIZATION
  //------------------------------------------
  `include "LC4-debug.v"

  and and_0(PCmux, BR, out1[15]);
  and and_2(SYS_RET, IR[11], SYS);
  and and_3(net_459, SYS, net_452);
  not buf_2(net_452, IR[11]);
  buf buf_3(InputForDff[2], Mwe);
  buf buf_4(InputForDff[3], Rwe);
  buf buf_5(PipeRwe, DffSignal[3]);
  buf buf_6(PipeMwe, DffSignal[2]);
  buf buf_7(PipeINmux[1], DffSignal[1]);
  buf buf_8(PipeINmux[0], DffSignal[0]);
  buf buf_9(InputForDff[1], INmux[1]);
  buf buf_10(InputForDff[0], INmux[0]);
  buf buf_11(ALUctrl_in[2], IR[2]);
  buf buf_12(ALUctrl_in[1], IR[1]);
  buf buf_13(ALUctrl_in[0], IR[0]);
  or or_0(SYS_ACT, SYS_CALL, SYS_RET);
  or or_3(SYS_CALL, ILL, net_459);
  LC4_v3__logic_1 _1v_0(.out(net_126));
  LC4_v3__ALU ALU(.A(net_493[15:0]), .B(net_500[15:0]), .func(ALUctrl[2:0]), 
      .out(ALUout[15:0]));
  LC4_v3__ALUInputMux ALUInput_0(.DR(DR[2:0]), .IRInput(IR[15:12]), 
      .Rwe(PipeRwe), .SR(IR[11:9]), .ALUMuxSel(ALUsel1));
  LC4_v3__ALUInputMux ALUInput_1(.DR(DR[2:0]), .IRInput(IR[15:12]), 
      .Rwe(PipeRwe), .SR(IR[8:6]), .ALUMuxSel(ALUsel2));
  LC4_v3__increment16 Add_1(.in(PCout[15:0]), .out(PCplusOne[15:0]));
  LC4_v3__clk CLK(.out(clk));
  LC4_v3__D_memory DMEM(.RW(PipeMwe), .addr(net_475[15:0]), .clk(clk), 
      .in(net_484[15:0]), .out(DMEMout[15:0]), 
      .MMUinterface(D_interface[50:0]));
  LC4_v3__Decode Decode(.opcode(IR[15:12]), .BR(BR), .DRmux(DRmux), .ILL(ILL), 
      .INmux(INmux[1:0]), .Mwe(Mwe), .Rwe(Rwe), .SYS(SYS));
  LC4_v3__I_memory IMEM(.addr(PCout[15:0]), .clk(clk), .out(IR[15:0]), 
      .MMUinterface(I_interface[33:0]));
  LC4_v3__MemoryManagement MMU(.clk(clk), .D_interface(D_interface[50:0]), 
      .I_interface(I_interface[33:0]));
  LC4_v3__PC PC(.D(net_429[15:0]), .clk(clk), .we(net_126), .Q(PCout[15:0]));
  LC4_v3__d_ff_16 PSR_(.D(net_440[15:0]), .clk(clk), .we(SYS_ACT), 
      .Q(PSR[15:0]));
  LC4_v3__RegFile RegFile(.DR(DR[2:0]), .IN(reg_in[15:0]), .Rwe(PipeRwe), 
      .S1(IR[11:9]), .S2(IR[8:6]), .clk(clk), .out1(out1[15:0]), 
      .out2(out2[15:0]));
  LC4_v3__sext9x16 SEXT9(.in(IR[8:0]), .out(net_505[15:0]));
  LC4_v3__d_ff_16 SavedPC(.D(PCplusOne[15:0]), .clk(clk), .we(SYS_CALL), 
      .Q(net_437[15:0]));
  LC4_v3__d_ff_16 SavedPSR(.D(PSR[15:0]), .clk(clk), .we(SYS_CALL), 
      .Q(net_441[15:0]));
  LC4_v3__WORD_16_h1000 WORD_16__0(.out(net_433[15:0]));
  LC4_v3__WORD_16_h0000 WORD_16__1(.out(newPSR[15:0]));
  LC4_v3__d_ff_16 d_ff_16_1(.D(PCplusOne[15:0]), .clk(clk), .we(net_468), 
      .Q(net_471[15:0]));
  LC4_v3__d_ff_16 d_ff_16_2(.D(out2[15:0]), .clk(clk), .we(net_473), 
      .Q(net_475[15:0]));
  LC4_v3__d_ff_16 d_ff_16_3(.D(out1[15:0]), .clk(clk), .we(net_481), 
      .Q(net_484[15:0]));
  LC4_v3__d_ff_16 d_ff_16_4(.D(ALUinput1[15:0]), .clk(clk), .we(net_487), 
      .Q(net_493[15:0]));
  LC4_v3__d_ff_16 d_ff_16_5(.D(ALUinput2[15:0]), .clk(clk), .we(net_494), 
      .Q(net_500[15:0]));
  LC4_v3__d_ff_16 d_ff_16_6(.D(net_505[15:0]), .clk(clk), .we(net_501), 
      .Q(net_508[15:0]));
  LC4_v3__d_ff_16 d_ff_16_7(.D(ALUctrl_in[15:0]), .clk(clk), .we(net_509), 
      .Q(ALUctrl[15:0]));
  LC4_v3__d_ff_16 d_ff_16_8(.D(DRDffInput[15:0]), .clk(clk), .we(net_513), 
      .Q(DR[15:0]));
  LC4_v3__d_ff_16 d_ff_16_9(.D(InputForDff[15:0]), .clk(clk), .we(net_516), 
      .Q(DffSignal[15:0]));
  LC4_v3__mux3_2X1 drmux(.X0(IR[11:9]), .X1(IR[5:3]), .sel(DRmux), 
      .out(DRDffInput[2:0]));
  LC4_v3__logic_1 logic_1_1(.out(net_468));
  LC4_v3__logic_1 logic_1_2(.out(net_473));
  LC4_v3__logic_1 logic_1_3(.out(net_481));
  LC4_v3__logic_1 logic_1_4(.out(net_487));
  LC4_v3__logic_1 logic_1_5(.out(net_494));
  LC4_v3__logic_1 logic_1_6(.out(net_501));
  LC4_v3__logic_1 logic_1_7(.out(net_509));
  LC4_v3__logic_1 logic_1_8(.out(net_513));
  LC4_v3__logic_1 logic_1_9(.out(net_516));
  LC4_v3__mux16_2x1 mux16_2x_1(.in0(net_433[15:0]), .in1(net_437[15:0]), 
      .sel(SYS_RET), .out(net_432[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_2(.in0(newPSR[15:0]), .in1(net_441[15:0]), 
      .sel(SYS_RET), .out(net_440[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_3(.in0(out1[15:0]), .in1(reg_in[15:0]), 
      .sel(ALUsel1), .out(ALUinput1[15:0]));
  LC4_v3__mux16_2x1 mux16_2x_4(.in0(out2[15:0]), .in1(reg_in[15:0]), 
      .sel(ALUsel2), .out(ALUinput2[15:0]));
  LC4_v3__mux16_4x1 mux16_4x_0(.in00(net_471[15:0]), .in01(DMEMout[15:0]), 
      .in10(ALUout[15:0]), .in11(net_508[15:0]), .sel(PipeINmux[1:0]), 
      .out(reg_in[15:0]));
  LC4_v3__mux16_2x1 pcmux(.in0(PCplusOne[15:0]), .in1(out2[15:0]), .sel(PCmux), 
      .out(nextPC[15:0]));
  LC4_v3__mux16_2x1 sysmux(.in0(nextPC[15:0]), .in1(net_432[15:0]), 
      .sel(SYS_ACT), .out(net_429[15:0]));
endmodule   /* LC4_v3__0_LC4_Top */

module _0_LC4_sim();
  /* user-specified Verilog code */
  //-------------------------------------------
  //-- SIMULATION CONTROL AND DISPLAY
  //------------------------------------------
  /**/ always @(negedge LC4.clk) begin
  /**/     #500
  /**/     $display("");
  /**/     $display("=======================(%0d)===========", $time);
  /**/     $display("");
  /**/     LC4.RegFile.showRegs();
  /**/     $display("");
  /**/     showMEM( LC4.PCout );
  /**/     $display("============================================");
  /**/     $display("");
  /**/     $stop(0);
  /**/ end
  /**/ initial begin
  /**/     showBanner();
  /**/ end
    /**/ task showBanner;
    /**/   begin
    /**/       $display("#####################################################");
    /**/       $display("###   LC4, starting simulation, attempted to read prog.bin. ");
    /**/       $display("###     simulation controls:                           ");
    /**/       $display("###      \"cont\":     single step execution ");
    /**/       $display("###      \"$finish\":  exit simulation");
    /**/       $display("#####################################################");
    /**/   end
    /**/ endtask
      /**/ task showMEM;
      /**/   input [15:0] addr;
      /**/   reg [15:0] ad;
      /**/   integer i;
      /**/   begin
      /**/     $display(  "                ---- Memory ----");
      /**/     $display(  "      addr      ---- content----       translation");
      /**/     $display(  "      ----      ----------------       ----------------");
      /**/     for ( i = -4; i < 0; i = i + 1 ) begin
      /**/         ad = addr + i;
      /**/         $write("      %h:     %b       ", ad, LC4.MMU.data[ ad ]);
      /**/         showInstruction( LC4.MMU.data[ ad ] );
      /**/         $display("");
      /**/     end
      /**/     $write(    "PC==> %h:     %b <==   ", addr, LC4.MMU.data[ addr ]);
      /**/     showInstruction( LC4.MMU.data[ addr ] );
      /**/     $display("");
      /**/     for ( i = 1; i < 6; i = i + 1 ) begin
      /**/         ad = addr + i;
      /**/         $write("      %h:     %b       ", ad, LC4.MMU.data[ ad ]);
      /**/         showInstruction( LC4.MMU.data[ ad ] );
      /**/         $display("");
      /**/     end
      /**/     $display(  "                ----------------");
      /**/   end
      /**/ endtask
    /**/ task showInstruction;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     case ( instr[15:12] )
    /**/       4'b0000  : showALU( instr );
    /**/       4'b0001  : showLIM( instr );
    /**/       4'b0010  : showLDR( instr );
    /**/       4'b0011  : showSTR( instr );
    /**/       4'b0100  : showLEA( instr );
    /**/       4'b0101  : showBRR( instr );
    /**/       4'b0110  : showSYS( instr );
    /**/       default  : $write("unknown instruction");
    /**/     endcase
    /**/   end
    /**/ endtask
    /**/ task showALU;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("ALU ");
    /**/     $write(" SR%d ", instr[11:9]);
    /**/     $write(" SR%d ", instr[8:6]);
    /**/     $write(" DR%d ", instr[5:3]);
    /**/     showFun(instr[2:0]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showFun;
    /**/   input [2:0] num;
    /**/   begin
    /**/       case( num )
    /**/         3'b000  : $write("ADD ");
    /**/         3'b100  : $write("SUB ");
    /**/         3'b001  : $write("AND ");
    /**/         3'b101  : $write("iOR ");
    /**/         3'b010  : $write("NOT ");
    /**/         3'b110  : $write("NOR ");
    /**/         3'b011  : $write("INC ");
    /**/         3'b111  : $write("DEC ");
    /**/         default : $write("unknown ");
    /**/       endcase
    /**/   end
    /**/ endtask
    /**/ task showLIM;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("LIM ");
    /**/     $write(" DR%d ", instr[11:9]);
    /**/     $write(" %x ", instr[8:0]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showLDR;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("LDR ");
    /**/     $write(" DR%d ", instr[11:9]);
    /**/     $write(" AR%d ", instr[8:6]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showSTR;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("STR ");
    /**/     $write(" SR%d ", instr[11:9]);
    /**/     $write(" AR%d ", instr[8:6]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showLEA;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("LEA ");
    /**/     $write(" DR%d ", instr[11:9]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showBRR;
    /**/   input [15:0] instr;
    /**/   begin
    /**/     $write("BRR ");
    /**/     $write(" CR%d ", instr[11:9]);
    /**/     $write(" AR%d ", instr[8:6]);
    /**/     $write("  ");
    /**/   end
    /**/ endtask
    /**/ task showSYS;
    /**/   input [15:0] instr;
    /**/   begin
    /**/       $write("SYS "); 
    /**/       case( instr[11:9] )
    /**/         3'b000  : $write("CALL ");
    /**/         3'b100  : $write("RET ");
    /**/         default : $write("unknown ");
    /**/      endcase
    /**/      $write("  ");
    /**/   end
    /**/ endtask

  LC4_v3__0_LC4_Top LC4();
endmodule   /* _0_LC4_sim */
