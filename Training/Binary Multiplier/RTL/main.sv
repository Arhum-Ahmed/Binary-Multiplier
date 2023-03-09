module main (input logic [4:0] op_a, op_b, input logic load, clk, reset, output logic [9:0] mul_out);

    logic en_a, en_b, m2o, compo, clr_ans, clr_count, wr;
    logic [2:0] counto;
    logic [4:0] rego_a, rego_b, m1o;
    logic [9:0] ans_in, lso, useo;
    
    reg_in Reg_A (.reg_in(op_a), .reset(reset) , .clk(clk), .en(en_a), .reg_out(rego_a));
    reg_in Reg_B (.reg_in(op_b), .reset(reset) , .clk(clk), .en(en_b), .reg_out(rego_b));
    mux21 M2 (.a(rego_a), .b(5'b00000), .sel(m2o), .out(m1o));
    mux51 M5 (.a(rego_b), .sel(counto), .out(m2o));
    USE us (.in(m1o), .out(useo));
    ls LS (.a(useo), .b(counto), .out(lso));
    adder ADD (.a(mul_out), .b(lso), .out(ans_in));
    reg_out REG_O (.in(ans_in), .clk(clk), .reset(clr_ans), .wr(wr), .out(mul_out));
    counter COUNT (.clk(clk), .reset(clr_count), .out(counto));
    comp COMP (.a(counto), .b(3'd5), .out(compo));
    ctrl CTRL (.load(load), .reset(reset), .count_b(compo),.clk(clk), .en_a(en_a), .en_b(en_b), .clr_ans(clr_ans), .clr_count(clr_count), .wr(wr));

endmodule