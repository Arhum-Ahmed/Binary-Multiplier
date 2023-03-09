module reg_in (input logic [4:0] reg_in, input logic reset ,clk, en, output logic [4:0] reg_out);

always_ff @(posedge clk)
begin
    if (reset)
    begin
        reg_out <= 0;
    end
    else
    begin
        if (en)
        begin
            reg_out <= reg_in;
        end
    end
end

endmodule