//Customizable struts for regolith-shielded dugout houses
//Ari M. Diacou - June 2014
//Published at: http://www.thingiverse.com/thing:348765
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/

// preview[view:south west, tilt:top diagonal]

//Width of a strut
width=6;
//Longest outside length of a strut
length=30;
//Transvers thickness of a strut
thickness=4;
//How wide should the bins be in the length direction
bin_width=4;
//How thick should the walls of the bins be
wall_thickness=.3;
//What is the angle the roof makes with the ground
theta=35;
//Do you want to print a a model, assembeled roof, a sheet of struts, or individual struts? 
assembly="model"; // [model, tent, sheet, struts]
//How many struts to print?
num=10;

/*[Hidden]*/

///// Derived Scalars /////
epsilon=0+0.001;//Used to ensure manifoldness
base=length*cos(theta); //edge of roof to roof ridge
height=length*sin(theta); //height of roof ridge from surface
ep=epsilon; //Who actually likes typing all those characters?
inter_strut_distance = sqrt((3*wall_thickness)*(width/10)); //geometric mean used to automatically space the struts a small distance, using 2 definitions of small.
strut_area_approx=thickness*(length-thickness/2);//An approximation of the area of a strut
strut_depth=strut_area_approx/(2*base);//The minimum depth you need to dig to get enough soil to fill a pair of struts
cone_depth=(3.1415/6)*(base*height)/(width*num);//The depth you need to dig to get enough earth for the mounds at the front and back of the structure
echo("You will need to dig down at least ",(strut_depth+cone_depth)," units to have enough earth for this structure");

/////// MAIN() ///////////

if(assembly=="model"){
	tent(num);
	back();
	front();
	}
if(assembly=="tent"){
	tent(num);
	}
if(assembly=="struts"){
	lineupx(num,inter_strut_distance+width) 
		printable_strut();
	}
if(assembly=="sheet"){
	lineupx(num,width-ep) 
		printable_strut();
	}

///// FUNCTIONS /////////

module front(){
	difference(){
		cylinder(h=height,r1=base,r2=0,center=false);
		translate([-base-ep,-base-ep,-ep])
			cube([base+ep,2*(base+ep),height+2*ep],center=false);
		}
	}

module back(){
	translate([-num*width,0,0]){
		difference(){
			cylinder(h=height,r1=base,r2=0,center=false);
			translate([0,-base-ep,-ep])
				cube([base+ep,2*(base+ep),height+2*ep],center=false);
		scale([1,.5,1])
			rotate([0,90,0])
				cylinder(h=2*(base+ep),r=.8*(height-thickness/cos(theta)),center=true);
			}
		}
	}

module tent(num){
	lineupx(num,width-ep) pair();
	}

module printable_strut(){
	translate([0,0,thickness])
		rotate([-theta,0,0])
			translate([2*width,base/2,-height/2])
				left();
	}

//module copy_printable_strut(){
//	translate([
//		2*width,
//		length*(-0.5+cos(theta))-2*thickness*sin(theta),
//		-height*sin(theta)+(-1+sin(theta))*thickness])
//			rotate([-theta,0,0]) 
//				left();
//	}

//module bottom(){
//	delta=thickness-wall_thickness;
//	intersection(){
//		preform();
//		translate([0,delta*cos(theta),-delta*sin(theta)]) preform();
//		}
//	}

module bottom2(){
	delta=thickness-wall_thickness;
	difference(){
		preform();
		translate([0,-wall_thickness*cos(theta),wall_thickness]) preform();
		}
	}

module pair(){
	translate([0,ep,0]) left(); 
	translate([0,-ep,0])right();
	}

module left(){
	union(){
		bottom2();
		difference(){
			preform();
			bins();
			}
		}
	}

module right(){
	mirror([0,1,0])
		left();
	}

module lineupy(num, space) {
   for (i = [1 : num])
     translate([ 0, -space*i, 0 ]) child();
 }

module lineupx(num, space) {
   for (i = [1 : num])
     translate([-space*i,0,0]) child();
 }

module show_regolith(){
	intersection(){
		preform();
		bins();
		}
	}
 
module bins(){
	num_bins=floor(base/(bin_width+wall_thickness));
	diff=base-num_bins*(bin_width+wall_thickness);
	lineupy(num_bins, bin_width+wall_thickness) 
		//color("DarkRed") 
			translate([wall_thickness,-diff/2,0])		
				cube([width-2*wall_thickness,bin_width,height]);
	}

module preform(){
	difference(){
		translate([0,-length*cos(theta)+thickness*sin(theta),-thickness*cos(theta)])
			rotate([theta,0,0]) 
				cube([width,length,thickness],center=false);
		
		//color("blue")	
			translate([-ep,-length-ep,-thickness])
				rotate([0,0,0]) 
					cube([width+2*ep,2*length,thickness],center=false);
		
		//color("red")	
			translate([-ep,thickness,-length])
				rotate([90,0,0]) 
					cube([width+2*ep,2*length,thickness],center=false);
		}
	}