///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_sequencer extends uvm_sequencer #(SMC_seqitem);
	`uvm_component_utils(SMC_sequencer)
	
	function new(string name = "SMC_sequencer", uvm_component parent = null);
		super.new(name,parent);
	endfunction: new

endclass: SMC_sequencer