module sim_top;

	// Inputs
	reg clk;
	reg rstn;
	wire [31:0] debug_WB_PC;
	// save pc at wb
	reg [31:0] wb_pc; 

	top uut (
		.CLK100MHZ(clk),
		.SW(16'b0),
		.RSTN(rstn),
		.debug_WB_PC(debug_WB_PC)
	);

	integer traceout;
	initial begin
		// Initialize Inputs
		clk = 0;
		rstn = 0;
		wb_pc = 0;
		traceout = $fopen("trace.out");

		// Wait 100 ns for global reset to finish
		#95 rstn = 1;
        
		// Add stimulus here
	end
	
	initial forever #10 clk = ~clk;

	always@(clk)begin
    if(wb_pc != debug_WB_PC)begin
        // output signal values to file
        $fdisplay(traceout, " WB_PC=0x%8h",debug_WB_PC );
        wb_pc <= debug_WB_PC;
    end
end
      
endmodule
