///////////////////////////////////////////////////////////////////////////////
// Project: SMC PWM verification
// Author: Hao-Che Lee
///////////////////////////////////////////////////////////////////////////////
The Top-Down Structure of the project

*Some calculation in SMC_pulse_generate, SMC_pulse_process, SMC_scoreboard is base on 10 as clock cycle
**Change of the clock cycle make wrong calculation

top: including files, call SMC_test

SMC_test: call SMC_environment, start sequencer

SMC_environment: call SMC_scoreboard, SMC_data_scoreboard, SMC_sender, SMC_agent, SMC_mon_op
						connect expect value from SMC_agent to SMC_sender
						connect SMC_mon_op and SMC_sender to SMC_scoreboard
						each mnm/mnp have a scoreboard

SMC_scoreboard: compare mnm.mnp value from DUT and expect value to verify correctness of the signal

SMC_data_scoreboard: check datain and dataout to make sure data correctly write into the DUT

SMC_mon_op: pass the signal from DUT into scoreboard

SMC_sender: SMC_agent send expect value every SMC period, SMC_sender receive the data and 
			send it repeatedly to SMC_scoreboard every clock cycle

SMC_agent: call SMC_sequencer, SMC_driver, SMC_mon, SMC_mon2pulse, SMC_pulse, SMC_pulse_generate, SMC_pulse_process
			connect SMC_sequencer -> SMC_driver -> vif
			connect vif -> SMC_mon ----------------> SMC_mon2pulse ----------------> SMC_pulse -> 
									  SMC_monitem					SMC_pulseitem

			connect SMC_pulse ----------------> SMC_pulse_generate ----------------> SMC_pulse_process -------------->
							   SMC_single_pulse						SMC_pulse_info						SMC_pulse_compare

SMC_mon: receice signal from vif, separate the raw data into 3 set of control register

SMC_mon2pulse: transfer control regiter data to control signal

SMC_pulse: check dual full H-bridge mode works in pair, if not, change into full H-bridge
						separate signal into four pairs

SMC_pulse_generate: calculate pulse info including pulse width, always high/low and multiplies the time by mcpre
					separate the pair signal into two signals

SMC_pulse_process: transfer the pulse info into compare item
					the scoreboard compares the time of edges and initial value

***Comparing pulse width, period, and start time with the DUT signal will be complicated when dithering
****The design compare two sets of pos/neg edge to verify the signal

SMC_seqitem: including sequence_item and other user define class type