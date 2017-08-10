module OctoBackgroundSprite(address,clock,q);
	input	[16:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Background.mif",
		altsyncram_component.numwords_a = 76800,
		altsyncram_component.widthad_a = 17,
		altsyncram_component.width_a = 1;
endmodule

module OctoLifeSprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Life.mif",
		altsyncram_component.numwords_a = 704,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module TentacleAB1Sprite(address,clock,q);
	input	[10:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleAB1.mif",
		altsyncram_component.numwords_a = 1352,
		altsyncram_component.widthad_a = 11,
		altsyncram_component.width_a = 1;
endmodule

module TentacleA2Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleA2.mif",
		altsyncram_component.numwords_a = 576,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module TentacleA3Sprite(address,clock,q);
	input	[10:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleA3.mif",
		altsyncram_component.numwords_a = 1248,
		altsyncram_component.widthad_a = 11,
		altsyncram_component.width_a = 1;
endmodule

module TentacleB2Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleB2.mif",
		altsyncram_component.numwords_a = 672,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module TentacleB3Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleB3.mif",
		altsyncram_component.numwords_a = 440,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleB4Sprite(address,clock,q);
	input	[10:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleB4.mif",
		altsyncram_component.numwords_a = 1260,
		altsyncram_component.widthad_a = 11,
		altsyncram_component.width_a = 1;
endmodule

module TentacleC1Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleC1.mif",
		altsyncram_component.numwords_a = 616,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module TentacleC2Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleC2.mif",
		altsyncram_component.numwords_a = 432,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleC3Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleC3.mif",
		altsyncram_component.numwords_a = 308,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleC4Sprite(address,clock,q);
	input	[7:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleC4.mif",
		altsyncram_component.numwords_a = 228,
		altsyncram_component.widthad_a = 8,
		altsyncram_component.width_a = 1;
endmodule

module TentacleC5Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleC5.mif",
		altsyncram_component.numwords_a = 459,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleD1Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleD1.mif",
		altsyncram_component.numwords_a = 504,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleD2Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleD2.mif",
		altsyncram_component.numwords_a = 468,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleD3Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleD3.mif",
		altsyncram_component.numwords_a = 322,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleD4Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleD4.mif",
		altsyncram_component.numwords_a = 910,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module TentacleE1Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleE1.mif",
		altsyncram_component.numwords_a = 414,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleE2Sprite(address,clock,q);
	input	[8:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleE2.mif",
		altsyncram_component.numwords_a = 432,
		altsyncram_component.widthad_a = 9,
		altsyncram_component.width_a = 1;
endmodule

module TentacleE3Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/TentacleE3.mif",
		altsyncram_component.numwords_a = 800,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module OctoCorpseSprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Corpse.mif",
		altsyncram_component.numwords_a = 4526,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule

module Diver0Sprite(address,clock,q);
	input	[9:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver0.mif",
		altsyncram_component.numwords_a = 986,
		altsyncram_component.widthad_a = 10,
		altsyncram_component.width_a = 1;
endmodule

module Diver1Sprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver1.mif",
		altsyncram_component.numwords_a = 4968,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule

module Diver2Sprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver2.mif",
		altsyncram_component.numwords_a = 4640,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule

module Diver3Sprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver3.mif",
		altsyncram_component.numwords_a = 4704,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule

module Diver4Sprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver4.mif",
		altsyncram_component.numwords_a = 6160,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule

module Diver5Sprite(address,clock,q);
	input	[12:0]address;
	input clock;
	output [0:0]q;
	tri1	  clock;
	wire [0:0] sub_wire0;
	wire [0:0] q = sub_wire0[0:0];

	altsyncram	altsyncram_component (.address_a (address),.clock0 (clock),.q_a (sub_wire0),.aclr0 (1'b0),.aclr1 (1'b0),.address_b (1'b1),.addressstall_a (1'b0),.addressstall_b (1'b0),.byteena_a (1'b1),.byteena_b (1'b1),.clock1 (1'b1),.clocken0 (1'b1),.clocken1 (1'b1),.clocken2 (1'b1),.clocken3 (1'b1),.data_a (1'b1),.data_b (1'b1),.eccstatus (),.q_b (),.rden_a (1'b1),.rden_b (1'b1),.wren_a (1'b0),.wren_b (1'b0));
	defparam altsyncram_component.address_aclr_a = "NONE",altsyncram_component.operation_mode = "ROM",altsyncram_component.outdata_aclr_a = "NONE",altsyncram_component.outdata_reg_a = "UNREGISTERED",altsyncram_component.clock_enable_input_a = "BYPASS",altsyncram_component.clock_enable_output_a = "BYPASS",altsyncram_component.intended_device_family = "Cyclone V",altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",altsyncram_component.lpm_type = "altsyncram",altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "./sprites/Octo/Diver5.mif",
		altsyncram_component.numwords_a = 5684,
		altsyncram_component.widthad_a = 13,
		altsyncram_component.width_a = 1;
endmodule
