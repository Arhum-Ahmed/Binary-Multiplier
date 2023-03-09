module adder (input logic [9:0] a, b, output logic [9:0] out);

always_comb
begin
    out = a + b;
end

endmodule