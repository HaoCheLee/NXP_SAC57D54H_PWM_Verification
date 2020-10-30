///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
class SMC_driver extends uvm_driver #(SMC_seqitem);
	`uvm_component_utils(SMC_driver)
	
	virtual SMC_if vif;

	reg[6:0] addr[26:0];
	SMC_seqitem message;
	
	function new(string name = "SMC_driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual SMC_if)::get(this,"","vif",vif))
			`uvm_fatal("SMC DRV:NOVIF","virtual interface not successful")
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction : connect_phase 
	
	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			seq_item_port.get_next_item(message);
	        addr[0] = 7'h00;
			addr[1] = 7'h02;
			addr[2] = 7'h03;
			addr[3] = 7'h10;
			addr[4] = 7'h11;
			addr[5] = 7'h12;
			addr[6] = 7'h13;
			addr[7] = 7'h14;
			addr[8] = 7'h15;
			addr[9] = 7'h16;
			addr[10] = 7'h17;
			addr[11] = 7'h18;
			addr[12] = 7'h19;
			addr[13] = 7'h1A;
			addr[14] = 7'h1B;
			addr[15] = 7'h20;
			addr[16] = 7'h22;
			addr[17] = 7'h24;
			addr[18] = 7'h26;
			addr[19] = 7'h28;
			addr[20] = 7'h2A;
			addr[21] = 7'h2C;
			addr[22] = 7'h2E;
			addr[23] = 7'h30;
			addr[24] = 7'h32;
			addr[25] = 7'h34;
			addr[26] = 7'h36;
			for(int i = 0; i <= 26; i++) begin
				@(posedge vif.driver.clk);
				//if(i == 0) $display("sending at ",$time);
				vif.driver.reset		<= message.reset;
				vif.driver.write		<= message.write;
				vif.driver.sel			<= message.sel;
				vif.driver.addr			<= addr[i];
				vif.driver.datain		<= message.ctlreg[i];
			end
			for(int i = 0; i <= 100; i++) begin
				@(posedge vif.driver.clk);
			end
			seq_item_port.item_done();
		end
		
	endtask: run_phase

endclass: SMC_driver