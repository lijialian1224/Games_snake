module LED

(
	input clk,
	input rst,
	
	input add_cube,
	input add_cube2,
	inout [1:0]game_status,
	

    output reg[15:0] data
);

    localparam RESTART = 2'b00;
    
	reg[3:0]point;
	reg[31:0]clk_cnt;
	always@(posedge clk or negedge rst)
	begin
		if(!rst)
			begin
				data<= 0;
                                                               clk_cnt <= 0;
			end
	    else if (game_status == RESTART) begin
            data<= 0;     
        clk_cnt <= 0;       
        end
		else
			begin
				if(clk_cnt<=20_0000)	
				begin
					clk_cnt <= clk_cnt+1;
							case(point[3:0])
								4'b0000:data <= 16'b0000_0000_0000_0001;
								4'b0001:data <= 16'b0000_0000_0000_0011;
								4'b0010:data <= 16'b0000_0000_0000_0111;
								
								4'b0011:data <=16'b0000_0000_0000_1111;
								4'b0100:data <= 16'b0000_0000_0001_1111;
								4'b0101:data <= 16'b0000_0000_0011_1111;
								
								4'b0110:data <= 16'b0000_0000_0111_1111;
								4'b0111:data <= 16'b0000_0000_1111_1111;
								4'b1000:data <= 16'b0000_0001_1111_1111;
								4'b1001:data <=16'b0000_0011_1111_1111;
								
								4'b1010:data <= 16'b0000_0111_1111_1111;
								4'b1011:data <= 16'b0000_1111_1111_1111;
								4'b1100:data <= 16'b0001_1111_1111_1111;
								4'b1101:data <= 16'b0011_1111_1111_1111;
								
								4'b1110:data <= 16'b0111_1111_1111_1111;
								4'b1111:data <= 16'b1111_1111_1111_1111;
								default;
							endcase					
						end		
						else
						clk_cnt<= 0;							
	end
	end
	
	reg addcube_state;
	
		always@(posedge clk or negedge rst)
		begin
			if(!rst)
				begin
					point <= 0;
					addcube_state <= 0;					
				end
			else if (game_status == RESTART) begin
                point <= 0;
                addcube_state <= 0;              
            end
			else begin
				case(addcube_state)				
				    0: begin				
					    if(add_cube==1)
					     begin
					        if(point[3:0] < 15)
						        point[3:0] <= point[3:0] + 1;
					        else begin
						        point[3:0] <= 0;
							   end
						   					
					       addcube_state <= 1;
				        end
				        else if(add_cube2 ==1) begin
                                            if(point[3:0] > 0)
                                                point[3:0] <= point[3:0] - 1;
                                            else begin
                                                point[3:0] <= 0;
                                                end                        
                                               addcube_state <= 1;
                                            end
				    end				
				    1: begin
				        if((add_cube)==0|(add_cube2)==0)
					        addcube_state <= 0;
				    end	
				endcase			
			end										
	end								
endmodule