`timescale 1ps/1ps

module TB;

    logic [4:0] op_a, op_b;
    logic load, clk, reset;
    logic [9:0] mul_out = 0, ans;

    int DURATION = 10000, i;


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
        
        op_a = $random;
        op_b = $random;
        reset = 0;
        @(posedge clk);
        load = 1;
        @(posedge clk);
        load = 0;
        repeat (7) @(posedge clk);
        
        assign ans = op_a * op_b;
        if (mul_out == ans )
        begin
            $display(" Success: op_a = %d, op_b = %d, ans = %d, mul_out = %d", op_a, op_b, ans, mul_out);
        end

        else 
        begin
            $display(" *ERROR:* op_a = %d, op_b = %d, ans = %d, mul_out = %d", op_a, op_b, ans, mul_out);
        end

        end
        $stop;

    end

endmodule
