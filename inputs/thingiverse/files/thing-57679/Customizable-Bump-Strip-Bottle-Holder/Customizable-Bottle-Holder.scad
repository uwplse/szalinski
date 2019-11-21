//*********User Defined variables****************

//How many pairs of strips do you want to print?
pairs=2;

//What's the primary color?
primary_color="white"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua]

//What's the secondary color?
secondary_color="red"; //[black,silver,gray,white,maroon,red,purple,fuchsia,green,lime,olive,yellow,navy,blue,teal,aqua]

//This design will output 3 files - one for printing in a solid color and 2 for printing using dualstrusion.
part = "Solid"; //[Solid,Dual1,Dual2]

//If you're dualstruding, do you want all strips the same or do you want half with the colors reversed?
dualstrusion_mix = "mixed"; //[all the same,mixed]

//About how wide should each bottle space be? 90mm works well for wine bottles.
bottle_space_width=90;

//How deep should the strips be?  15 mm works well for wine bottles.
strip_depth=15;

//How thick should the strips be?
strip_thickness=3;

//How far apart do you want the strips spaced on the build platform?
spacing = 2;

//What tolerance should be used for the dovetail joints?
tolerance=.4;


//*****Dimensional Parameters*****
//*****These are currently set for standard wine bottles****
length = bottle_space_width; //This is really half the overall length, so final length = length*2
depth = strip_depth; //depth of the strip
base_thick = strip_thickness; //thickness of the base
bump = 1/3*bottle_space_width; // radius of the circles that form the bumps in the strip
clearance = 2/3*bump; //height above the base that the bumps will protrude
res=100*1; //resolution for rendering of circles
tol=tolerance;


//**********Calculated Variables*****
count=pairs*2;


//**********Generate parts***********


//*******first color**********//
if(part=="Dual1" || part=="Solid")color(primary_color){
	//***********all parts dualstruded*******//
	if(dualstrusion_mix=="all the same"){
		for(i=[0:count-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				difference(){
					strip();
					center_void();
				}
			}
		}
	}
	//***********half parts dualstruded normally, half colors reversed*****//
	if(dualstrusion_mix=="mixed"){
		for(i=[0:pairs-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				difference(){
					strip();
					center_void();
				}
			}
		}
		for(i=[pairs:count-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				center();
			}
		}
	}
}

//////////*********Second color for dualstrusion*****
if(part=="Dual2" || part=="Solid")color(secondary_color){
	//***********all parts dualstruded*******//
	if(dualstrusion_mix=="all the same"){
		for(i=[0:count-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				center();
			}
		}
	}
	//***********half parts dualstruded normally, half colors reversed*****//
	if(dualstrusion_mix=="mixed"){
		for(i=[0:pairs-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				center();
			}
		}
		for(i=[pairs:count-1]){
			translate([0,(-(count-1)*(depth+spacing))/2+i*(depth+spacing),0]){
				difference(){
					strip();
					center_void();
				}
			}
		}
	}
}



//**********************************************
/////////////////Define main component//////////
//**********************************************

module strip(){

	difference(){
	
	union(){
	
		translate([0,0,base_thick/2])cube([2*length,depth,base_thick], center=true);
		
			intersection(){
			
				union(){
					translate([length,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth,r=bump,center=true,$fn=res);
					translate([0,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth,r=bump,center=true,$fn=res);
					translate([-length,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth,r=bump,center=true,$fn=res);
				}
			
				translate([0,0,bump])cube([2*length,depth,2*bump],center=true);
		}
	}
	
	translate([-length,0,0])linear_extrude(height = bump)polygon([[0,1/6*depth+tol],[1/2*depth+tol,1/4*depth+tol],[1/2*depth+tol,-1/4*depth-tol],[0,-1/6*depth-tol]],[[0,1,2,3]]);
	
	}
	
	
	
	intersection(){
		translate([length,0,0])linear_extrude(height = bump)polygon([[0,1/6*depth],[1/2*depth,1/4*depth],[1/2*depth,-1/4*depth],[0,-1/6*depth]],[[0,1,2,3]]);
		translate([length,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth,r=bump,center=true,$fn=res);
	}
}




//**************************************************************************
/////////////////Define void on main piece for dualstrusion//////////
////////////////Slightly thicker than center piece to eliminate "plane" of polygons////
//**************************************************************************

module center_void(){
		
	intersection(){

		translate([0,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth+spacing/4,r=bump+.01,center=true,$fn=res);
	
		difference(){
			translate([0,0,0])cube([2*length,depth+spacing/4,2*bump],center=true);
			translate([0,0,0])cube([2*length,depth/3,2*base_thick],center=true);
		}
	}
}




//**************************************************************************
/////////////////Define second color center piece for dualstrusion//////////
//**************************************************************************

module center(){
		
	intersection(){

		translate([0,0,-bump+clearance])rotate([90,0,0])cylinder(h=depth,r=bump+.01,center=true,$fn=res);
	
		difference(){
			translate([0,0,bump])cube([2*length,depth,2*bump],center=true);
			translate([0,0,base_thick/2])cube([2*length,depth/3,base_thick],center=true);
		}
	}
}
