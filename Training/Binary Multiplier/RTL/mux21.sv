module mux21 (input logic [4:0] a, b, input logic sel, output logic [4:0] out);

    assign out = sel? a: b;

endmodule