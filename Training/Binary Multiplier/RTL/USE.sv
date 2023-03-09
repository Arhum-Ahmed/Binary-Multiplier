module USE (input logic [4:0] in, output logic [9:0] out);

always_comb
begin 
    out [4:0] = in;
    out [9:5] = { 5{ 0 } };
end

endmodule