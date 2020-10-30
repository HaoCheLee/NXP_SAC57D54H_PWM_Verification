///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_pulse extends uvm_scoreboard;
	`uvm_component_utils(SMC_pulse)

	uvm_tlm_analysis_fifo #(SMC_pulseitem) in_fifo;
	SMC_pulseitem in;

	uvm_analysis_port #(SMC_single_pulse) out_pulse0;
	uvm_analysis_port #(SMC_single_pulse) out_pulse1;
	uvm_analysis_port #(SMC_single_pulse) out_pulse2;
	uvm_analysis_port #(SMC_single_pulse) out_pulse3;
	SMC_single_pulse pulse0, pulse1, pulse2, pulse3;

	function new(string name="SMC_pulse", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		out_pulse0 = new("out_pulse0", this);
		out_pulse1 = new("out_pulse1", this);
		out_pulse2 = new("out_pulse2", this);
		out_pulse3 = new("out_pulse3", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_fifo.get(in);
			pulse0 = new(in, 0);
			pulse1 = new(in, 1);
			pulse2 = new(in, 2);
			pulse3 = new(in, 3);
			case (pulse0.mcom)
				2'b10: begin
					if(pulse1.mcom == 2'b11) pulse1.mcom = 2'b10;
				end
				2'b11: begin
					if(pulse1.mcom != 2'b11) pulse0.mcom = 2'b10;
				end
			endcase
			case (pulse2.mcom)
				2'b10: begin
					if(pulse3.mcom == 2'b11) pulse3.mcom = 2'b10;
				end
				2'b11: begin
					if(pulse3.mcom != 2'b11) pulse2.mcom = 2'b10;
				end
			endcase
			out_pulse0.write(pulse0);
			out_pulse1.write(pulse1);
			out_pulse2.write(pulse2);
			out_pulse3.write(pulse3);
		end
	endtask : run_phase
endclass : SMC_pulse