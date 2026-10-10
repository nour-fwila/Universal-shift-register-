module usr_tb #(parameter N=4) ();
  reg [N-1:0]I;
  reg clk;
  reg [1:0]sel;
  reg reset;
  reg MSB;
  reg LSB;
  reg [N-1:0]ex;//excepected value
  wire [N-1:0]q;
  //instantiation
  usr #(.N(N)) uut (
    .clk(clk),
    .sel(sel),
    .I(I),
    .MSB(MSB),
    .LSB(LSB),
    .q(q),
    .reset(reset)
  );

  //refrence model
always @(posedge clk or negedge reset) begin
    if (!reset)
        ex <= {N{1'b0}};
    else begin
        case (sel)
            2'b00: ex <= ex;
            2'b01: ex <= {MSB, ex[N-1:1]};
            2'b10: ex <= {ex[N-2:0], LSB};
            2'b11: ex <= I;
        endcase
    end
end
//automatic checker
always @(posedge clk) begin
    #1;//a delay that allows the updates to complete before comparison.

    if (q !== ex)
        $display("FAIL: expected=%b, actual=%b", ex, q);
    else
        $display("PASS: expected=%b, actual=%b", ex, q);
end
  //initializing the clock
  localparam T = 20;
  always
    begin
      clk = 1'b0;
      # (T/2);
      clk = 1'b1;
      #(T/2);
    end
    
     // Test stimulus
    initial begin
        $dumpfile("sim.vcd");  // Creates the waveform file
        $dumpvars(0, usr_tb);  // Dumps all variables in the testbench
        I = 0;
        sel = 0;
        MSB = 0;
        LSB = 0;
        reset = 1;

        // Assert reset
        #2 reset = 0;
        #1;
        if (q !== {N{1'b0}})
            $display("RESET FAILED");

        // Release reset
        @(negedge clk);
        reset = 1;

        // Load
        I = 4'b0101;
        sel = 2'b11;

        // Shift right
        @(negedge clk);
        sel = 2'b01;
        MSB = 1;

        // Shift left
        @(negedge clk);
        sel = 2'b10;
        LSB = 1;

        // Hold
        @(negedge clk);
        sel = 2'b00;

        // Reset again
        @(negedge clk);
        reset = 0;

        #1;
        if (q !== {N{1'b0}})
            $display("RESET FAILED");

        @(negedge clk);
        reset = 1;

        // One more operation
        sel = 2'b11;
        I = 4'b1010;

        repeat (2) @(negedge clk);

        $finish;
    end
endmodule