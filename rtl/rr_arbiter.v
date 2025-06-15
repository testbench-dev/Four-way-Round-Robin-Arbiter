// ---------------------------------------------------------------------
// rr_arbiter.v  – 4-way round-robin arbiter, pure Verilog-2001
// ---------------------------------------------------------------------
module rr_arbiter (
    input        clk,
    input        rst_n,     // async active-low reset
    input  [3:0] req,       // request lines
    output reg [3:0] grant   // one-hot grant
);
    reg [1:0] ptr, next_ptr;
    wire [1:0] idx0 = ptr;
    wire [1:0] idx1 = (ptr==2'd3 ? 2'd0 : ptr+2'd1);
    wire [1:0] idx2 = (ptr>=2'd2 ? ptr-2'd2 : ptr+2'd2);
    wire [1:0] idx3 = (ptr==2'd0 ? 2'd3 : ptr-2'd1);

    // Combinational priority rotate
    always @* begin
        grant     = 4'b0000;
        next_ptr  = ptr;
        if      (req[idx0]) begin grant[idx0] = 1; next_ptr = (idx0==2'd3 ? 2'd0 : idx0+2'd1); end
        else if (req[idx1]) begin grant[idx1] = 1; next_ptr = (idx1==2'd3 ? 2'd0 : idx1+2'd1); end
        else if (req[idx2]) begin grant[idx2] = 1; next_ptr = (idx2==2'd3 ? 2'd0 : idx2+2'd1); end
        else if (req[idx3]) begin grant[idx3] = 1; next_ptr = (idx3==2'd3 ? 2'd0 : idx3+2'd1); end
    end

    // Pointer update
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) ptr <= 2'd0;
        else        ptr <= next_ptr;
    end
endmodule
