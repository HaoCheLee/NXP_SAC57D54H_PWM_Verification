///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
interface SMC_if();
	logic clk, reset, write, sel;
	logic [6:0] addr;
	logic [15:0] datain, dataout;
	logic [11:0] mnm, mnp;

	modport SMC (input clk, reset, write, sel, addr, datain, output mnm, mnp, dataout);
	modport driver (input clk, output reset, write, sel, addr, datain);
	modport mon (input clk, reset, write, sel, addr, datain);
	modport mon_op (input clk, dataout, mnm, mnp);
	modport sen (input clk);

endinterface : SMC_if