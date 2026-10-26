`include "slice_scheduler.v"

module top #(parameter N = 15, M = 4, T = 2, MAX_ITER = 100)(clk, rst, start_3d, load_3d, done_3d, fail_3d, iters);
    input clk, rst;
    input start_3d, load_3d;

    output done_3d, fail_3d;
    output [7:0] iters;

    wire [N*N*N-1:0] cube_in, cube_out;

    reg [N*N*N-1:0] cube_in_mem [0:0];
    initial begin
        $readmemh("cube_in.hex", cube_in_mem);
    end

    assign cube_in = cube_in_mem[0];

    slice_scheduler #(.N(N), .M(M), .T(T), .MAX_ITER(MAX_ITER)) datapath_3d (
        .clk(clk),
        .rst(rst),
        .start_3d(start_3d),
        .load_3d(load_3d),
        .done_3d(done_3d),
        .fail_3d(fail_3d),
        .iters(iters),
        .cube_in(cube_in),
        .cube_out(cube_out)
    );
endmodule