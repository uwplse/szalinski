//preview[view:north,tilt:bottom]

//░░▒▒▓▓██████████████████████████ Set all the other paramaters, then use these next 3 options to get the STLS. Turn off preview and then Create STL under "Tie Body" and then "Pattern Pieces". Customizer will generate 5 STLS at once for each.  __________________________________
S_E_L_E_C_T_O_R=0;//[0:0]//break
//
preview_or_generate_Stl=1; //[1:Preview All (I'M NOT DONE DESIGNING!),0:One piece at a time (I'M READY TO GET THE STLS!)]
body_or_pattern=1;//[1:Tie Body, 2:Pattern Pieces]
part=1; // [1:Bottom, 2:Next to Bottom, 3:Next to Top, 4:Top, 5:Knot]


//░░▒▒▓▓██████████████████████████
B_O_D_Y=0;//[0:0]//break
//Z axis material thickness
tie_thickness=1.8; //[1.2:Flimsy 1.2mm,1.5:Thin 1.5mm,1.8:Moderate 1.8mm,2.1:Moderate Plus 2.1mm,2.4:Sturdy 2.4mm]
//Length of main tie body from knot down.
tie_height=450;  // [325:600]
//Maximum width. 45=very skinny, 70=modern narrow, 95=classic wide
tie_width =80; //[45:100]// 

//░░▒▒▓▓██████████████████████████
K_N_O_T=0;//[0:0]//break
knot_width=30; //[30:40]
knot_width_top=40;//[30:60]  
knot_height=35;//[35:50]
//Z axis material thickness
knot_thickness=5;//[3:15]

//░░▒▒▓▓██████████████████████████ Because of how the pattern gets split into 4 pieces, watch out for "island" pieces (i.e. not contiguous with the rest of the design). __________________________________
P_A_T_T_E_R_N=0;//[0:0]//break
//This adds the notches on the main tie body that the pattern pieces snap into. They're not needed if you don't want a pattern.
pattern_yes_or_no=1; //[1:I want to add the pattern pieces, 0:I want a solid color tie]
//Z axis material thickness
pattern_thickness=2.1;//[1.8:Moderate 1.8mm,2.1:Sturdy 2.1mm]
sides=6;//[3:Triangle (3-sided),4:Square (4-sided),5:Pentagon (5-sided),6:Hexagon (6-sided),7:Heptagon (7-sided),8:Octogon (8-sided),9:Nonagon (9-sided),10:Decagon (10-sided),11:Hendecagon (11-sided),12:Dodecagon (12-sided),30:Circle (3w0-sided)]
radius=15;//[2:25]
polygon_edge_thickness=2;//[1.0:10.0]
overlap_factor=50; //[0:100]
polygon_rotation=50;//[0:120]
stretch_off_on=0;//[0:OFF, 1:ON]
//% X stretch.
polygon_stretch=0;//[-20:100]
distort_off_on=0; //[0:OFF, 1:ON]
distort_value=1;//[1:20]
//░░▒▒▓▓██████████████████████████
E_N_D=0;//[0:0]//break





iflub=.05+0;






module SELECTION()
intersection(){
		
		union()
				{translate([0,iflub,0])cube([110,tie_height/4-.5,20]);
				 translate([-265+(2-body_or_pattern)*265,-.25*tie_height*(part-1)-5,-iflub])
					cube([370,tie_height+knot_height+10,20*preview_or_generate_Stl]);
				translate([-140+(2-body_or_pattern)*265+(.5*tie_width),.75*tie_height-.25*tie_height*(part-1),-6-6*(1-preview_or_generate_Stl)])
					scale([2,2,1])
						cylinder(h=6,r=42);}
				
		union()
				{MAINTIE();
				DESIGN();
				translate([-140+(2-body_or_pattern)*265+(.5*tie_width),.75*tie_height+25-.25*tie_height*(part-1),-5])
				scale([2,2,1])
					if (preview_or_generate_Stl==1) 
						{
						HONEYCOMB(60,60,1,radius,overlap_factor,polygon_edge_thickness,sides,polygon_stretch,distort_value,distort_off_on);
						}
					
				
				}
			}
				SELECTION();

		

	


