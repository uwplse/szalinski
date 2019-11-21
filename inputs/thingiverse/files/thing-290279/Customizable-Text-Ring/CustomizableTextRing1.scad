// ************* Credits part *************

// Programmed by Fryns - April 2014

// Optimized for Customizer based on "Any Ring" by Fryns, published on Thingiverse 05-Jan-2014 (thing:219432)

// Inspired from "Any Cufflink" by Fryns, published on Thingiverse 30-Dec-2013 (thing:215384)

// Uses Write.scad by HarlanDMii, published on Thingiverse 18-Jan-2012 (thing:16193)	 

// ************* Declaration part *************

/* [Text] */
text="Fryns";
font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Orbitron,"write/BlackRose.dxf":BlackRose]
font_size=7;
text_depth=2;


/* [Ring] */
// ring size in mm (inner perimeter (circumference))
ring_size = 54; // ringsize in mm (inner perimeter (circumference))
ring_thickness = 3;
ring_width = 4;

use_childrens_cut = "Yes"; //["Yes":Yes,"No":No]
// use 20 for draft 100 for nice
resolution=100; //[20:Draft,50:Medium,100:Fine, 200:very fine]
/* [Base and border] */
base_thickness=2;
// Lenght must be larger than or equal width
base_length=30;
base_width=16;
border_thickness=1;
// recommend equal to text depth
border_depth=2;
// If you choose "No" you will get just the ring   
use_base = "Yes"; //["Yes":Yes,"No":No]

/* [Hidden] */
pi = 3.14;

// ************* Executable part *************
use <write/Write.scad>

assembly();

// ************* Module part *************

module assembly() {
	if (use_base == "Yes"){
		rotate([ 0, 0, 90 ])
			top();
	}
	difference(){
		ring();
		if (use_childrens_cut == "Yes"){
			childrenscut();
		}
	}	
}

module top(){
	translate([0,0,(ring_size/pi+ring_thickness)/2+base_thickness+text_depth/2])
		write(text,t=text_depth,h=font_size,center=true,font=font);
difference(){
	translate([(base_width-base_length)/2,0,(ring_size/pi+ring_thickness)/2+(border_depth+base_thickness)/2])
		linear_extrude(height = border_depth+base_thickness, center = true, convexity = 10, twist = 0)
			hull() {
   			translate([base_length-base_width,0,0]) circle(base_width/2,$fn=resolution);
   				circle(base_width/2,$fn=resolution);
 			}
	translate([(base_width-base_length)/2,0,(ring_size/pi+ring_thickness)/2+border_depth/2+base_thickness+0.05])
		linear_extrude(height = border_depth+0.1, center = true, convexity = 10, twist = 0)
			hull() {
   			translate([base_length-base_width,0,0]) circle(base_width/2-border_thickness,$fn=resolution);
   				circle(base_width/2-border_thickness,$fn=resolution);
 			}
	}
}

module ring(){
	translate([ -(ring_width-ring_thickness)/2, 0, 0])
		rotate([ 0, 90, 0])
			rotate_extrude(convexity = 10, $fn = resolution)
				translate([(ring_size/pi+ring_thickness)/2, 0, 0])
					hull() {
   					translate([0,ring_width-ring_thickness,0]) circle(ring_thickness/2,$fn=resolution);
   					circle(ring_thickness/2,$fn=resolution);
					}
}

module childrenscut() {
	rotate([ -90, 0, -90])
		linear_extrude(height = ring_width, center = true, convexity = 10, twist = 0)
			polygon(points=[[-(ring_size/pi)/2,0],[(ring_size/pi)/2,0],[0,(ring_size/pi+ring_thickness)/3*2]], paths=[[0,1,2]]);
}