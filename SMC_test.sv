///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_test extends uvm_test;
	`uvm_component_utils(SMC_test)
	
	virtual SMC_if vif;
	SMC_environment env;

	function new(string name = "SMC_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = SMC_environment::type_id::create("env", this);
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC TEST:NOVIF","virtual interface not successful")
        uvm_config_db#(virtual SMC_if)::set(this, "env", "vif", vif);
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		SMC_sequence message;
		phase.raise_objection(this, "Starting sequence main phase");
		message = SMC_sequence::type_id::create("message");
		message.start(env.agt.sqr);
		phase.drop_objection(this , "Finished sequence in main phase");

	endtask: run_phase
	
endclass: SMC_test