///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_sequence extends uvm_sequence #(SMC_seqitem);
	`uvm_object_utils(SMC_sequence)

	function new(string name = "SMC_sequence");
		super.new();
	endfunction : new

	task body();
		SMC_seqitem message;
		message = SMC_seqitem::type_id::create("SMC_seqitem");

		repeat(1) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{
				message.ctlreg[0][10:0] == 10;
				message.ctlreg[2][2] == 1;
				message.ctlreg[2][6:5] == 2'b00;
				message.ctlreg[15][10:0] == 5;
				message.ctlreg[16][10:0] == 5;
				message.ctlreg[17][10:0] == 5;
				message.ctlreg[18][10:0] == 5;
				message.ctlreg[19][10:0] == 5;
				message.ctlreg[20][10:0] == 5;
				message.ctlreg[21][10:0] == 3;
				message.ctlreg[22][10:0] == 3;
				message.ctlreg[23][10:0] == 3;
				message.ctlreg[24][10:0] == 3;
				message.ctlreg[25][10:0] == 3;
				message.ctlreg[26][10:0] == 3;
				message.ctlreg[3][7:0] == 8'h10;
				message.ctlreg[4][7:0] == 8'h10;
				message.ctlreg[5][7:0] == 8'h10;
				message.ctlreg[6][7:0] == 8'h10;
				message.ctlreg[7][7:0] == 8'h10;
				message.ctlreg[8][7:0] == 8'h10;
				message.ctlreg[9][7:0] == 8'h10;
				message.ctlreg[10][7:0] == 8'h10;
				message.ctlreg[11][7:0] == 8'h10;
				message.ctlreg[12][7:0] == 8'h10;
				message.ctlreg[13][7:0] == 8'h10;
				message.ctlreg[14][7:0] == 8'h10;
				});
			finish_item(message);
		end

		repeat(10) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{
				message.ctlreg[15][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[16][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[17][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[18][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[19][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[20][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[21][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[22][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[23][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[24][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[25][10:0] < message.ctlreg[0][10:0];
				message.ctlreg[26][10:0] < message.ctlreg[0][10:0];
				});
			finish_item(message);
		end
/*
		repeat(1) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{message.ctlreg[0][10:0] == 10;message.ctlreg[16][10:0] == 3;message.ctlreg[6][7:0] == 8'h10;message.ctlreg[2][2] == 1;message.ctlreg[2][6:5] == 2'b00;});
			finish_item(message);
		end
		
		repeat(1) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{message.ctlreg[0][10:0] == 10;message.ctlreg[16][10:0] == 3;message.ctlreg[6][7:0] == 8'h10;message.ctlreg[2][2] == 1;message.ctlreg[2][6:5] == 2'b00;});
			finish_item(message);
		end
		repeat(1) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{message.ctlreg[0][10:0] == 10;message.ctlreg[16][10:0] == 3;message.ctlreg[6][7:0] == 8'h10;message.ctlreg[2][2] == 1;message.ctlreg[2][6:5] == 2'b00;});
			finish_item(message);
		end
		repeat(1) begin
			start_item(message);
			message.write = 1;
			assert(message.randomize() with{message.ctlreg[0][10:0] == 10;message.ctlreg[16][10:0] == 3;message.ctlreg[6][7:0] == 8'h10;message.ctlreg[2][2] == 1;message.ctlreg[2][6:5] == 2'b00;});
			finish_item(message);
		end
		*/


	endtask : body
endclass : SMC_sequence