///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_seqitem extends uvm_sequence_item;
	`uvm_object_utils(SMC_seqitem)

	reg reset, write, sel;
	rand reg[15:0] ctlreg[26:0];

	function new(string name = "SMC_seqitem");
		super.new();
	endfunction : new

endclass : SMC_seqitem

class SMC_monitem;

	reg[15:0] ctlreg[10:0];
	reg sel;

	function new(reg[15:0] inreg[],reg s, int i);
		this.sel = s;
		this.ctlreg[0] = inreg[26];
		this.ctlreg[1] = inreg[25];
		this.ctlreg[2] = inreg[24];
		this.ctlreg[3] = inreg[23-i*4];
		this.ctlreg[4] = inreg[22-i*4];
		this.ctlreg[5] = inreg[21-i*4];
		this.ctlreg[6] = inreg[20-i*4];
		this.ctlreg[7] = inreg[11-i*4];
		this.ctlreg[8] = inreg[10-i*4];
		this.ctlreg[9] = inreg[9-i*4];
		this.ctlreg[10] = inreg[8-i*4];
	endfunction : new

endclass : SMC_monitem

class SMC_pulseitem;

	reg [10:0] per;
	reg recirc, mctoie, mchme, dith, mctoif;
	reg [3:0] mcpre;
	reg [1:0] mcom[3:0];
	reg [1:0] mcam[3:0];
	reg [1:0] cd[3:0];
	reg sign[3:0];
	reg [10:0] duty[3:0];

	function new();
		this.per = 0;
	endfunction : new

endclass : SMC_pulseitem

class SMC_single_pulse;

	reg [10:0] per;
	reg recirc, dith;
	reg [3:0] mcpre;
	reg [1:0] mcom;
	reg [1:0] mcam;
	reg [1:0] cd;
	reg sign;
	reg [10:0] duty;

	function new(SMC_pulseitem in, int i);
		this.per = in.per;
		this.recirc = in.recirc;
		this.dith = in.dith;
		this.mcpre = in.mcpre;
		this.mcom = in.mcom[i];
		this.mcam = in.mcam[i];
		this.cd = in.cd[i];
		this.sign = in.sign[i];
		this.duty = in.duty[i];
	endfunction : new

endclass : SMC_single_pulse

class SMC_pulse_info;

	reg shut_off;
	reg [10:0] per;
	reg [10:0] pulse_width;
	realtime start_time;
	reg active;
	reg always_low, always_high;
	reg odd_dither;
	reg [3:0] mcpre;


	function new();
		this.shut_off = 1;
		this.per = 0;
		this.pulse_width = 0;
		this.start_time = 0;
		this.active = 0;
		this.always_low = 0;
		this.always_high = 0;
		this.odd_dither = 0;
		this.mcpre = 1;
	endfunction : new

endclass : SMC_pulse_info

class SMC_pulse_compare;

	realtime first_neg, second_neg, first_pos, second_pos, expect_per;
	reg start_signal, from_start;

	function new();
		this.first_neg = 0;
		this.first_pos = 0;
		this.second_neg = 0;
		this.second_pos = 0;
		this.expect_per = 0;
		this.start_signal = 0;
		this.from_start = 0;
	endfunction : new

endclass : SMC_pulse_compare

class SMC_data;

	reg [15:0] data;
	reg [6:0] addr;

	function new();
		this.data = 0;
		this.addr = 0;
	endfunction : new

endclass : SMC_data
