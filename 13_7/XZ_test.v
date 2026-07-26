module XZ_test;
    reg [3:0] a, b, c;
    reg [2:0] sel;
    wire [3:0] y_z;
    wire [3:0] y_x;

    
    casez_example z1 (
        .a(a), .b(b), .c(c),
        .sel(sel),
        .y(y_z)
    );

    casex_example x1 (
        .a(a), .b(b), .c(c),
        .sel(sel),
        .y(y_x)
    );

    initial begin
        $monitor("Time=%0t | sel=%b | a=%d, b=%d, c=%d | y_z=%b | y_x=%b", 
                 $time, sel, a, b, c, y_z, y_x);

        a = 1;   b = 2;  c = 3;  
        sel[2] = 1'b0;
        #20;
        sel =3'b000;
        #10;
        sel = 3'b011; 
        #10;
        sel = 3'b101; 
        #10;
        sel = 3'bx1x;
        #10;
        sel = 3'b10x; //
        #10;
        sel = 3'bz0z;
        #10;
        sel = 3'b111;
        #10;
        sel = 3'b11x;
        #10;
        sel = 3'b001;
        #10;
        sel = 3'b010;
        #10;
        sel = 3'b100;
        #10;
        sel = 3'b110;
        #10;

        $finish;
    end

endmodule