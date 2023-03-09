module reg_out (input logic [9:0] in, input logic clk, reset,wr, output logic [9:0] out);

always_ff @(posedge clk)
begin
    if (reset)
    begin
        out <= 0;
    end
    else
    begin
        if (wr)
        begin
            out <= in;
        end
    end
end

endmodule