`timescale 1ps/1ps

    logic [4:0] op_a, op_b;
    logic [9:0] mul_out = 0, ref_mult;

function byte mult (input int a, b);
    
    return a*b;

endfunction

task driver(output logic [4:0] op_a, op_b);
    begin
        op_a = $random;
        op_b = $random;
    end
endtask

task monitor(input logic [7:0] mul_out, ref_mult);
    begin
        if (mul_out == ref_mult )
        begin
            $display(" Success: op_a = %d, op_b = %d, ref_mult = %d, mul_out = %d", op_a, op_b, ref_mult, mul_out);
        end

        else 
        begin
            $display(" *ERROR:* op_a = %d, op_b = %d, ref_mult = %d, mul_out = %d", op_a, op_b, ref_mult, mul_out);
        end
    end
endtask

module TB;

    logic load, clk, reset;
    int DURATION = 100, i;

    main DUT (op_a, op_b, load, clk, reset, mul_out);

    initial 
    begin
        clk = 0;
        forever 
        #5
        clk = ~clk;
    end
    
    
    initial 
    begin  
        
        reset = 1;
        @(posedge clk);
        reset = 0;
        
        DUT.en_a = 0; DUT.en_b = 0; DUT.clr_ans = 0; DUT.clr_count = 0; DUT.wr = 0;
        DUT.counto = 0; DUT.rego_a = 0; DUT.rego_b = 0; DUT.ans_in = 0;
        DUT.lso = 0; DUT.mul_out = 0; 

        for (i = 0; i < DURATION; i++)
        begin
            load = 1;

            fork
                driver( .op_a(op_a), .op_b(op_b) );
                #10 load = 0;
                ref_mult = mult ( .a(op_a), .b(op_b) );
                #80 monitor( .mul_out(mul_out), .ref_mult(ref_mult) );
            join
        end

        $stop;

    end

endmodule
