`include "ccp_top.v"

module datapath_3d #(parameter N = 15, M = 4, T = 2, MAX_ITER = 100) (clk, rst, start_3d, cube_in, done_3d, fail_3d, iters);
    input clk, rst;
    input start_3d;
    input [N*N*N-1:0] cube_in;

    output reg done_3d, fail_3d;
    output reg [7:0] iters;

    localparam IW = $clog2(N+1);
    localparam NN = N*N;

    //intermediate cube register
    reg [N*N*N-1:0] cube;

    //input slices to the 2d decoders
    reg [NN-1:0] r_in_0;
    reg [NN-1:0] r_in_1;
    reg [NN-1:0] r_in_2;
    reg [NN-1:0] r_in_3;
    reg [NN-1:0] r_in_4;
    reg [NN-1:0] r_in_5;
    reg [NN-1:0] r_in_6;
    reg [NN-1:0] r_in_7;
    reg [NN-1:0] r_in_8;
    reg [NN-1:0] r_in_9;
    reg [NN-1:0] r_in_10;
    reg [NN-1:0] r_in_11;
    reg [NN-1:0] r_in_12;
    reg [NN-1:0] r_in_13;
    reg [NN-1:0] r_in_14;

    //2d control signals (i/o)
    reg start_2d;
    wire [N-1:0] done_2d_v;

    //2d error outputs
    wire [NN-1:0] cout_2d_0;
    wire [NN-1:0] cout_2d_1;
    wire [NN-1:0] cout_2d_2;
    wire [NN-1:0] cout_2d_3;
    wire [NN-1:0] cout_2d_4;
    wire [NN-1:0] cout_2d_5;
    wire [NN-1:0] cout_2d_6;
    wire [NN-1:0] cout_2d_7;
    wire [NN-1:0] cout_2d_8;
    wire [NN-1:0] cout_2d_9;
    wire [NN-1:0] cout_2d_10;
    wire [NN-1:0] cout_2d_11;
    wire [NN-1:0] cout_2d_12;
    wire [NN-1:0] cout_2d_13;
    wire [NN-1:0] cout_2d_14;

    //registered 2d errors
    reg [NN-1:0] err_2d_0;
    reg [NN-1:0] err_2d_1;
    reg [NN-1:0] err_2d_2;
    reg [NN-1:0] err_2d_3;
    reg [NN-1:0] err_2d_4;
    reg [NN-1:0] err_2d_5;
    reg [NN-1:0] err_2d_6;
    reg [NN-1:0] err_2d_7;
    reg [NN-1:0] err_2d_8;
    reg [NN-1:0] err_2d_9;
    reg [NN-1:0] err_2d_10;
    reg [NN-1:0] err_2d_11;
    reg [NN-1:0] err_2d_12;
    reg [NN-1:0] err_2d_13;
    reg [NN-1:0] err_2d_14;

    //2d decoders instantiated slice wise
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_0 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_0),
        .c_out(cout_2d_0),
        .done(done_2d_v[0])
    ); 
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_1 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_1),
        .c_out(cout_2d_1),
        .done(done_2d_v[1])
    ); 
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_2 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_2),
        .c_out(cout_2d_2),
        .done(done_2d_v[2])
    ); 
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_3 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_3),
        .c_out(cout_2d_3),
        .done(done_2d_v[3])
    ); 
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_4 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_4),
        .c_out(cout_2d_4),
        .done(done_2d_v[4])
    ); 

    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_5 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_5),
        .c_out(cout_2d_5),
        .done(done_2d_v[5])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_6 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_6),
        .c_out(cout_2d_6),
        .done(done_2d_v[6])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_7 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_7),
        .c_out(cout_2d_7),
        .done(done_2d_v[7])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_8 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_8),
        .c_out(cout_2d_8),
        .done(done_2d_v[8])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_9 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_9),
        .c_out(cout_2d_9),
        .done(done_2d_v[9])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_10 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_10),
        .c_out(cout_2d_10),
        .done(done_2d_v[10])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_11 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_11),
        .c_out(cout_2d_11),
        .done(done_2d_v[11])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_12 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_12),
        .c_out(cout_2d_12),
        .done(done_2d_v[12])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_13 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_13),
        .c_out(cout_2d_13),
        .done(done_2d_v[13])
    );
    ccp_top #(.N(N), .M(M), .T(T)) DEC_2D_INST_14 (
        .clk(clk),
        .rst(rst),
        .start(start_2d),
        .r_in(r_in_14),
        .c_out(cout_2d_14),
        .done(done_2d_v[14])
    );
    
    localparam IDLE = 0;
    localparam LOAD = 1;
    localparam START = 2;
    localparam WAIT = 3;
    localparam VERIFY = 4;
    localparam APPLY = 5;
    localparam NEXT = 6;

    integer r, c;

    //try catch mechanism
    wire check0;
    wire check1;
    wire check2;
    wire check3;
    wire check4;
    wire check5;
    wire check6;
    wire check7;
    wire check8;
    wire check9;
    wire check10;
    wire check11;
    wire check12;
    wire check13;
    wire check14;

    assign check0 = ((r_in_0 ^ err_2d_0) == 0) && (r_in_0 != 0);
    assign check1 = ((r_in_1 ^ err_2d_1) == 0) && (r_in_1 != 0);
    assign check2 = ((r_in_2 ^ err_2d_2) == 0) && (r_in_2 != 0);
    assign check3 = ((r_in_3 ^ err_2d_3) == 0) && (r_in_3 != 0);
    assign check4 = ((r_in_4 ^ err_2d_4) == 0) && (r_in_4 != 0);
    assign check5 = ((r_in_5 ^ err_2d_5) == 0) && (r_in_5 != 0);
    assign check6 = ((r_in_6 ^ err_2d_6) == 0) && (r_in_6 != 0);
    assign check7 = ((r_in_7 ^ err_2d_7) == 0) && (r_in_7 != 0);
    assign check8 = ((r_in_8 ^ err_2d_8) == 0) && (r_in_8 != 0);
    assign check9 = ((r_in_9 ^ err_2d_9) == 0) && (r_in_9 != 0);
    assign check10 = ((r_in_10 ^ err_2d_10) == 0) && (r_in_10 != 0);
    assign check11 = ((r_in_11 ^ err_2d_11) == 0) && (r_in_11 != 0);
    assign check12 = ((r_in_12 ^ err_2d_12) == 0) && (r_in_12 != 0);
    assign check13 = ((r_in_13 ^ err_2d_13) == 0) && (r_in_13 != 0);
    assign check14 = ((r_in_14 ^ err_2d_14) == 0) && (r_in_14 != 0);

    //final correction registers
    reg [NN-1:0] corr0;
    reg [NN-1:0] corr1;
    reg [NN-1:0] corr2;
    reg [NN-1:0] corr3;
    reg [NN-1:0] corr4;
    reg [NN-1:0] corr5;
    reg [NN-1:0] corr6;
    reg [NN-1:0] corr7;
    reg [NN-1:0] corr8;
    reg [NN-1:0] corr9;
    reg [NN-1:0] corr10;
    reg [NN-1:0] corr11;
    reg [NN-1:0] corr12;
    reg [NN-1:0] corr13;
    reg [NN-1:0] corr14;

    //fsm control registers
    reg [2:0] state;
    reg [1:0] pass_idx;
    reg sweep_dirty;

    always @(posedge clk) begin
        if(rst) begin
            state <= IDLE;
            pass_idx <= 0;
            start_2d <= 0;
            sweep_dirty <= 0;

            r_in_0 <= 0;
            r_in_1 <= 0;
            r_in_2 <= 0;
            r_in_3 <= 0;
            r_in_4 <= 0;
            r_in_5 <= 0;
            r_in_6 <= 0;
            r_in_7 <= 0;
            r_in_8 <= 0;
            r_in_9 <= 0;
            r_in_10 <= 0;
            r_in_11 <= 0;
            r_in_12 <= 0;
            r_in_13 <= 0;
            r_in_14 <= 0;

            err_2d_0 <= 0;
            err_2d_1 <= 0;
            err_2d_2 <= 0;
            err_2d_3 <= 0;
            err_2d_4 <= 0;
            err_2d_5 <= 0;
            err_2d_6 <= 0;
            err_2d_7 <= 0;
            err_2d_8 <= 0;
            err_2d_9 <= 0;
            err_2d_10 <= 0;
            err_2d_11 <= 0;
            err_2d_12 <= 0;
            err_2d_13 <= 0;
            err_2d_14 <= 0;

            corr0 <= 0;
            corr1 <= 0;
            corr2 <= 0;
            corr3 <= 0;
            corr4 <= 0;
            corr5 <= 0;
            corr6 <= 0;
            corr7 <= 0;
            corr8 <= 0;
            corr9 <= 0;
            corr10 <= 0;
            corr11 <= 0;
            corr12 <= 0;
            corr13 <= 0;
            corr14 <= 0;

            done_3d <= 0;
            fail_3d <= 0;
            iters <= 0;
        end
        else begin
            case(state)
                IDLE : begin
                    pass_idx <= 0;

                    done_3d <= 0;
                    fail_3d <= 0;
                    iters <= 0;

                    sweep_dirty <= 0;

                    if(start_3d) begin
                        cube <= cube_in;
                        state <= LOAD;
                    end
                end

                LOAD : begin
                    for(r = 0; r < N; r = r + 1) begin
                        for(c = 0; c < N; c = c + 1) begin
                            r_in_0[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 0]: 
                                               (pass_idx == 1) ? cube[(r*N + 0)*N + c]: 
                                                                 cube[(0*N + r)*N + c]; 
                            r_in_1[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 1]: 
                                               (pass_idx == 1) ? cube[(r*N + 1)*N + c]: 
                                                                 cube[(1*N + r)*N + c];
                            r_in_2[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 2]: 
                                               (pass_idx == 1) ? cube[(r*N + 2)*N + c]: 
                                                                 cube[(2*N + r)*N + c]; 
                            r_in_3[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 3]: 
                                               (pass_idx == 1) ? cube[(r*N + 3)*N + c]: 
                                                                 cube[(3*N + r)*N + c]; 
                            r_in_4[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 4]: 
                                               (pass_idx == 1) ? cube[(r*N + 4)*N + c]: 
                                                                 cube[(4*N + r)*N + c]; 
                            r_in_5[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 5]: 
                                               (pass_idx == 1) ? cube[(r*N + 5)*N + c]: 
                                                                 cube[(5*N + r)*N + c];
                            r_in_6[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 6]: 
                                               (pass_idx == 1) ? cube[(r*N + 6)*N + c]: 
                                                                 cube[(6*N + r)*N + c]; 
                            r_in_7[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 7]: 
                                               (pass_idx == 1) ? cube[(r*N + 7)*N + c]: 
                                                                 cube[(7*N + r)*N + c]; 
                            r_in_8[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 8]: 
                                               (pass_idx == 1) ? cube[(r*N + 8)*N + c]: 
                                                                 cube[(8*N + r)*N + c]; 
                            r_in_9[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 9]: 
                                               (pass_idx == 1) ? cube[(r*N + 9)*N + c]: 
                                                                 cube[(9*N + r)*N + c];
                            r_in_10[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 10]: 
                                                (pass_idx == 1) ? cube[(r*N + 10)*N + c]: 
                                                                  cube[(10*N + r)*N + c]; 
                            r_in_11[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 11]: 
                                                (pass_idx == 1) ? cube[(r*N + 11)*N + c]: 
                                                                  cube[(11*N + r)*N + c]; 
                            r_in_12[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 12]: 
                                                (pass_idx == 1) ? cube[(r*N + 12)*N + c]: 
                                                                  cube[(12*N + r)*N + c]; 
                            r_in_13[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 13]: 
                                                (pass_idx == 1) ? cube[(r*N + 13)*N + c]: 
                                                                  cube[(13*N + r)*N + c];
                            r_in_14[r*N + c] <= (pass_idx == 0) ? cube[(r*N + c)*N + 14]: 
                                                (pass_idx == 1) ? cube[(r*N + 14)*N + c]: 
                                                                  cube[(14*N + r)*N + c]; 
                        end
                    end
                    state <= START;
                end

                START : begin
                    start_2d <= 1;
                    state <= WAIT;
                end

                WAIT : begin
                    start_2d <= 0;
                    if(&done_2d_v) begin
                        state <= VERIFY;

                        err_2d_0 <= cout_2d_0;
                        err_2d_1 <= cout_2d_1;
                        err_2d_2 <= cout_2d_2;
                        err_2d_3 <= cout_2d_3;
                        err_2d_4 <= cout_2d_4;
                        err_2d_5 <= cout_2d_5;
                        err_2d_6 <= cout_2d_6;
                        err_2d_7 <= cout_2d_7;
                        err_2d_8 <= cout_2d_8;
                        err_2d_9 <= cout_2d_9;
                        err_2d_10 <= cout_2d_10;
                        err_2d_11 <= cout_2d_11;
                        err_2d_12 <= cout_2d_12;
                        err_2d_13 <= cout_2d_13;
                        err_2d_14 <= cout_2d_14;
                    end
                end

                VERIFY : begin
                    if(~check0) begin
                        corr0 <= r_in_0;
                    end
                    else begin
                        corr0 <= err_2d_0 ^ r_in_0;
                    end

                    if(~check1) begin
                        corr1 <= r_in_1;
                    end
                    else begin
                        corr1 <= err_2d_1 ^ r_in_1;
                    end

                    if(~check2) begin
                        corr2 <= r_in_2;
                    end
                    else begin
                        corr2 <= err_2d_2 ^ r_in_2;
                    end

                    if(~check3) begin
                        corr3 <= r_in_3;
                    end
                    else begin
                        corr3 <= err_2d_3 ^ r_in_3;
                    end

                    if(~check4) begin
                        corr4 <= r_in_4;
                    end
                    else begin
                        corr4 <= err_2d_4 ^ r_in_4;
                    end

                    if(~check5) begin
                        corr5 <= r_in_5;
                    end
                    else begin
                        corr5 <= err_2d_5 ^ r_in_5;
                    end

                    if(~check6) begin
                        corr6 <= r_in_6;
                    end
                    else begin
                        corr6 <= err_2d_6 ^ r_in_6;
                    end

                    if(~check7) begin
                        corr7 <= r_in_7;
                    end
                    else begin
                        corr7 <= err_2d_7 ^ r_in_7;
                    end

                    if(~check8) begin
                        corr8 <= r_in_8;
                    end
                    else begin
                        corr8 <= err_2d_8 ^ r_in_8;
                    end

                    if(~check9) begin
                        corr9 <= r_in_9;
                    end
                    else begin
                        corr9 <= err_2d_9 ^ r_in_9;
                    end

                    if(~check10) begin
                        corr10 <= r_in_10;
                    end
                    else begin
                        corr10 <= err_2d_10 ^ r_in_10;
                    end

                    if(~check11) begin
                        corr11 <= r_in_11;
                    end
                    else begin
                        corr11 <= err_2d_11 ^ r_in_11;
                    end

                    if(~check12) begin
                        corr12 <= r_in_12;
                    end
                    else begin
                        corr12 <= err_2d_12 ^ r_in_12;
                    end

                    if(~check13) begin
                        corr13 <= r_in_13;
                    end
                    else begin
                        corr13 <= err_2d_13 ^ r_in_13;
                    end

                    if(~check14) begin
                        corr14 <= r_in_14;
                    end
                    else begin
                        corr14 <= err_2d_14 ^ r_in_14;
                    end

                    state <= APPLY;
                    sweep_dirty <= (check0 | check1 | check2 | check3 | check4 | check5 | check6 | check7 | check8 | check9 | check10 | check11 | check12 | check13 | check14);
                end

                APPLY : begin
                    for(r = 0; r < N; r = r + 1) begin
                        for(c = 0; c < N; c = c + 1) begin
                            case(pass_idx)
                                2'd0 : begin    // XY: x=r y=c z=i
                                    cube[(r*N + c)*N + 0]  <= corr0[r*N + c];
                                    cube[(r*N + c)*N + 1]  <= corr1[r*N + c];
                                    cube[(r*N + c)*N + 2]  <= corr2[r*N + c];
                                    cube[(r*N + c)*N + 3]  <= corr3[r*N + c];
                                    cube[(r*N + c)*N + 4]  <= corr4[r*N + c];
                                    cube[(r*N + c)*N + 5]  <= corr5[r*N + c];
                                    cube[(r*N + c)*N + 6]  <= corr6[r*N + c];
                                    cube[(r*N + c)*N + 7]  <= corr7[r*N + c];
                                    cube[(r*N + c)*N + 8]  <= corr8[r*N + c];
                                    cube[(r*N + c)*N + 9]  <= corr9[r*N + c];
                                    cube[(r*N + c)*N + 10] <= corr10[r*N + c];
                                    cube[(r*N + c)*N + 11] <= corr11[r*N + c];
                                    cube[(r*N + c)*N + 12] <= corr12[r*N + c];
                                    cube[(r*N + c)*N + 13] <= corr13[r*N + c];
                                    cube[(r*N + c)*N + 14] <= corr14[r*N + c];
                                end
                                2'd1 : begin    // XZ: x=r y=i z=c
                                    cube[(r*N + 0)*N + c]  <= corr0[r*N + c];
                                    cube[(r*N + 1)*N + c]  <= corr1[r*N + c];
                                    cube[(r*N + 2)*N + c]  <= corr2[r*N + c];
                                    cube[(r*N + 3)*N + c]  <= corr3[r*N + c];
                                    cube[(r*N + 4)*N + c]  <= corr4[r*N + c];
                                    cube[(r*N + 5)*N + c]  <= corr5[r*N + c];
                                    cube[(r*N + 6)*N + c]  <= corr6[r*N + c];
                                    cube[(r*N + 7)*N + c]  <= corr7[r*N + c];
                                    cube[(r*N + 8)*N + c]  <= corr8[r*N + c];
                                    cube[(r*N + 9)*N + c]  <= corr9[r*N + c];
                                    cube[(r*N + 10)*N + c] <= corr10[r*N + c];
                                    cube[(r*N + 11)*N + c] <= corr11[r*N + c];
                                    cube[(r*N + 12)*N + c] <= corr12[r*N + c];
                                    cube[(r*N + 13)*N + c] <= corr13[r*N + c];
                                    cube[(r*N + 14)*N + c] <= corr14[r*N + c];
                                end
                                default : begin // YZ: x=i y=r z=c
                                    cube[(0*N + r)*N + c]  <= corr0[r*N + c];
                                    cube[(1*N + r)*N + c]  <= corr1[r*N + c];
                                    cube[(2*N + r)*N + c]  <= corr2[r*N + c];
                                    cube[(3*N + r)*N + c]  <= corr3[r*N + c];
                                    cube[(4*N + r)*N + c]  <= corr4[r*N + c];
                                    cube[(5*N + r)*N + c]  <= corr5[r*N + c];
                                    cube[(6*N + r)*N + c]  <= corr6[r*N + c];
                                    cube[(7*N + r)*N + c]  <= corr7[r*N + c];
                                    cube[(8*N + r)*N + c]  <= corr8[r*N + c];
                                    cube[(9*N + r)*N + c]  <= corr9[r*N + c];
                                    cube[(10*N + r)*N + c] <= corr10[r*N + c];
                                    cube[(11*N + r)*N + c] <= corr11[r*N + c];
                                    cube[(12*N + r)*N + c] <= corr12[r*N + c];
                                    cube[(13*N + r)*N + c] <= corr13[r*N + c];
                                    cube[(14*N + r)*N + c] <= corr14[r*N + c];
                                end
                            endcase
                        end
                    end
                    state <= NEXT;
                end

                NEXT : begin
                    if(pass_idx != 2) begin
                        pass_idx <= pass_idx + 1;
                        state <= LOAD;
                    end
                    else if(sweep_dirty == 0) begin
                        done_3d <= 1;
                        state <= IDLE;
                    end
                    else if(iters == MAX_ITER - 1) begin
                        fail_3d <= 1;
                        done_3d <= 1;
                        state <= IDLE;
                    end
                    else begin
                        iters <= iters + 1;
                        sweep_dirty <= 0;
                        pass_idx <= 0;
                        state <= SEND;
                    end
                end
            endcase
        end
    end

endmodule