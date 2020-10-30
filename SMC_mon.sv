///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_mon extends uvm_monitor;
	`uvm_component_utils(SMC_mon)
	
	SMC_seqitem message;
	SMC_monitem m0, m1, m2;
	uvm_analysis_port #(SMC_monitem) mon_ap0;
	uvm_analysis_port #(SMC_monitem) mon_ap1;
	uvm_analysis_port #(SMC_monitem) mon_ap2;

	uvm_analysis_port #(SMC_data) data_out;
	SMC_data data;

	virtual SMC_if vif;
	
	function new(string name="SMC_mon", uvm_component parent);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		data_out = new("data_out", this);
		data = new();
		message = SMC_seqitem::type_id::create("message");
		mon_ap0 = new("mon_ap0", this);
		mon_ap1 = new("mon_ap1", this);
		mon_ap2 = new("mon_ap2", this);
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC MON:NOVIF","virtual interface not successful")
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		 forever begin
            @(posedge vif.mon.clk);
            data.data = vif.mon.datain;
            data.addr = vif.mon.addr;
            data_out.write(data);
            message.sel = vif.mon.sel;
            if(vif.mon.write) begin
            	case(vif.mon.addr)
            		7'h00: message.ctlreg[0] = vif.mon.datain;
					7'h02: message.ctlreg[1] = vif.mon.datain;
					7'h03: message.ctlreg[2] = vif.mon.datain;
					7'h10: message.ctlreg[3] = vif.mon.datain;
					7'h11: message.ctlreg[4] = vif.mon.datain;
					7'h12: message.ctlreg[5] = vif.mon.datain;
					7'h13: message.ctlreg[6] = vif.mon.datain;
					7'h14: message.ctlreg[7] = vif.mon.datain;
					7'h15: message.ctlreg[8] = vif.mon.datain;
					7'h16: message.ctlreg[9] = vif.mon.datain;
					7'h17: message.ctlreg[10] = vif.mon.datain;
					7'h18: message.ctlreg[11] = vif.mon.datain;
					7'h19: message.ctlreg[12] = vif.mon.datain;
					7'h1A: message.ctlreg[13] = vif.mon.datain;
					7'h1B: message.ctlreg[14] = vif.mon.datain;
					7'h20: message.ctlreg[15] = vif.mon.datain;
					7'h22: message.ctlreg[16] = vif.mon.datain;
					7'h24: message.ctlreg[17] = vif.mon.datain;
					7'h26: message.ctlreg[18] = vif.mon.datain;
					7'h28: message.ctlreg[19] = vif.mon.datain;
					7'h2A: message.ctlreg[20] = vif.mon.datain;
					7'h2C: message.ctlreg[21] = vif.mon.datain;
					7'h2E: message.ctlreg[22] = vif.mon.datain;
					7'h30: message.ctlreg[23] = vif.mon.datain;
					7'h32: message.ctlreg[24] = vif.mon.datain;
					7'h34: message.ctlreg[25] = vif.mon.datain;
					7'h36: message.ctlreg[26] = vif.mon.datain;
				endcase
            end
            message.reset = vif.mon.reset;
            if(vif.mon.reset) begin
            	for(int i = 0; i <= 26; i++) message.ctlreg[i] = 16'h0000;
            end
            m0 = new(message.ctlreg, message.sel, 0);
			mon_ap0.write(m0);
			m1 = new(message.ctlreg, message.sel, 1);
			mon_ap1.write(m1);
			m2 = new(message.ctlreg, message.sel, 2);
			mon_ap2.write(m2);
		end
	endtask: run_phase
endclass: SMC_mon