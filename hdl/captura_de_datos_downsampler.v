`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:56 11/12/2019 
// Design Name: 
// Module Name:    captura_datos_downsampler 
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
module captura_de_datos_downsampler(
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
	output reg [7:0] DP_RAM_data_in,
	output reg [16:0] DP_RAM_addr_in,
	output reg DP_RAM_regW
   );
	
	reg cont=1'b0;
	reg [7:0] color;
	
	always@(posedge PCLK)
	begin
		if(HREF & ~VSYNC)
		begin			
			color[0] = D0;
			color[1] = D1;
			color[2] = D2;
			color[3] = D3;
			color[4] = D4;
			color[5] = D5;
			color[6] = D6;
			color[7] = D7;
			if (cont==0)
			begin
				DP_RAM_data_in <= {color[7:5],color[2:0],DP_RAM_data_in[1:0]};
				DP_RAM_regW = 0;
			end
			else 
			begin
				DP_RAM_data_in <= {DP_RAM_data_in[7:2],color[4:3]};
				DP_RAM_regW = 1;
			end
			cont = cont+1;	
		end
	end
	
	always@(negedge PCLK)
	begin
		if(HREF & ~VSYNC & (cont == 1))
		begin
			DP_RAM_addr_in =DP_RAM_addr_in+1;
		end
	end

endmodule
