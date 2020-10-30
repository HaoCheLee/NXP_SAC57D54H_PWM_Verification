///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_pulse_process extends uvm_scoreboard;
	`uvm_component_utils(SMC_pulse_process)

	uvm_tlm_analysis_fifo #(SMC_pulse_info) in_fifo;
	SMC_pulse_info in;

	uvm_analysis_port #(SMC_pulse_compare) out_pulse;
	SMC_pulse_compare pulse;

	function new(string name="SMC_pulse_process", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		out_pulse = new("out_pulse", this);
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_fifo.get(in);
			pulse = new();
			if(in.shut_off) begin
				pulse.first_neg = 0;
				pulse.first_pos = 0;
				pulse.second_neg = 0;
				pulse.second_pos = 0;
				pulse.start_signal = 0;
				pulse.expect_per = 0;
			end
			else begin
				if(in.always_low) begin
					pulse.first_neg = 0;
					pulse.first_pos = 0;
					pulse.second_neg = 0;
					pulse.second_pos = 0;
					pulse.start_signal = 0;
					pulse.expect_per = 0;
				end
				else if(in.always_high) begin
					pulse.first_neg = 0;
					pulse.first_pos = 0;
					pulse.second_neg = 0;
					pulse.second_pos = 0;
					pulse.start_signal = 1;
					pulse.expect_per = 0;
				end
				else begin
					pulse.expect_per = in.per*10;
					if(in.active) begin
						if(in.start_time) pulse.start_signal = 0;
						else pulse.start_signal = 1;
						pulse.first_pos = in.start_time;
						pulse.first_neg = in.start_time + in.pulse_width*10;
						pulse.second_pos = in.start_time + in.per*10;
						pulse.second_neg = in.start_time + (in.pulse_width + in.per)*10;
						if(in.odd_dither) begin
							pulse.second_neg = pulse.second_neg + 10*in.mcpre;
						end
					end
					else begin
						if(in.start_time) pulse.start_signal = 1;
						else pulse.start_signal = 0;
						pulse.first_neg = in.start_time;
						pulse.first_pos = in.start_time + in.pulse_width*10;
						pulse.second_neg = in.start_time + in.per*10;
						pulse.second_pos = in.start_time + (in.pulse_width + in.per)*10;
						if(in.odd_dither) begin
							pulse.second_pos = pulse.second_pos + 10*in.mcpre;
						end
					end
				end
			end
			if(pulse.first_neg == 0) pulse.from_start = 1;
			if(pulse.first_pos == 0) pulse.from_start = 1;
			pulse.first_neg = pulse.first_neg + $time;
			pulse.first_pos = pulse.first_pos + $time;
			pulse.second_neg = pulse.second_neg + $time;
			pulse.second_pos = pulse.second_pos + $time;
			//$display("fn = %t, fp = %t, sn = %t, sp = %t",pulse.first_neg,pulse.first_pos,pulse.second_neg,pulse.second_pos);
			out_pulse.write(pulse);
		end
	endtask : run_phase
endclass : SMC_pulse_process