///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_checker extends uvm_monitor;
	`uvm_component_utils(SMC_checker)
	
	virtual SMC_if vif;

	reg [11:0] m;
	
	function new(string name="SMC_checker", uvm_component parent);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m = 0;
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC CKR:NOVIF","virtual interface not successful")
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		 forever begin
            @(posedge vif.Checker.clk);
            	$display("Now popping ", $time());
            	vif.Checker.mnm		<= m;
				vif.Checker.mnp		<= 1;
				m = ~m;
		end
	endtask: run_phase
endclass: SMC_checker