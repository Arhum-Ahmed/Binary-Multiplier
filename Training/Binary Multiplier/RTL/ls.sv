module ls (input logic [9:0] a, input logic [2:0] b, output logic [9:0] out);

always_comb
begin
    out = a << b;
end

endmodule