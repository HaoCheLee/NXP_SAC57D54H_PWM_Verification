///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
import uvm_pkg::*;
`include "SMC_if.sv"
`include "SMC_seqitem.sv"
`include "SMC_sequence.sv"
`include "SMC_sequencer.sv"
`include "SMC_driver.sv"
`include "SMC_mon.sv"
`include "SMC_mon2pulse.sv"
`include "SMC_pulse.sv"
`include "SMC_pulse_generate.sv"
`include "SMC_pulse_process.sv"
`include "SMC_agent.sv"
`include "SMC_mon_op.sv"
`include "SMC_scoreboard.sv"
`include "SMC_data_scoreboard.sv"
`include "SMC_sender.sv"
`include "SMC_environment.sv"
`include "SMC_test.sv"




module top();

	SMC_if intf();

	initial begin
		intf.clk = 1;
		forever #5 intf.clk = ~intf.clk;
	end

	initial begin
		uvm_config_db #(virtual SMC_if)::set(null, "*", "vif", intf);
		run_test("SMC_test");
	end

endmodule : top