///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_pulse_generate extends uvm_scoreboard;
	`uvm_component_utils(SMC_pulse_generate)

	uvm_tlm_analysis_fifo #(SMC_single_pulse) in_fifo;
	SMC_single_pulse in;

	uvm_analysis_port #(SMC_pulse_info) out_pulsem;
	uvm_analysis_port #(SMC_pulse_info) out_pulsep;
	SMC_pulse_info pulsem, pulsep;

	function new(string name= "SMC_pulse_generate", uvm_component parent);
		super.new(name,parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		in_fifo = new("in_fifo", this);
		out_pulsem = new("out_pulsem", this);
		pulsem = new();
		out_pulsep = new("out_pulsep", this);
		pulsep = new();
	endfunction : build_phase

	task run_phase(uvm_phase phase);
		forever begin
			in_fifo.get(in);
			pulsem.mcpre = in.mcpre;
			pulsep.mcpre = in.mcpre;
			if(in.duty > in.per)
				in.duty = in.per;
			pulsem.per = in.per*in.mcpre;
			pulsep.per = in.per*in.mcpre;
			if(in.dith) begin
				if(in.duty%2) begin
					in.duty = in.duty - 1;
					case (in.mcom)
					2'b00: begin
						pulsem.odd_dither = 1;
					end
					2'b01: begin
						pulsep.odd_dither = 1;
					end
					2'b10: begin
						if(in.recirc) begin
							if(in.sign) begin
								pulsem.odd_dither = 1;
							end
							else begin
								pulsep.odd_dither = 1;
							end
						end
						else begin
							if(in.sign) begin
								pulsep.odd_dither = 1;
							end
							else begin
								pulsem.odd_dither = 1;
							end
						end
					end
					2'b11: begin
						if(in.recirc) begin
							if(in.sign) begin
								pulsem.odd_dither = 1;
							end
							else begin
								pulsep.odd_dither = 1;
							end
						end
						else begin
							if(in.sign) begin
								pulsep.odd_dither = 1;
							end
							else begin
								pulsem.odd_dither = 1;
							end
						end
					end
					default : begin
						//$display("ERROR");
						pulsem.shut_off = 1;
						pulsep.shut_off = 1;
					end
					endcase
				end
			end
			//$display("MCOM ", in.mcom);
			case (in.mcom)
				2'b00: begin
					//$display("MODE correct");
					pulsem.active = 0;
					pulsep.shut_off = 1;
					pulsem.shut_off = 0;
					pulsem.pulse_width = in.duty*in.mcpre;
					if(in.duty == in.per) pulsem.always_low = 1;
					else if(in.duty == 0) pulsem.always_high = 1;
				end
				2'b01: begin
					//$display("MODE 01");
					pulsep.active = 0;
					pulsem.shut_off = 1;
					pulsep.shut_off = 0;
					pulsep.pulse_width = in.duty*in.mcpre;
					if(in.duty == in.per) pulsep.always_low = 1;
					else if(in.duty == 0) pulsep.always_high = 1;
				end
				2'b10: begin
					//$display("MODE 10");
					pulsem.shut_off = 0;
					pulsep.shut_off = 0;
					if(in.recirc) begin
						if(in.sign) begin
							pulsep.always_low = 1;
							pulsem.active = 1;
							pulsem.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsem.always_high = 1;
							else if(in.duty == 0) pulsem.always_low = 1;
						end
						else begin
							pulsem.always_low = 1;
							pulsep.active = 1;
							pulsep.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsep.always_high = 1;
							else if(in.duty == 0) pulsep.always_low = 1;
						end
					end
					else begin
						if(in.sign) begin
							pulsem.always_high = 1;
							pulsep.active = 0;
							pulsep.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsep.always_low = 1;
							else if(in.duty == 0) pulsep.always_high = 1;
						end
						else begin
							pulsep.always_high = 1;
							pulsem.active = 0;
							pulsem.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsem.always_low = 1;
							else if(in.duty == 0) pulsem.always_high = 1;
						end
					end
				end
				2'b11: begin
					//$display("MODE 11");
					pulsem.shut_off = 0;
					pulsep.shut_off = 0;
					if(in.recirc) begin
						if(in.sign) begin
							pulsep.always_low = 1;
							pulsem.active = 1;
							pulsem.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsem.always_high = 1;
							else if(in.duty == 0) pulsem.always_low = 1;
						end
						else begin
							pulsem.always_low = 1;
							pulsep.active = 1;
							pulsep.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsep.always_high = 1;
							else if(in.duty == 0) pulsep.always_low = 1;
						end
					end
					else begin
						if(in.sign) begin
							pulsem.always_high = 1;
							pulsep.active = 0;
							pulsep.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsep.always_low = 1;
							else if(in.duty == 0) pulsep.always_high = 1;
						end
						else begin
							pulsep.always_high = 1;
							pulsem.active = 0;
							pulsem.pulse_width = in.duty*in.mcpre;
							if(in.duty == in.per) pulsem.always_low = 1;
							else if(in.duty == 0) pulsem.always_high = 1;
						end
					end
				end
				default : begin
					//$display("MODE WRONG");
					pulsem.shut_off = 1;
					pulsep.shut_off = 1;
				end
			endcase
			if(in.dith) begin
				pulsem.per = pulsem.per/2;
				pulsep.per = pulsep.per/2;
				pulsem.pulse_width = pulsem.pulse_width/2;
				pulsep.pulse_width = pulsep.pulse_width/2;
			end
			case (in.mcam)
				2'b00: begin
					pulsem.shut_off = 1;
					pulsep.shut_off = 1;
				end
				2'b01: begin
					pulsem.start_time = in.cd*in.mcpre*10;
					pulsep.start_time = in.cd*in.mcpre*10;
				end
				2'b10: begin
					pulsem.start_time = (in.cd+pulsem.per-pulsem.pulse_width)*in.mcpre*10;
					pulsep.start_time = (in.cd+pulsep.per-pulsep.pulse_width)*in.mcpre*10;
				end
				2'b11: begin
					pulsem.per = pulsep.per*2;
					pulsem.pulse_width = pulsem.pulse_width*2;
					pulsem.start_time = in.cd*in.mcpre*10;
					pulsep.per = pulsep.per*2;
					pulsep.pulse_width = pulsep.pulse_width*2;
					pulsep.start_time = in.cd*in.mcpre*10;
				end
				default : begin
					pulsem.shut_off = 1;
					pulsep.shut_off = 1;
				end
			endcase
			out_pulsem.write(pulsem);
			out_pulsep.write(pulsep);
		end
	endtask : run_phase
endclass : SMC_pulse_generate