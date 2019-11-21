/* [Cube] */

height = 10; 
length = 20; 
width = 20; 

/* [Nozzle] */

thickness = 0.4; //[0.1,0.2,0.25,0.3,0.35,0.4,0.5,0.6,0.8]

difference() {
	cube([length,width,height]);
	translate([thickness,thickness,-1]) {
		cube([length-2*thickness,width-2*thickness,height+2]);
	}
}