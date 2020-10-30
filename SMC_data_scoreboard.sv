///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_data_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(SMC_data_scoreboard)

	uvm_tlm_analysis_fifo #(SMC_data) in_fifo;
	SMC_data in;

	uvm_tlm_analysis_fifo #(SMC_data) out_fifo;
	SMC_data out;

	function new(string name= "SMC_data_scoreboard", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		out_fifo = new("out_fifo", this);
		in = new();
		out = new();
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_fifo.get(in);
			out_fifo.get(out);
			case(in.addr)
        		7'h00: if(in.data[10:0] != out.data[10:0] || out.data[15:11] != 0) begin `uvm_error("DATA", "Period wrong") end
				7'h02: if(in.data[7] != out.data[7] || in.data[0] != out.data[0] || out.data[6:1] != 0) begin `uvm_error("DATA", "MCCTL1 wrong") end
				7'h03: if(out.data[7] != 0 || out.data[3] != 0 ||out.data[1] != 0 || in.data[6:4] != out.data[6:4] || in.data[2] != out.data[2]) begin `uvm_error("DATA", "MCCTL0 wrong") end
				7'h10: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC3 wrong") end
				7'h11: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC2 wrong") end
				7'h12: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC1 wrong") end
				7'h13: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC0 wrong") end
				7'h14: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC7 wrong") end
				7'h15: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC6 wrong") end
				7'h16: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC5 wrong") end
				7'h17: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC4 wrong") end
				7'h18: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC11 wrong") end
				7'h19: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC10 wrong") end
				7'h1A: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC9 wrong") end
				7'h1B: if(in.data[7:4] != out.data[7:4] || in.data[1:0] != out.data[1:0] || out.data[3:2] != 0) begin `uvm_error("DATA", "MCCC8 wrong") end
				7'h20: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC1 wrong") end
				7'h22: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC0 wrong") end
				7'h24: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC3 wrong") end
				7'h26: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC2 wrong") end
				7'h28: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC5 wrong") end
				7'h2A: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC4 wrong") end
				7'h2C: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC7 wrong") end
				7'h2E: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC6 wrong") end
				7'h30: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC9 wrong") end
				7'h32: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC8 wrong") end
				7'h34: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC11 wrong") end
				7'h36: if(in.data[10:0] != out.data[10:0] || in.data[15] != out.data[15] || out.data[15] != out.data[14] || out.data[14] != out.data[13] || out.data[15:13] != out.data[13:11]) begin `uvm_error("DATA", "MCDC10 wrong") end
			endcase
			
		end
	endtask : run_phase
endclass : SMC_data_scoreboard