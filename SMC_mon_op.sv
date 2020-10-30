///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_mon_op extends uvm_monitor;
	`uvm_component_utils(SMC_mon_op)

	uvm_analysis_port #(SMC_data) data_out;
	SMC_data data;

	uvm_analysis_port #(reg) mnm_0;
	uvm_analysis_port #(reg) mnm_1;
	uvm_analysis_port #(reg) mnm_2;
	uvm_analysis_port #(reg) mnm_3;
	uvm_analysis_port #(reg) mnm_4;
	uvm_analysis_port #(reg) mnm_5;
	uvm_analysis_port #(reg) mnm_6;
	uvm_analysis_port #(reg) mnm_7;
	uvm_analysis_port #(reg) mnm_8;
	uvm_analysis_port #(reg) mnm_9;
	uvm_analysis_port #(reg) mnm_10;
	uvm_analysis_port #(reg) mnm_11;
	uvm_analysis_port #(reg) mnp_0;
	uvm_analysis_port #(reg) mnp_1;
	uvm_analysis_port #(reg) mnp_2;
	uvm_analysis_port #(reg) mnp_3;
	uvm_analysis_port #(reg) mnp_4;
	uvm_analysis_port #(reg) mnp_5;
	uvm_analysis_port #(reg) mnp_6;
	uvm_analysis_port #(reg) mnp_7;
	uvm_analysis_port #(reg) mnp_8;
	uvm_analysis_port #(reg) mnp_9;
	uvm_analysis_port #(reg) mnp_10;
	uvm_analysis_port #(reg) mnp_11;

	virtual SMC_if vif;
	
	function new(string name="SMC_mon_op", uvm_component parent);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		data_out = new("data_out", this);
		data = new();
		mnm_0 = new("mnm_0", this);
		mnm_1 = new("mnm_1", this);
		mnm_2 = new("mnm_2", this);
		mnm_3 = new("mnm_3", this);
		mnm_4 = new("mnm_4", this);
		mnm_5 = new("mnm_5", this);
		mnm_6 = new("mnm_6", this);
		mnm_7 = new("mnm_7", this);
		mnm_8 = new("mnm_8", this);
		mnm_9 = new("mnm_9", this);
		mnm_10 = new("mnm_10", this);
		mnm_11 = new("mnm_11", this);
		mnp_0 = new("mnp_0", this);
		mnp_1 = new("mnp_1", this);
		mnp_2 = new("mnp_2", this);
		mnp_3 = new("mnp_3", this);
		mnp_4 = new("mnp_4", this);
		mnp_5 = new("mnp_5", this);
		mnp_6 = new("mnp_6", this);
		mnp_7 = new("mnp_7", this);
		mnp_8 = new("mnp_8", this);
		mnp_9 = new("mnp_9", this);
		mnp_10 = new("mnp_10", this);
		mnp_11 = new("mnp_11", this);
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC MON_OP:NOVIF","virtual interface not successful")
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		 forever begin
            @(posedge vif.mon_op.clk);
            data.data = vif.mon_op.dataout;
			data_out.write(data);
			mnm_0.write(vif.mon_op.mnm[0]);
			mnm_1.write(vif.mon_op.mnm[1]);
			mnm_2.write(vif.mon_op.mnm[2]);
			mnm_3.write(vif.mon_op.mnm[3]);
			mnm_4.write(vif.mon_op.mnm[4]);
			mnm_5.write(vif.mon_op.mnm[5]);
			mnm_6.write(vif.mon_op.mnm[6]);
			mnm_7.write(vif.mon_op.mnm[7]);
			mnm_8.write(vif.mon_op.mnm[8]);
			mnm_9.write(vif.mon_op.mnm[9]);
			mnm_10.write(vif.mon_op.mnm[10]);
			mnm_11.write(vif.mon_op.mnm[11]);
			mnp_0.write(vif.mon_op.mnp[0]);
			mnp_1.write(vif.mon_op.mnp[1]);
			mnp_2.write(vif.mon_op.mnp[2]);
			mnp_3.write(vif.mon_op.mnp[3]);
			mnp_4.write(vif.mon_op.mnp[4]);
			mnp_5.write(vif.mon_op.mnp[5]);
			mnp_6.write(vif.mon_op.mnp[6]);
			mnp_7.write(vif.mon_op.mnp[7]);
			mnp_8.write(vif.mon_op.mnp[8]);
			mnp_9.write(vif.mon_op.mnp[9]);
			mnp_10.write(vif.mon_op.mnp[10]);
			mnp_11.write(vif.mon_op.mnp[11]);
		end
	endtask: run_phase
endclass: SMC_mon_op