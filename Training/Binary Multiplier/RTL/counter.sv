module counter (input clk, reset, output logic [2:0] out);

always_ff @(posedge clk)
begin
    if (reset)
    begin
        out <= 0;
    end
    else
    begin
        out <= out + 1;
    end
end

endmodule