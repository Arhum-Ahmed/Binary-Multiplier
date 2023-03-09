module mux51 (input logic [4:0] a, input logic [2:0] sel, output logic out);

    always_comb
    begin
        case(sel)
     
        3'b000 : out = a[0];
        3'b001 : out = a[1];
        3'b010 : out = a[2];
        3'b011 : out = a[3];
        3'b100 : out = a[4];
        
        default : out = 0;
        
        endcase
    end

endmodule