module usr #(parameter N=4) (
  input [N-1:0]I,
  input clk,
  input [1:0]sel,
  input reset,
  input MSB,
  input LSB,
  output [N-1:0]q

);
  
   //regester part
  reg  [N-1:0] q_next,q_reg;
  always@(posedge clk or negedge reset)
  begin
    if(!reset)
      q_reg<={N{1'b0}};
      else
    q_reg<= q_next;
  end
  //combinational part
  always@(*)
    begin
      case(sel)
        2'b00: q_next = q_reg; //hold
        2'b01: q_next = {MSB, q_reg[N-1:1]};//shift right
        2'b10:q_next = {q_reg[N-2:0],LSB}; //shift lift
        2'b11:q_next = I; // load
        default: q_next = q_reg;
      endcase  
    end
  assign q=q_reg; 
endmodule