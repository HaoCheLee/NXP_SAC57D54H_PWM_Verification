///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_sender extends uvm_scoreboard;
	`uvm_component_utils(SMC_sender)
	
	uvm_tlm_analysis_fifo #(SMC_pulse_compare) in_fifo;
	SMC_pulse_compare in;

	uvm_analysis_port #(SMC_pulse_compare) out_pulse;

	virtual SMC_if vif;
	
	function new(string name="SMC_sender", uvm_component parent);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		in_fifo = new("in_fifo", this);
		out_pulse = new("out_pulse", this);
		in = new();
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC SEN:NOVIF","virtual interface not successful")
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		 forever begin
            @(posedge vif.sen.clk);
            fork
            	in_fifo.get(in);
            join_none
            	out_pulse.write(in);
		end
	endtask: run_phase
endclass: SMC_sender