`timescale 1ns/1ps
module tb_rr_arbiter;
    reg        clk   = 0;
    always #5 clk = ~clk;            // 100 MHz

    reg        rst_n = 0;
    reg  [3:0] req   = 0;
    wire [3:0] grant;

    rr_arbiter uut (
        .clk   (clk),
        .rst_n (rst_n),
        .req   (req),
        .grant (grant)
    );

    integer i, count, j;

    initial begin
        // reset
        rst_n = 0; #20; rst_n = 1;

        // random requests for 200 cycles
        for (i = 0; i < 200; i = i + 1) begin
            req = $random & 4'hF;
            #10;  // let grant settle

            // check at most one grant
            count = grant[0] + grant[1] + grant[2] + grant[3];
            if (count > 1) $fatal("Multiple grants: %b", grant);

            // if granted, the requester must have asserted req
            if (count == 1) begin
                for (j = 0; j < 4; j = j + 1)
                    if (grant[j] && !req[j])
                        $fatal("Grant without request at index %0d", j);
            end
        end

        $display("RR-Lite Arbiter TB PASSED.");
        #10 $finish;
    end
endmodule
