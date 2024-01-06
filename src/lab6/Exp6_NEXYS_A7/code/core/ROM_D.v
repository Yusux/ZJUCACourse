`timescale 1ns / 1ps

module ROM_D(
    (* DONT_TOUCH = "1" *) input[8:0] a,
    output[31:0] spo
);

    reg[31:0] inst_data[0:1023];

    initial	begin
        $readmemh("rom_lab3.mem", inst_data);
        // $readmemh("rom.mem", inst_data);
    end

    assign spo = inst_data[a];

endmodule