///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_agent extends uvm_agent;
	`uvm_component_utils(SMC_agent)

	virtual SMC_if vif;

	SMC_driver driver;
	SMC_sequencer sqr;
	SMC_mon mon;
	SMC_mon2pulse mon2p0, mon2p1, mon2p2;
	SMC_pulse pul0, pul1, pul2;
	SMC_pulse_generate pul_g0, pul_g1, pul_g2, pul_g3, pul_g4, pul_g5, pul_g6, pul_g7, pul_g8, pul_g9, pul_g10, pul_g11;
	SMC_pulse_process pul_m0, pul_m1, pul_m2, pul_m3, pul_m4, pul_m5, pul_m6, pul_m7, pul_m8, pul_m9, pul_m10, pul_m11;
	SMC_pulse_process pul_p0, pul_p1, pul_p2, pul_p3, pul_p4, pul_p5, pul_p6, pul_p7, pul_p8, pul_p9, pul_p10, pul_p11;

	function new(string name = "SMC_agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		driver = SMC_driver::type_id::create("driver",this);
		sqr = SMC_sequencer::type_id::create("sqr",this);
		mon = SMC_mon::type_id::create("mon",this);

		mon2p0 = SMC_mon2pulse::type_id::create("mon2p0", this);
		mon2p1 = SMC_mon2pulse::type_id::create("mon2p1", this);
		mon2p2 = SMC_mon2pulse::type_id::create("mon2p2", this);

		pul0 = SMC_pulse::type_id::create("pul0", this);
		pul1 = SMC_pulse::type_id::create("pul1", this);
		pul2 = SMC_pulse::type_id::create("pul2", this);

		pul_g0 = SMC_pulse_generate::type_id::create("pul_g0", this);
		pul_g1 = SMC_pulse_generate::type_id::create("pul_g1", this);
		pul_g2 = SMC_pulse_generate::type_id::create("pul_g2", this);
		pul_g3 = SMC_pulse_generate::type_id::create("pul_g3", this);
		pul_g4 = SMC_pulse_generate::type_id::create("pul_g4", this);
		pul_g5 = SMC_pulse_generate::type_id::create("pul_g5", this);
		pul_g6 = SMC_pulse_generate::type_id::create("pul_g6", this);
		pul_g7 = SMC_pulse_generate::type_id::create("pul_g7", this);
		pul_g8 = SMC_pulse_generate::type_id::create("pul_g8", this);
		pul_g9 = SMC_pulse_generate::type_id::create("pul_g9", this);
		pul_g10 = SMC_pulse_generate::type_id::create("pul_g10", this);
		pul_g11 = SMC_pulse_generate::type_id::create("pul_g11", this);

		pul_m0 = SMC_pulse_process::type_id::create("pul_m0", this);
		pul_m1 = SMC_pulse_process::type_id::create("pul_m1", this);
		pul_m2 = SMC_pulse_process::type_id::create("pul_m2", this);
		pul_m3 = SMC_pulse_process::type_id::create("pul_m3", this);
		pul_m4 = SMC_pulse_process::type_id::create("pul_m4", this);
		pul_m5 = SMC_pulse_process::type_id::create("pul_m5", this);
		pul_m6 = SMC_pulse_process::type_id::create("pul_m6", this);
		pul_m7 = SMC_pulse_process::type_id::create("pul_m7", this);
		pul_m8 = SMC_pulse_process::type_id::create("pul_m8", this);
		pul_m9 = SMC_pulse_process::type_id::create("pul_m9", this);
		pul_m10 = SMC_pulse_process::type_id::create("pul_m10", this);
		pul_m11 = SMC_pulse_process::type_id::create("pul_m11", this);

		pul_p0 = SMC_pulse_process::type_id::create("pul_p0", this);
		pul_p1 = SMC_pulse_process::type_id::create("pul_p1", this);
		pul_p2 = SMC_pulse_process::type_id::create("pul_p2", this);
		pul_p3 = SMC_pulse_process::type_id::create("pul_p3", this);
		pul_p4 = SMC_pulse_process::type_id::create("pul_p4", this);
		pul_p5 = SMC_pulse_process::type_id::create("pul_p5", this);
		pul_p6 = SMC_pulse_process::type_id::create("pul_p6", this);
		pul_p7 = SMC_pulse_process::type_id::create("pul_p7", this);
		pul_p8 = SMC_pulse_process::type_id::create("pul_p8", this);
		pul_p9 = SMC_pulse_process::type_id::create("pul_p9", this);
		pul_p10 = SMC_pulse_process::type_id::create("pul_p10", this);
		pul_p11 = SMC_pulse_process::type_id::create("pul_p11", this);

		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC AGENT:NOVIF","virtual interface not successful")
        uvm_config_db#(virtual SMC_if)::set(this, "driver", "vif", vif);
        uvm_config_db#(virtual SMC_if)::set(this, "mon", "vif", vif);
	endfunction: build_phase


	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver.seq_item_port.connect(sqr.seq_item_export);
		mon.mon_ap0.connect(mon2p0.in_fifo.analysis_export);
		mon.mon_ap1.connect(mon2p1.in_fifo.analysis_export);
		mon.mon_ap2.connect(mon2p2.in_fifo.analysis_export);

		mon2p0.pulse_info.connect(pul0.in_fifo.analysis_export);
		mon2p1.pulse_info.connect(pul1.in_fifo.analysis_export);
		mon2p2.pulse_info.connect(pul2.in_fifo.analysis_export);

		pul0.out_pulse0.connect(pul_g0.in_fifo.analysis_export);
		pul0.out_pulse1.connect(pul_g1.in_fifo.analysis_export);
		pul0.out_pulse2.connect(pul_g2.in_fifo.analysis_export);
		pul0.out_pulse3.connect(pul_g3.in_fifo.analysis_export);
		pul1.out_pulse0.connect(pul_g4.in_fifo.analysis_export);
		pul1.out_pulse1.connect(pul_g5.in_fifo.analysis_export);
		pul1.out_pulse2.connect(pul_g6.in_fifo.analysis_export);
		pul1.out_pulse3.connect(pul_g7.in_fifo.analysis_export);
		pul2.out_pulse0.connect(pul_g8.in_fifo.analysis_export);
		pul2.out_pulse1.connect(pul_g9.in_fifo.analysis_export);
		pul2.out_pulse2.connect(pul_g10.in_fifo.analysis_export);
		pul2.out_pulse3.connect(pul_g11.in_fifo.analysis_export);

		pul_g0.out_pulsem.connect(pul_m0.in_fifo.analysis_export);
		pul_g0.out_pulsep.connect(pul_p0.in_fifo.analysis_export);
		pul_g1.out_pulsem.connect(pul_m1.in_fifo.analysis_export);
		pul_g1.out_pulsep.connect(pul_p1.in_fifo.analysis_export);
		pul_g2.out_pulsem.connect(pul_m2.in_fifo.analysis_export);
		pul_g2.out_pulsep.connect(pul_p2.in_fifo.analysis_export);
		pul_g3.out_pulsem.connect(pul_m3.in_fifo.analysis_export);
		pul_g3.out_pulsep.connect(pul_p3.in_fifo.analysis_export);
		pul_g4.out_pulsem.connect(pul_m4.in_fifo.analysis_export);
		pul_g4.out_pulsep.connect(pul_p4.in_fifo.analysis_export);
		pul_g5.out_pulsem.connect(pul_m5.in_fifo.analysis_export);
		pul_g5.out_pulsep.connect(pul_p5.in_fifo.analysis_export);
		pul_g6.out_pulsem.connect(pul_m6.in_fifo.analysis_export);
		pul_g6.out_pulsep.connect(pul_p6.in_fifo.analysis_export);
		pul_g7.out_pulsem.connect(pul_m7.in_fifo.analysis_export);
		pul_g7.out_pulsep.connect(pul_p7.in_fifo.analysis_export);
		pul_g8.out_pulsem.connect(pul_m8.in_fifo.analysis_export);
		pul_g8.out_pulsep.connect(pul_p8.in_fifo.analysis_export);
		pul_g9.out_pulsem.connect(pul_m9.in_fifo.analysis_export);
		pul_g9.out_pulsep.connect(pul_p9.in_fifo.analysis_export);
		pul_g10.out_pulsem.connect(pul_m10.in_fifo.analysis_export);
		pul_g10.out_pulsep.connect(pul_p10.in_fifo.analysis_export);
		pul_g11.out_pulsem.connect(pul_m11.in_fifo.analysis_export);
		pul_g11.out_pulsep.connect(pul_p11.in_fifo.analysis_export);
	endfunction: connect_phase
endclass : SMC_agent