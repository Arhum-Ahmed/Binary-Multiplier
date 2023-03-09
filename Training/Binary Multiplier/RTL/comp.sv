module comp (input logic [2:0] a, b, output logic out);

always_comb
begin
    if(a == b)
    begin
        out = 1;
    end
    else
    begin
        out = 0;
    end
end

endmodule