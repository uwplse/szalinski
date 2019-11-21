cap_height = 3;

// should the cylinder hole taper towards the top for a snug fit?
taper_shaft = "yes"; // [yes,no]

// how tall should the base be?
body_height = 40; // [6:40]

shaft_height = body_height - 12;

// What's the diameter of the shaft?
shaft_diameter = 16; // [3:30]

// do you need to put a nut under the cap? Yes you do.
nut_under_cap = "yes"; // [yes,no]


// M size of nut
nut_size = 4; // [3,4,5,6]
// thickness of nut
nut_thickness = 6; // [3,4,5,6,7,8,9,10]
// how high
nut_height = shaft_height - nut_thickness; 



color([1,0,0]) translate ([0,0,]) rotate ([0,0,0]) 

difference() {

union(){
	// top bevel
    translate ([0,0,body_height]) rotate ([0,0,0]) cylinder(h=3,r2=32/2,r1=36/2,$fn=200,center = false);
    
    // main body
	translate ([0,0,0]) rotate ([0,0,0]) cylinder(h=body_height,r=36/2,$fn=200,center = false);
}

union(){
	translate ([0,0,-1]) rotate ([0,0,0]) cylinder(h=body_height+cap_height+2,r=4/2,$fn=100,center = false);
	if(taper_shaft == "yes")
    {
        translate ([0,0,-1]) rotate ([0,0,0]) cylinder(h=shaft_height,r2=(shaft_diameter-0.5)/2, r1=shaft_diameter/2,$fn=100,center = false);
	}
    else
    {
        translate ([0,0,-1]) rotate ([0,0,0]) cylinder(h=shaft_height,r=shaft_diameter/2,$fn=100,center = false);
    }
    if(nut_under_cap == "yes")
    {
        translate ([0,0,shaft_height-2]) cylinder(r=nut_size+0.2, h=nut_thickness, $fn=6, center = false);
    }

// indexing slots on top of the beveled cap
    translate ([0,7,body_height+1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);
	translate ([0,-7,body_height+1]) rotate ([90,0,0]) cube ([16.4,4.1,3.4],center = true);

}

}

