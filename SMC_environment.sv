///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_environment extends uvm_env;
	`uvm_component_utils(SMC_environment)

	virtual SMC_if vif;

	SMC_sender sen_m0, sen_m1, sen_m2, sen_m3, sen_m4, sen_m5, sen_m6, sen_m7, sen_m8, sen_m9, sen_m10, sen_m11;
	SMC_sender sen_p0, sen_p1, sen_p2, sen_p3, sen_p4, sen_p5, sen_p6, sen_p7, sen_p8, sen_p9, sen_p10, sen_p11;

	SMC_agent agt;
	SMC_mon_op mon_op;
	SMC_scoreboard scb_m0, scb_m1, scb_m2, scb_m3, scb_m4, scb_m5, scb_m6, scb_m7, scb_m8, scb_m9, scb_m10, scb_m11;
	SMC_scoreboard scb_p0, scb_p1, scb_p2, scb_p3, scb_p4, scb_p5, scb_p6, scb_p7, scb_p8, scb_p9, scb_p10, scb_p11;

	SMC_data_scoreboard data_scb;

	function new(string name = "SMC_environment", uvm_component parent = null);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		data_scb = SMC_data_scoreboard::type_id::create("data_scb", this);
		sen_m0 = SMC_sender::type_id::create("sen_m0", this);
		sen_p0 = SMC_sender::type_id::create("sen_p0", this);
		sen_m1 = SMC_sender::type_id::create("sen_m1", this);
		sen_p1 = SMC_sender::type_id::create("sen_p1", this);
		sen_m2 = SMC_sender::type_id::create("sen_m2", this);
		sen_p2 = SMC_sender::type_id::create("sen_p2", this);
		sen_m3 = SMC_sender::type_id::create("sen_m3", this);
		sen_p3 = SMC_sender::type_id::create("sen_p3", this);
		sen_m4 = SMC_sender::type_id::create("sen_m4", this);
		sen_p4 = SMC_sender::type_id::create("sen_p4", this);
		sen_m5 = SMC_sender::type_id::create("sen_m5", this);
		sen_p5 = SMC_sender::type_id::create("sen_p5", this);
		sen_m6 = SMC_sender::type_id::create("sen_m6", this);
		sen_p6 = SMC_sender::type_id::create("sen_p6", this);
		sen_m7 = SMC_sender::type_id::create("sen_m7", this);
		sen_p7 = SMC_sender::type_id::create("sen_p7", this);
		sen_m8 = SMC_sender::type_id::create("sen_m8", this);
		sen_p8 = SMC_sender::type_id::create("sen_p8", this);
		sen_m9 = SMC_sender::type_id::create("sen_m9", this);
		sen_p9 = SMC_sender::type_id::create("sen_p9", this);
		sen_m10 = SMC_sender::type_id::create("sen_m10", this);
		sen_p10 = SMC_sender::type_id::create("sen_p10", this);
		sen_m11 = SMC_sender::type_id::create("sen_m11", this);
		sen_p11 = SMC_sender::type_id::create("sen_p11", this);

		agt = SMC_agent::type_id::create("agt", this);
		mon_op = SMC_mon_op::type_id::create("mon_op", this);
		scb_m0 = SMC_scoreboard::type_id::create("scb_m0", this);
		scb_p0 = SMC_scoreboard::type_id::create("scb_p0", this);
		scb_m1 = SMC_scoreboard::type_id::create("scb_m1", this);
		scb_p1 = SMC_scoreboard::type_id::create("scb_p1", this);
		scb_m2 = SMC_scoreboard::type_id::create("scb_m2", this);
		scb_p2 = SMC_scoreboard::type_id::create("scb_p2", this);
		scb_m3 = SMC_scoreboard::type_id::create("scb_m3", this);
		scb_p3 = SMC_scoreboard::type_id::create("scb_p3", this);
		scb_m4 = SMC_scoreboard::type_id::create("scb_m4", this);
		scb_p4 = SMC_scoreboard::type_id::create("scb_p4", this);
		scb_m5 = SMC_scoreboard::type_id::create("scb_m5", this);
		scb_p5 = SMC_scoreboard::type_id::create("scb_p5", this);
		scb_m6 = SMC_scoreboard::type_id::create("scb_m6", this);
		scb_p6 = SMC_scoreboard::type_id::create("scb_p6", this);
		scb_m7 = SMC_scoreboard::type_id::create("scb_m7", this);
		scb_p7 = SMC_scoreboard::type_id::create("scb_p7", this);
		scb_m8 = SMC_scoreboard::type_id::create("scb_m8", this);
		scb_p8 = SMC_scoreboard::type_id::create("scb_p8", this);
		scb_m9 = SMC_scoreboard::type_id::create("scb_m9", this);
		scb_p9 = SMC_scoreboard::type_id::create("scb_p9", this);
		scb_m10 = SMC_scoreboard::type_id::create("scb_m10", this);
		scb_p10 = SMC_scoreboard::type_id::create("scb_p10", this);
		scb_m11 = SMC_scoreboard::type_id::create("scb_m11", this);
		scb_p11 = SMC_scoreboard::type_id::create("scb_p11", this);
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC ENVIRONMENT:NOVIF","virtual interface not successful")
        uvm_config_db#(virtual SMC_if)::set(this, "agt", "vif", vif);
        uvm_config_db#(virtual SMC_if)::set(this, "mon_op", "vif", vif);
        uvm_config_db#(virtual SMC_if)::set(this, "sen", "vif", vif);

	endfunction: build_phase


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		agt.mon.data_out.connect(data_scb.in_fifo.analysis_export);
		mon_op.data_out.connect(data_scb.out_fifo.analysis_export);

		agt.pul_m0.out_pulse.connect(sen_m0.in_fifo.analysis_export);
		sen_m0.out_pulse.connect(scb_m0.in_fifo.analysis_export);
		mon_op.mnm_0.connect(scb_m0.in_pulse.analysis_export);

		agt.pul_p0.out_pulse.connect(sen_p0.in_fifo.analysis_export);
		sen_p0.out_pulse.connect(scb_p0.in_fifo.analysis_export);
		mon_op.mnp_0.connect(scb_p0.in_pulse.analysis_export);

		agt.pul_m1.out_pulse.connect(sen_m1.in_fifo.analysis_export);
		sen_m1.out_pulse.connect(scb_m1.in_fifo.analysis_export);
		mon_op.mnm_1.connect(scb_m1.in_pulse.analysis_export);

		agt.pul_p1.out_pulse.connect(sen_p1.in_fifo.analysis_export);
		sen_p1.out_pulse.connect(scb_p1.in_fifo.analysis_export);
		mon_op.mnp_1.connect(scb_p1.in_pulse.analysis_export);

		agt.pul_m2.out_pulse.connect(sen_m2.in_fifo.analysis_export);
		sen_m2.out_pulse.connect(scb_m2.in_fifo.analysis_export);
		mon_op.mnm_2.connect(scb_m2.in_pulse.analysis_export);

		agt.pul_p2.out_pulse.connect(sen_p2.in_fifo.analysis_export);
		sen_p2.out_pulse.connect(scb_p2.in_fifo.analysis_export);
		mon_op.mnp_2.connect(scb_p2.in_pulse.analysis_export);

		agt.pul_m3.out_pulse.connect(sen_m3.in_fifo.analysis_export);
		sen_m3.out_pulse.connect(scb_m3.in_fifo.analysis_export);
		mon_op.mnm_3.connect(scb_m3.in_pulse.analysis_export);

		agt.pul_p3.out_pulse.connect(sen_p3.in_fifo.analysis_export);
		sen_p3.out_pulse.connect(scb_p3.in_fifo.analysis_export);
		mon_op.mnp_3.connect(scb_p3.in_pulse.analysis_export);

		agt.pul_m4.out_pulse.connect(sen_m4.in_fifo.analysis_export);
		sen_m4.out_pulse.connect(scb_m4.in_fifo.analysis_export);
		mon_op.mnm_4.connect(scb_m4.in_pulse.analysis_export);

		agt.pul_p4.out_pulse.connect(sen_p4.in_fifo.analysis_export);
		sen_p4.out_pulse.connect(scb_p4.in_fifo.analysis_export);
		mon_op.mnp_4.connect(scb_p4.in_pulse.analysis_export);

		agt.pul_m5.out_pulse.connect(sen_m5.in_fifo.analysis_export);
		sen_m5.out_pulse.connect(scb_m5.in_fifo.analysis_export);
		mon_op.mnm_5.connect(scb_m5.in_pulse.analysis_export);

		agt.pul_p5.out_pulse.connect(sen_p5.in_fifo.analysis_export);
		sen_p5.out_pulse.connect(scb_p5.in_fifo.analysis_export);
		mon_op.mnp_5.connect(scb_p5.in_pulse.analysis_export);

		agt.pul_m6.out_pulse.connect(sen_m6.in_fifo.analysis_export);
		sen_m6.out_pulse.connect(scb_m6.in_fifo.analysis_export);
		mon_op.mnm_6.connect(scb_m6.in_pulse.analysis_export);

		agt.pul_p6.out_pulse.connect(sen_p6.in_fifo.analysis_export);
		sen_p6.out_pulse.connect(scb_p6.in_fifo.analysis_export);
		mon_op.mnp_6.connect(scb_p6.in_pulse.analysis_export);

		agt.pul_m7.out_pulse.connect(sen_m7.in_fifo.analysis_export);
		sen_m7.out_pulse.connect(scb_m7.in_fifo.analysis_export);
		mon_op.mnm_7.connect(scb_m7.in_pulse.analysis_export);

		agt.pul_p7.out_pulse.connect(sen_p7.in_fifo.analysis_export);
		sen_p7.out_pulse.connect(scb_p7.in_fifo.analysis_export);
		mon_op.mnp_7.connect(scb_p7.in_pulse.analysis_export);

		agt.pul_m8.out_pulse.connect(sen_m8.in_fifo.analysis_export);
		sen_m8.out_pulse.connect(scb_m8.in_fifo.analysis_export);
		mon_op.mnm_8.connect(scb_m8.in_pulse.analysis_export);

		agt.pul_p8.out_pulse.connect(sen_p8.in_fifo.analysis_export);
		sen_p8.out_pulse.connect(scb_p8.in_fifo.analysis_export);
		mon_op.mnp_8.connect(scb_p8.in_pulse.analysis_export);

		agt.pul_m9.out_pulse.connect(sen_m9.in_fifo.analysis_export);
		sen_m9.out_pulse.connect(scb_m9.in_fifo.analysis_export);
		mon_op.mnm_9.connect(scb_m9.in_pulse.analysis_export);

		agt.pul_p9.out_pulse.connect(sen_p9.in_fifo.analysis_export);
		sen_p9.out_pulse.connect(scb_p9.in_fifo.analysis_export);
		mon_op.mnp_9.connect(scb_p9.in_pulse.analysis_export);

		agt.pul_m10.out_pulse.connect(sen_m10.in_fifo.analysis_export);
		sen_m10.out_pulse.connect(scb_m10.in_fifo.analysis_export);
		mon_op.mnm_10.connect(scb_m10.in_pulse.analysis_export);

		agt.pul_p10.out_pulse.connect(sen_p10.in_fifo.analysis_export);
		sen_p10.out_pulse.connect(scb_p10.in_fifo.analysis_export);
		mon_op.mnp_10.connect(scb_p10.in_pulse.analysis_export);

		agt.pul_m11.out_pulse.connect(sen_m11.in_fifo.analysis_export);
		sen_m11.out_pulse.connect(scb_m11.in_fifo.analysis_export);
		mon_op.mnm_11.connect(scb_m11.in_pulse.analysis_export);

		agt.pul_p11.out_pulse.connect(sen_p11.in_fifo.analysis_export);
		sen_p11.out_pulse.connect(scb_p11.in_fifo.analysis_export);
		mon_op.mnp_11.connect(scb_p11.in_pulse.analysis_export);
	endfunction: connect_phase
endclass : SMC_environment