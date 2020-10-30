///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(SMC_scoreboard)

	uvm_tlm_analysis_fifo #(SMC_pulse_compare) in_fifo;
	SMC_pulse_compare in;

	uvm_tlm_analysis_fifo #(reg) in_pulse;
	reg pulse;

	reg lastreg, lastlastreg;
	realtime first_neg, first_pos, second_neg, second_pos;
	realtime last_in;

	function new(string name= "SMC_scoreboard", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		in_pulse = new("in_pulse", this);
		in = new();
		lastreg = 0;
		lastlastreg = 0;
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_pulse.get(pulse);
			in_fifo.get(in);
			if(in.first_neg != last_in) begin
				first_neg = 0;
				first_pos = 0;
				second_neg = 0;
				second_pos = 0;
				if(lastreg) begin
					if(lastlastreg == 0) begin
						first_pos = $time - 10;
					end
				end
				else begin
					if(lastlastreg) begin
						first_neg = $time - 10;
					end
				end
			end
			if(in.first_neg == in.first_pos) begin
				if(pulse != in.start_signal) begin
					`uvm_error("ERROR", "STATIC");
				end
			end
			else begin
				if(pulse) begin
					if(lastreg == 0) begin
						if(first_pos == 0) first_pos = $time;
						else second_pos = $time;
					end
				end
				else begin
					if(lastreg) begin
						if(first_neg == 0) first_neg = $time;
						else second_neg = $time;
					end
				end
				if($time >= in.first_neg) begin
					if(in.first_neg != first_neg) `uvm_error("ERROR", "should have neg edge");
				end
				if($time >= in.first_pos) begin
					if(in.first_pos != first_pos) `uvm_error("ERROR", "should have pos edge");
				end
				if($time >= in.second_neg) begin
					if(in.second_neg != second_neg) `uvm_error("ERROR", "should have neg edge");
				end
				if($time >= in.second_pos) begin
					if(in.second_pos != second_pos) `uvm_error("ERROR", "should have pos edge");
				end
			end
			lastlastreg = lastreg;
			lastreg = pulse;
			last_in = in.first_neg;
		end
	endtask : run_phase
endclass : SMC_scoreboard