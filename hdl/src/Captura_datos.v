`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:03 11/07/2019 
// Design Name: 
// Module Name:    Captura_datos 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Captura_datos(
	input PCLK,
	input HREF,
	input VSYNC,
	input D0,
	input D1,
	input D2,
	input D3,
	input D4,
	input D5,
	input D6,
	input D7,
	output DP_RAM_data_in[7:0],
	output DP_RAM_addr_in,
	output DP_RAM_regW
    );

	reg cont=1'b0;
	reg color[7:0];
		
	always@(posedge (PCLK and HREF) and ~VSYNC))
	
	begin 
		color[7:0]={D0,D1,D2,D3,D4,D5,D6,D7};
		if (cont==0)
		begin
			DP_RAM_data_in={color[7:5],color[2:0],DP_RAM_data_in[1:0]};
			DP_RAM_regW=0;
		end
		else 
		begin
			DP_RAM_data_in={DP_RAM_data_in[7:2],color[4:3]};
			DP_RAM_regW=1;
		end
		cont = cont+1;
	end
	
	always@(negedge(PCLK and VSYNC and ~HREF))
	begin
		DP_RAM_addr_in =DP_RAM_addr_in+1;
	end
	
endmodule