module MAINTIE()


translate([-250*(body_or_pattern-1),-.25*tie_height*(part-1),0])
{
difference()
		{
			union()
			{

				//body
				linear_extrude(height = tie_thickness)polygon([[0,tie_width/2],[tie_width/2,0],[tie_width,tie_width/2],[(tie_width-knot_width)/2+knot_width,tie_height],
				[(tie_width-knot_width)/2,tie_height]],[[0,1,2,3,4,5]]);
			
				//knot
				translate([.5*tie_width-.5*knot_width,(tie_height)+1.5,0])
				linear_extrude(height =knot_thickness)polygon([[0,0],[knot_width,0],[knot_width+.5*(knot_width_top-knot_width),knot_height],
				[-.5*(knot_width_top-knot_width),knot_height]],[[0,1,2,3,4]]);

					//knot connector nubs
					// bottom
							translate([(tie_width/2)-15,tie_height+5.9,knot_thickness-iflub])
							{
								rotate([90,0,90])
								{
									linear_extrude(height = 30)polygon([[0,3.3],[.9,0],[2.3,0],[2.3,1.3],[3.0,2.7]],[[0,1,2,3,4,5]]);
									linear_extrude(height = 30)polygon([[6.9,0],[9.6,0],[9.6,3.2],[5.5,3.2]],[[0,1,2,3,4]]);
								}
							}
					//R
							translate([(tie_width/2)+9.58,tie_height+knot_height-19,knot_thickness-iflub])
							{
								rotate([90,0,180])
								{
									linear_extrude(height = 20)polygon([[0,3.3],[.9,0],[2.3,0],[2.3,1.3],[3.0,2.7]],[[0,1,2,3,4,5]]);
									linear_extrude(height = 20)polygon([[6.9,0],[9.6,0],[9.6,3.2],[5.5,3.2]],[[0,1,2,3,4]]);
								}
							}	
					//L
							translate([(tie_width/2)-9.58,tie_height+knot_height+1,knot_thickness-iflub])
							{
								rotate([90,0,0])
								{
									linear_extrude(height = 20)polygon([[0,3.3],[.9,0],[2.3,0],[2.3,1.3],[3.0,2.7]],[[0,1,2,3,4,5]]);
									linear_extrude(height = 20)polygon([[6.9,0],[9.6,0],[9.6,3.2],[5.5,3.2]],[[0,1,2,3,4]]);
								}
							}


				//body connector nubs top
			for(i = [ [((.25*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+17,(tie_height)/4-5.5,tie_thickness-iflub],
        			       [ tie_width-(.25*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)/4-5.5,tie_thickness-iflub],
					[((.5*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+17,(tie_height)/2-5.1,tie_thickness-iflub],
					[ tie_width-(.5*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)/2-5.1,tie_thickness-iflub],
					[((.75*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+17,(tie_height)/1.333-4.8,tie_thickness-iflub],
					[ tie_width-(.75*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)/1.333-4.8,tie_thickness-iflub],
					[tie_width/2,tie_height-4.4,tie_thickness-iflub],
					[tie_width/2+15,tie_height-4.4,tie_thickness-iflub]])
						{
							translate(i)
							{
								rotate([90,0,270])
								{
									linear_extrude(height = 15)polygon([[0,3.3],[.9,0],[2.3,0],[2.3,1.3],[3.0,2.7]],[[0,1,2,3,4,5]]);
									linear_extrude(height = 15)polygon([[6.9,0],[9.6,0],[9.6,3.2],[5.5,3.2]],[[0,1,2,3,4]]);
								}
							}		
						}

				//body connector nubs bottom
			for(i = [ [((.25*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+2,(tie_height)/4+4.7,tie_thickness-iflub],
        			      [ tie_width-(.25*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-17,(tie_height)/4+4.7,tie_thickness-iflub],
					[((.5*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+2,(tie_height)/2+5.1,tie_thickness-iflub],
					[ tie_width-(.5*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-17,(tie_height)/2+5.1,tie_thickness-iflub],
					[((.75*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width)+2,(tie_height)/1.333+5.4,tie_thickness-iflub],
					[ tie_width-(.75*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-17,(tie_height)/1.333+5.4,tie_thickness-iflub]])
						{
							translate(i)
							{
								rotate([90,0,90])
								{
									linear_extrude(height = 15)polygon([[0,3.3],[.9,0],[2.3,0],[2.3,1.3],[3.0,2.7]],[[0,1,2,3,4,5]]);
									linear_extrude(height = 15)polygon([[6.9,0],[9.6,0],[9.6,3.2],[5.5,3.2]],[[0,1,2,3,4]]);
								}
							}
						}


			}
			
			union()
			{TIEBREAKS(tie_thickness);

			if (pattern_yes_or_no==1)
				{
	
			//TIENOTCH R
				for (i=[ 
        			      [ tie_width-(.15*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.15,0],	
					[ tie_width-(.3*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.3,0],	
					[ tie_width-(.42*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.42,0],
					[ tie_width-(.55*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.55,0],
					[ tie_width-(.67*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.67,0],
					[ tie_width-(.8*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.8,0],
					[ tie_width-(.92*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.92,0]])
					
					{translate(i)

						{rotate([0,0,atan((.5*(tie_width-knot_width))/(tie_height-0.5*tie_width))])
							translate([0,-.5,9.9-10*(pattern_yes_or_no)])cube([2,11,tie_thickness*1.1]);
						}
					}

			//TIENOTCH L		
				for (i = [
					[((.15*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.15,0],      
					[((.3*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.3,0],
					[((.42*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.42,0],
					[((.55*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.55,0],
					[((.67*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.67,0],
					[((.8*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.8,0],
					[((.92*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.92,0]])

					{translate(i)
						{rotate([0,0,180-atan((.5*(tie_width-knot_width))/(tie_height-0.5*tie_width))])
							translate([-2+iflub,-10.5,-.1])cube([2,11,tie_thickness*1.1]);
						}
					}

			//BOTTOM 45 L
				for (i = [
					[.5*tie_width-1.4,0,0]])      
					{translate(i)
						{rotate([0,0,-135])
							translate([-2.9,-10-.25*tie_width,-.1])cube([2,11,tie_thickness*1.1]);
						}
					}
			
			//BOTTOM 45 R
				for (i = [
					[.5*tie_width-1.4,00]])      
					{translate(i)
						{rotate([0,0,135])
							translate([-1,-12-.255*tie_width,-.1])cube([2,11,tie_thickness*1.1]);
						}
					}
			//KNOT L

							
							translate([.5*tie_width-.5*knot_width-.25*(knot_width_top-knot_width)+1,tie_height+.5*knot_height+1.5,.55*knot_thickness])
							rotate([0,0,atan((.5*(knot_width_top-knot_width))/(knot_height))])translate([0,2,0])cube([2,11,knot_thickness*1.2],center=true);
						


			//KNOT R
							
							translate([.5*tie_width+.5*knot_width+.25*(knot_width_top-knot_width)-1,tie_height+.5*knot_height+1.5,.55*knot_thickness])
							rotate([0,0,-atan((.5*(knot_width_top-knot_width))/(knot_height))])translate([0,2,0])cube([2,11,knot_thickness*1.2],center=true);
				}



			}
		}
}

		


module DESIGN()
	translate([250-((body_or_pattern-1)*250),-.25*tie_height*(part-1),0])
	{
	difference()
		{
			union()
			{
				intersection()
				{
					union()
					{
						//knot
						translate([.5*tie_width-.5*knot_width,(tie_height)+1.5,-iflub])
						linear_extrude(height =pattern_thickness-2*iflub)polygon([[0,0],[knot_width,0],[knot_width+.5*(knot_width_top-knot_width),knot_height],
						[-.5*(knot_width_top-knot_width),knot_height]],[[0,1,2,3,4]]);

						//body
						translate([0,0,-iflub])linear_extrude(height = pattern_thickness-2*iflub)polygon([[0,tie_width/2],[tie_width/2,0],[tie_width,tie_width/2],[(tie_width-knot_width)/2+knot_width,tie_height],
						[(tie_width-knot_width)/2,tie_height]],[[0,1,2,3,4,5]]);
					}
			
					union()
					{translate([tie_width/2,(tie_height+knot_height)/2,0])
					if ((body_or_pattern+preview_or_generate_Stl)>1) 
						{
					HONEYCOMB(tie_width,tie_height+knot_height,9,radius,overlap_factor,polygon_edge_thickness,sides,polygon_stretch,distort_value,distort_off_on);
						}

					}
				}
				
				BODY_EDGE();
				KNOT_EDGE();

				//PATTERNCLIP R

				for (i=[ 
        			      [ tie_width-(.15*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.15,0],	
					[ tie_width-(.3*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.3,0],	
					[ tie_width-(.42*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.42,0],
					[ tie_width-(.55*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.55,0],
					[ tie_width-(.67*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.67,0],
					[ tie_width-(.8*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.8,0],
					[ tie_width-(.92*tie_height-0.5*tie_width)/(2*tie_height-tie_width)*(tie_width-knot_width)-2,(tie_height)*.92,0]])
					
					{translate(i)

						{rotate([0,0,atan((.5*(tie_width-knot_width))/(tie_height-0.5*tie_width))])
							translate([2,0,pattern_thickness])PATTERNCLIP();
						}
					}

				//PATTERNCLIP L

				for (i = [
					[((.15*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.15,0],      
					[((.3*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.3,0],
					[((.42*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.42,0],
					[((.55*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.55,0],
					[((.67*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.67,0],
					[((.8*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.8,0],
					[((.92*tie_height-0.5*tie_width)/(2*tie_height-tie_width))*(tie_width-knot_width),(tie_height)*.92,0]])

					{translate(i)

						{rotate([0,0,180-atan((.5*(tie_width-knot_width))/(tie_height-0.5*tie_width))])
							translate([0,-10,pattern_thickness])PATTERNCLIP();
						}
					}

				//PATTERNCLIP BOTTOM 45 L
				for (i = [
					[.5*tie_width-1.4,0,0]])      
					{translate(i)
						{rotate([0,0,225])
							translate([-1,-10-.25*tie_width,pattern_thickness])PATTERNCLIP();
						}
					}
			
				//PATTERNCLIP BOTTOM 45 R
				for (i = [
					[.5*tie_width-1.4,0]])      
					{translate(i)
						{rotate([0,0,135])
							translate([-1,-2-.255*tie_width,pattern_thickness])rotate([0,0,180])PATTERNCLIP();
						}
					}

				//PATTERNCLIP KNOT L
			   			
						rotate([0,0,0])
							translate([.5*tie_width-.5*knot_width-.25*(knot_width_top-knot_width),tie_height+.5*knot_height+1.5,pattern_thickness-iflub])
							rotate([0,0,atan((.5*(knot_width_top-knot_width))/(knot_height))])translate([0,2,0])PATTERNCLIPKNOT();
						
					

				//PATTERNCLIP KNOT R
				     			
						rotate([0,0,0])
							translate([.5*tie_width+.5*knot_width+.25*(knot_width_top-knot_width),tie_height+.5*knot_height+1.5,pattern_thickness-iflub])
							rotate([0,0,180-atan((.5*(knot_width_top-knot_width))/(knot_height))])translate([0,-2,0])PATTERNCLIPKNOT();
						

			}
			
			union()
			{TIEBREAKS(pattern_thickness);
			}
		}
	}

	









			module TIEBREAKS(thickness){
			for (i=[[0,-.25+(tie_height-4.5)/4,-iflub],[0,-.25+(tie_height-1.5)/2,-iflub],[0,-.25+ .75*(tie_height-.5),-iflub]])
			{
			translate(i)
				cube([tie_width,1.,1.1*thickness]);
			}
			}
		


			module BODY_EDGE(){
			linear_extrude(height = pattern_thickness+iflub)polygon([
			[0,tie_width/2],
			[tie_width/2,0],
			[tie_width,tie_width/2],
			[(tie_width-knot_width)/2+knot_width,tie_height],
			[(tie_width-knot_width)/2+knot_width-2,tie_height],
			[tie_width-2,tie_width/2+1],
			[tie_width/2,2.8],
			[2,tie_width/2+1],
			[(tie_width-knot_width)/2+2,tie_height],
			[(tie_width-knot_width)/2,tie_height]],
			[[0,1,2,3,4,5,6,7,8,9,10]]);}
			
			module KNOT_EDGE(){
			translate([.5*tie_width-.5*knot_width,(tie_height)+1.5,0]){
			linear_extrude(height =pattern_thickness+1.1*iflub)polygon([
			[0,0],
			[knot_width,0],
			[knot_width+.5*(knot_width_top-knot_width),knot_height],
			[-.5*(knot_width_top-knot_width),knot_height],
			[2,2],
			[knot_width-2,2],
			[knot_width-2*((1.05*knot_width_top)/knot_height)+.5*(knot_width_top-knot_width),knot_height-2],
			[-.5*(knot_width_top-knot_width)+2*((1.05*knot_width_top)/knot_height),knot_height-2],],
			paths=[[0,1,2,3,0],[4,5,6,7]]);}}


			module HONEYCOMB(w,l,h,r,rmod,th,sides,stretch,distort,distortyn){
	
			columns = l/(r*3)+1;

		
			rows = w/(r*sqrt(3)/2*2)+2;


			translate([-w/1.3,l/1.8,pattern_thickness+iflub])
				rotate([0,0,-90])
					for(i = [0:rows]){
				
					translate([0,r*sqrt(3)/2*i*2,0])
						scale([pow(1+i/(21-distort),distortyn),1,1])
							for(i = [0:columns]){
								translate([r*i*3,0,0])
									for(i = [0:1]){
										translate([r*1.5*i,r*sqrt(3)/2*i,0])
											rotate([0,0,polygon_rotation])
											difference(){
										if(sides < 5){
											scale([1,pow((stretch+100)/100,stretch_off_on),1])cylinder(h=2*pattern_thickness, r = r+th+(r*rmod/50), center = true, $fn = sides);
										} else {
											scale([1,pow((stretch+100)/100,stretch_off_on),1])cylinder(h=2*pattern_thickness, r = r+(r*rmod/50), center = true, $fn = sides);
										}
										scale([1,pow((stretch+100)/100,stretch_off_on),1])cylinder(h=2.05*pattern_thickness, r = r-th+(r*rmod/50), center = true, $fn = sides);
									}
								}
							}
						}
					}


			module PATTERNCLIP(){
			translate([0,0,-iflub])rotate([90,0,180])linear_extrude(height = 10)polygon
			([[0,0],[1.8,0],[2,tie_thickness-.2],[2.7,tie_thickness+.6],[1.8,tie_thickness+1.3],[0,tie_thickness+1.3]],[[0,1,2,3,4,5]]);}
			
			module PATTERNCLIPKNOT(){
			translate([0,0,-iflub])rotate([90,0,0])linear_extrude(height = 10,center=true)polygon
			([[0,0],[1.8,0],[2,knot_thickness-.2],[2.7,knot_thickness+.6],[1.8,knot_thickness+1.3],[0,knot_thickness+1.3]],[[0,1,2,3,4,5]]);}

			
			





	
//___________________________________





