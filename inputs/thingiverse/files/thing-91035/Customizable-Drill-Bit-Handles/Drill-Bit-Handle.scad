
//Variables

// preview[view:north east, tilt:side]

//The units of your Drill Bit.
Drill_Bit_Diameter_Units=1; //[1: Millimeter, 2:Inches]

//Diameter of the Drill bit.  Only accepts Decimals. No Fractions
Drill_Bit_Diameter=3; 

//Drill Bit Length: How Far do you want the Drill Bit to go into the Handle
Drill_Bit_Length=20;

//Length of the Handle
Handle_Length=65; 

//Diameter of the Handle
Handle_Diameter=15; 


//Diameter of the set Screw
Set_Screw_Diameter=3; 

//Thickness of the set Screw Nut
Set_Screw_Nut_Thickness=3; 

//Diameter of the Set Screw Nut
Set_Screw_Nut_Diameter=5.5; 

//Number of Nut Traps
Number_of_Nut_Traps=2;

//The Overall Resolution of the Handle
Resolution=25; 

//Ignore these variables


db_d=Drill_Bit_Diameter;
hl=Handle_Length;
hd=Handle_Diameter;
db_l=Drill_Bit_Length;
db_d=Drill_Bit_Diameter;
ss_d=Set_Screw_Diameter;
ss_n_t=Set_Screw_Nut_Thickness;
ss_n_d=Set_Screw_Nut_Diameter;
$fn=Resolution;




if(Drill_Bit_Diameter_Units==1){
Drill_Bit_Handle_Metric();
}
if(Drill_Bit_Diameter_Units==2){
Drill_Bit_Handle();
}




module Drill_Bit_Handle_Metric(){

	difference(){
	
		//Main Body of the Drill Bit Handle
		union(){

			cylinder(hl,(hd+db_d)/2,(hd+db_d)/2); 
			translate([0,0,hl])
				sphere((hd+db_d)/2);

		}

		//Hole for Drill Bit
		cylinder(db_l,(db_d+1)/2,(db_d+1)/2); 
	
		
		//This is the Groove on the bottom of the handle	
		translate([0,0,(ss_n_d)+15])
			rotate_extrude(convexity = 10)
				translate([((hd+db_d)/2)+7.45, 0, 0])
					circle(r = 10);
	
		// Small Grooves for the Handle
		for ( i = [0 : 3] ){	
		    rotate( i * 360 / 3, [0, 0, 1])
		  	  translate([0, ((hd+db_d)/2)+2, (ss_n_d/2)+17])
		  		 cylinder(hl-((ss_n_d/2)),3,3);
		}
			
			//Large Grooves for the handle
			
			
				rotate([0,0,360/6]){
					for ( i = [0 : 3] ){	
					    rotate( i * 360 / 3, [0, 0, 1])
					  	  translate([0,  ((hd+db_d)+(13)+2)/2, (ss_n_d/2)+17])
					  		cylinder(hl-((ss_n_d/2)),(20)/2,(20)/2);
					}
				}
			
		
		
			//Nut Trap
		
		if (Number_of_Nut_Traps==2){
		
			translate([db_d/2+(ss_n_t-.45),0,ss_n_d+1]){
			
			union(){
				hull(){
		
					rotate([0,90,0])
						translate([0,0,ss_n_t/-2])
							hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
		
					rotate([0,90,0])
						translate([(ss_n_d/2)+10,0,ss_n_t/-2])
							hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
		
				}
	
			rotate([0,90,0])
				translate([0,0,(hd+db_d)/-7+ss_n_t/-2])
					cylinder((hd+db_d+1)/2,(ss_d+1)/2,(ss_d+1)/2);
		
			}
			}
			
			}
			//Nut Trap
			translate([db_d/-2-(ss_n_t-.25),0,ss_n_d+1]){
		
				hull(){
		
					rotate([0,90,0])
						translate([0,0,ss_n_t/-2])
							hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
		
					rotate([0,90,0])
						translate([(ss_n_d/2)+10,0,ss_n_t/-2])
							hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
		
				}
	
			rotate([0,90,0])
				translate([0,0,(hd+db_d)/-5.1+ss_n_t/-2])
					cylinder((hd+db_d+1)/2,(ss_d+1)/2,(ss_d+1)/2);
		
			}
	
	}
	

	}

module Drill_Bit_Handle(){

difference(){

	//Main Body of the Drill Bit Handle
	union(){
	
		cylinder(hl,(hd+(db_d*25.4))/2,(hd+(db_d*25.4))/2); 
	
		translate([0,0,hl])	
			sphere((hd+(db_d*25.4))/2);
	
	}
	
	//Hole for Drill Bit
	cylinder(db_l,((db_d*25.4)+1)/2,((db_d*25.4)+1)/2); 

	//This is the Groove on the bottom of the handle 

	translate([0,0,(ss_n_d)+15])
		rotate_extrude(convexity = 10)
			translate([((hd+(db_d*25.4))/2)+7.45, 0, 0])
				circle(r = 10);

	// Small Grooves for the Handle
	for ( i = [0 : 3] ){ 

		rotate( i * 360 / 3, [0, 0, 1])

		translate([0, ((hd+(db_d*25.4))/2)+2, (ss_n_d/2)+17])
			cylinder(hl-((ss_n_d/2)),3,3);

	}
	//Large Grooves for the handle
	rotate([0,0,360/6]){

		for ( i = [0 : 3] ){ 

		rotate( i * 360 / 3, [0, 0, 1])

		translate([0, ((hd+(db_d*25.4))+(13)+2)/2, (ss_n_d/2)+17])
			cylinder(hl-((ss_n_d/2)),(20)/2,(20)/2);

		}

	}

	//Nut Trap
	if (Number_of_Nut_Traps==2){

		translate([(db_d*25.4)/2+(ss_n_t-.45),0,ss_n_d+1]){

			union(){

				hull(){

					rotate([0,90,0])
						translate([0,0,ss_n_t/-2])
							hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);

	rotate([0,90,0])
		translate([(ss_n_d/2)+10,0,ss_n_t/-2])
			hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);

	}

	rotate([0,90,0])
		translate([0,0,(hd+(db_d*25.4))/-7+ss_n_t/-2])
			cylinder((hd+(db_d*25.4)+1)/2,(ss_d+1)/2,(ss_d+1)/2);

	}

	}

	}

	//Nut Trap

	translate([(db_d*25.4)/-2-(ss_n_t-.25),0,ss_n_d+1]){

		hull(){
	
		rotate([0,90,0])
			translate([0,0,ss_n_t/-2])
				hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
	
		rotate([0,90,0])
			translate([(ss_n_d/2)+10,0,ss_n_t/-2])
				hexagon(ss_n_t+.25,(ss_n_d+1.75)/2);
	
		}

	rotate([0,90,0])
		translate([0,0,(hd+(db_d*25.4))/-5.1+ss_n_t/-2])
			cylinder((hd+(db_d*25.4)+1)/2,(ss_d+1)/2,(ss_d+1)/2);

	}

	}

}



			
			



module reg_polygon(sides,radius)
{
  function dia(r) = sqrt(pow(r*2,2)/2);  //sqrt((r*2^2)/2) if only we had an exponention op
  if(sides<2) square([radius,0]);
  if(sides==3) triangle(radius);
  if(sides==4) square([dia(radius),dia(radius)],center=true);
  if(sides>4) circle(r=radius,$fn=sides);
}

module hexagonf(radius)
{
  reg_polygon(6,radius);
}

module hexagon(height,radius) 
{
  linear_extrude(height=height) hexagonf(radius);
}