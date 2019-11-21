

/* [Global] */

/* [Rocket] */

inner_diameter = 10.5;

body_height = 40;  //[10:100]
nose_height = 16; //[2:100]
number_of_fins = 3; //[0:4]
fin_width = 10;  //[2:50]
fin_height = 20;  //[2:100]


/* [Extruder] */
// Width of a single wall/perimeter in mm - adjust to ensure model is sliced correctly
perimeter_width = 0.7;

/* [Hidden] */

// other
eta = 0.001;
perim = perimeter_width;
2perim = 2*perim;



// library functions
module donut(or,ir) {
	difference() {
        circle(or);
    	circle(ir);
    }
}


// rocket functions

module rocketBody() {
	$fn=32;
	
	id=inner_diameter;
	h1=body_height;
	h2=nose_height;
	
	fins = number_of_fins;
	finW = fin_width;
	finH = fin_height;
	 
	union() {
		// body
		linear_extrude(height = h1)
			donut(id/2 + perim, id/2);
		
		// cone
		translate([0,0,h1-eta])
			difference() {
				cylinder(r1=id/2 + perim, r2=2perim, h=h2);
				
				translate([0,0,-eta])
					cylinder(r1=id/2, r2=perim, h=h2);			
			}
			
		// tip
		translate([0,0,h1+h2-2*eta])
			cylinder(r1=2perim, r2=perim, h=2perim);
			
		// fins
		for(i=[0:fins-1])
			rotate([0,0,i*360/fins])
			translate([id/2,0,0])
			rotate([90,0,0])
			linear_extrude(perim)
			polygon(points=[[0,0],[0,finH],[finW,0]]);
	
	}
}


rocketBody();
