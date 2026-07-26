`timescale 10ns / 10ps

module debouncer_tb;

    reg clk;
    reg reset;
    reg sw;
    wire db;

    
    debouncer db1 (
        .clk(clk), 
        .reset(reset), 
        .sw(sw), 
        .db(db)
    );

    
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        sw = 0;
        #25;
        reset = 0;
        #15;

        // 
        #400;
        //ripple
        sw = 1; 
        #30;       
        sw = 0; 
        #30;     
        sw = 1; 
        #30;       
        sw = 0; 
        #30;
        sw = 1; 
        #30;       
        sw = 0; 
        #30;     
        sw = 1; 
        #30;       
        sw = 0; 
        #30;
        sw = 1; 
        #3500;
        //ripple      
        sw = 0;
        #30       
        sw = 1;  
        #30;       
        sw = 0; 
        #30;     
        sw = 1; 
        #30;       
        sw = 0; 
        #30;      
        sw = 1;
        #30
        sw = 0;
        #500;      

        $display("test complete.");
        $finish;
    end
      
endmodule