module VermLeftSprite(address,clock,q);
	input	[14:0]address, clock;
	output [0:0]q;
	tri1 clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Verm/Left.mif",
		altsyncram_component.numwords_a = 21168,
		altsyncram_component.widthad_a = 15,
		altsyncram_component.width_a = 1;
endmodule

module VermRightSprite(address,clock,q);
	input	[14:0]address, clock;
	output [0:0]q;
	tri1 clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Verm/Right.mif",
		altsyncram_component.numwords_a = 21168,
		altsyncram_component.widthad_a = 15,
		altsyncram_component.width_a = 1;
endmodule

module MoleSprite(address,clock,q);
	input	[9:0]address, clock;
	output [0:0]q;
	tri1 clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Verm/Mole.mif",
		altsyncram_component.numwords_a = 960,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module MoleEscapeSprite(address,clock,q);
	input	[9:0]address, clock;
	output [0:0]q;
	tri1 clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Verm/Escape.mif",
		altsyncram_component.numwords_a = 756,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module DirtSprite(address,clock,q);
	input	[8:0]address, clock;
	output [0:0]q;
	tri1 clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Verm/Dirt.mif",
		altsyncram_component.numwords_a = 440,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule
