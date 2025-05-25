module comparetor (input logic [15:0] in0,in1, input logic asc,output logic [15:0] out0, out1);

    logic out_comp, f_h;
    assign out_comp = in0 < in1;
    assign f_h = asc ^ out_comp;
    assign out0 = f_h ? in1 : in0;
    assign out1 = f_h ? in0 : in1;

endmodule
