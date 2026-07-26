module controller (
	input wire [2:0] opcode,
	input wire [2:0] phase,
	input wire zero,
	input wire in_a,
	input wire in_b,
	output reg alu_out,
	output reg sel,
	output reg rd,
	output reg ld_ir,
	output reg inc_pc,
	output reg halt,
	output reg ld_pc,
	output reg data_e,
	output reg ld_ac,
	output reg wr
);

always @(*) 

begin
	case (opcode)
	3'b000: alu_out = in_a; 	    //HLT
        3'b001: alu_out = in_a; 	    //SKZ
        3'b010: alu_out = in_a + in_b;  //ADD
        3'b011: alu_out = in_a & in_b;  //AND
        3'b100: alu_out = in_a ^ in_b;  //XOR
        3'b101: alu_out = in_b;         //LDA
        3'b110: alu_out = in_a;         //STO
        3'b111: alu_out = in_a;         //JMP
        default:alu_out = 0;
	endcase

	case (phase)
		3'b000: 
			begin
				sel = 1; 
				{rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
			end 	    
        3'b001:
        	begin
				{sel,rd} = 2'b11;
				{ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
			end
        3'b010:
        	begin
        		{sel,rd,ld_ir} = 3'b111;
				{halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
			end
        3'b011: 
        	begin
        		{sel,rd,ld_ir} = 3'b111;
				{halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
			end
        3'b100: 
        begin
        	{sel,rd,ld_ir,ld_ac,ld_pc,wr,data_e} = 0;
        	inc_pc = 1;
				if (opcode == 3'b000) 
					begin
						halt = 1;	
					end

					else
					begin
						halt = 0;
					end
			end
        3'b101:
        begin
        	{sel,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
        	if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) 
        		begin
        			rd = 1;
        		end
        	else
        		begin
       				rd = 0;
       			end

        end
        3'b110:
        begin
        	{sel,ld_ir,halt,ld_ac,wr} = 0;
        	if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) 
        		begin
        			rd = 1;
        		end
        	else
        		begin
       				rd = 0;
       			end
        	if (opcode == 3'b001 && zero ) 
        		begin
        			inc_pc = 1;
        		end
        	else
        		begin
       				inc_pc = 0;
       			end
        	if (opcode == 3'b111) 
        		begin
        			ld_pc = 1;
        		end
        	else
        		begin
       				ld_pc = 0;
       			end
        	if (opcode == 3'b110) 
        		begin
        			data_e = 1;
        		end
        	else
        		begin
       				data_e = 0;
       			end

        end
        3'b111:
        begin
        	{sel,ld_ir,halt,inc_pc} = 0;
        	if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) 
        		begin
        			rd = 1;
        		end
        	else
        		begin
       				rd = 0;
       			end
        	if (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101) 
        		begin
        			ld_ac = 1;
        		end
        	else
        		begin
       				ld_ac = 0;
       			end
        	if (opcode == 3'b111) 
        		begin
        			ld_pc = 1;
        		end
        	else
        		begin
       				ld_pc = 0;
       			end
        	if (opcode == 3'b110) 
        		begin
        			{data_e,wr} = 2'b11;
        		end
        	else
        		begin
       				{data_e,wr} = 2'b00;
       			end


        end
		default: {sel,rd,ld_ir,halt,inc_pc,ld_ac,ld_pc,wr,data_e} = 0;
		
	endcase



end








endmodule