module ctrl(input logic load, reset, count_b, clk, output logic en_a, en_b, clr_ans, clr_count, wr);

    localparam s0 = 1'b0;
    localparam s1 = 1'b1;

    logic cs, ns;

    always_ff @(posedge clk)
    begin
        if(reset)
        begin
            cs <= s0;
        end
        else
            cs <= ns;
    end

    // CS
    always_comb
    begin
        case(cs)
        s0 : if (~load)
             begin 
                clr_count = 1; 
                clr_ans = 0;
                en_a = 0;
                en_b = 0;
                wr = 0;
             end
             else if (load)
             begin
                clr_count = 1; 
                clr_ans = 1;
                en_a = 1;
                en_b = 1;
                wr = 0;
             end

        s1 : if (~count_b)
             begin 
                clr_count = 0; 
                clr_ans = 0;
                en_a = 0;
                en_b = 0;
                wr = 1;
             end
             else if (count_b)
             begin
                clr_count = 1; 
                clr_ans = 0;
                en_a = 0;
                en_b = 0;
                wr = 0;
             end
        endcase
    end


    always_comb
        begin
            case(cs)
            s0 : if (~load)
                 begin 
                    ns = s0;
                 end
                 else if (load)
                 begin
                    ns = s1;
                 end
    
            s1 : if (~count_b)
                 begin 
                    ns = s1;
                 end
                 else if (count_b)
                 begin
                    ns = s0;
                 end
            endcase
        end
endmodule
