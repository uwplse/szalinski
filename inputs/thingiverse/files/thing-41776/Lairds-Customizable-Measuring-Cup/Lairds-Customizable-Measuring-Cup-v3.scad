//Code by Griffin Nicoll 2012
// Trivially enhanced by Laird Popkin 2012
// Customizable by Laird 2013

use <write/Write.scad> // Fonts supported by Customizer
use <utils/build_plate.scad>	 // build plate

//Number of cups
cups = 3.1515926;
//Tablespoons
tbsp = 0;
//Teaspoons
tsp = 0;
//Millilitres
mL = 0;
//Label
label = "3.1415926 Cups";
echo(str("Label is ",label));

//Text style
Font = "write/Letters.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]

//Text size scaling factor, edit to make text fit and look good.
size = 0.3;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

/*

// LP: uncomment the line for the cup you want, or add your own unique cup!
// label is printed on the top and bottom of the cup
// label_len is the number of characters in the label

//cups = 1; label="1 cup";
//cups = 2; label="2 cups";
//tbsp = 2; label="2 tablespoons"; 
//tsp = 1; label="1 teaspoon"; 
//mL = 10; label = "10 mL"; 

*/

// Wall thickness
wall = 5; //[1:5]

// Text depth (mm) should be at least one 'slice'
print = 0.4;

//stuff you don't need to edit
sq = 1.2*1; //squeeze
sh = 0.16*1; //shear
pi = 3.14159*1;
volume = cups*236588+tbsp*14787+tsp*4929+1000*mL;//mm^3

// for labeling
x = size*pow(volume/(570*pi),1/3);

module cup() {
	echo(str("Label is ",label, " and Font is ",Font));
	difference(){
		minkowski(){
			cylinder(r1=0,r2=wall,h=wall,$fn=6);
			cupBase(volume);
			}
		translate([0,0,wall+0.02])cupBase(volume);
		rotate([180,0,90]) translate([0,0,-print]) scale([x,x,1]) 
			write(label, center=true, rotate=90, font=Font);
		}

	translate([0,0,wall]) rotate([0,0,90]) translate([0,0,wall-print]) scale([x,x,1]) 
		write(label, center=true, rotate=90, font=Font);
	}

// preview[view:south, tilt:top]

//rotate([180,0,180]) 
cup();
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);

module cupBase(volume){
	x = pow(volume/(570*pi),1/3);
	multmatrix(m=[
		[sq, 0, sh, 0],
		[0, 1/sq, 0, 0],
		[0, 0, 1, 0],
		[0, 0, 0,  1]])
	cylinder(h=10*x,r1=6*x,r2=9*x,$fn=64);
}
