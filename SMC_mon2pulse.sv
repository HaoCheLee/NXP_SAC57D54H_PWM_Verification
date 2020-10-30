///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_mon2pulse extends uvm_scoreboard;
	`uvm_component_utils(SMC_mon2pulse)

	uvm_tlm_analysis_fifo #(SMC_monitem) in_fifo;
	SMC_monitem in;

	uvm_analysis_port #(SMC_pulseitem) pulse_info;
	SMC_pulseitem pulse;

	int clk_cnt = 0;

	function new(string name="SMC_mon2pulse", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		pulse_info = new("pulse_info", this);
		pulse = new();
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_fifo.get(in);
			if(in.ctlreg[2][2]) begin
				pulse.dith = 1;
				pulse.per = in.ctlreg[0][10:1]*2;
			end
			else begin
				pulse.dith = 0;
				pulse.per = in.ctlreg[0][10:0];
			end
			pulse.recirc = in.ctlreg[1][7];
			pulse.mctoie = in.ctlreg[1][0];
			case (in.ctlreg[2][6:5])
				2'b01: pulse.mcpre = 2;
				2'b10: pulse.mcpre = 4;
				2'b11: pulse.mcpre = 8;
				default : pulse.mcpre = 1;
			endcase
			pulse.mchme = in.ctlreg[2][4];
			pulse.mctoif = in.ctlreg[2][0];
			for(int i = 0; i <= 3; i++) begin
				case(i)
					0: begin
						pulse.sign[0] = in.ctlreg[8][15];
						pulse.duty[0] = in.ctlreg[8][10:0];
					end
					1: begin
						pulse.sign[1] = in.ctlreg[7][15];
						pulse.duty[1] = in.ctlreg[7][10:0];
					end
					2: begin
						pulse.sign[2] = in.ctlreg[10][15];
						pulse.duty[2] = in.ctlreg[10][10:0];
					end
					3: begin
						pulse.sign[3] = in.ctlreg[9][15];
						pulse.duty[3] = in.ctlreg[9][10:0];
					end
				endcase
				pulse.mcom[i] = in.ctlreg[6-i][7:6];
				pulse.mcam[i] = in.ctlreg[6-i][5:4];
				pulse.cd[i] = in.ctlreg[6-i][1:0];
			end
			if(clk_cnt == 0) begin
				pulse_info.write(pulse);
				clk_cnt = pulse.per*pulse.mcpre - 1;
				//$display("renew at %t,clk is",$time,clk_cnt);
			end
			else begin
				clk_cnt = clk_cnt-1;
			end
			

		end
	endtask : run_phase

endclass : SMC_mon2pulse