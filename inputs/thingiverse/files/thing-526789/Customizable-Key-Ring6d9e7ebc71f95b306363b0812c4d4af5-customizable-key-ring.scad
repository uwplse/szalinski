
/* [Keyring]*/
// Diameter of the ring
ring_diameter = 20; 
// Thickness of the ring
ring_thickness = 4;
// Length of the ring
hole_length = 25;

/* [Hidden]*/
diameter = ring_diameter;
rad = diameter/2;
length=hole_length - 2*rad;
rounded = 1;    // the mm width of the bevelled edge
thickness = ring_thickness-2*rounded;
overhang = 40;  // the angle of overhang your printer can manage (no need to exceed 45)
facets = 100;

keyring();

/* Module for the keyring */
module keyring(){
    difference(){
        ring();
        clasp();
    }
}

/* Module for the clasp */
module clasp(){
    ring_thickness = thickness+2*rounded;
    translate([length/2,(rad+thickness/2),ring_thickness/2]){
        difference(){
        cube([ring_thickness,ring_thickness,ring_thickness],true);
        rotate([0,90,0]){
            translate([0,0,-(ring_thickness)/2])
            diamond(ring_thickness,overhang);
            translate([0,0,(ring_thickness)/2])
            diamond(ring_thickness,overhang);
        }
    }
}
}

/* Module for the ring */
module ring(){
    minkowski(){
        translate([0,0,thickness/2+rounded])
        difference() {
            oval(thickness, rad+thickness,length);
            oval(thickness, rad,length);
         }
    diamond(rounded*2,overhang);
    }
}

/* Module to create an oval */
module oval(thickness,rad,length){
     hull(){
        translate([0,0,0])
        cylinder (h = thickness, r=rad, center = true, $fn=facets);
        translate([length,0,0])
         cylinder (h = thickness, r=rad, center = true, $fn=facets);
        
    }
}


// module to round edges
module diamond(diameter,overhang)
{
	difference()
	{
		cube([diameter,diameter,diameter], true);
		for(i=[0:45:179])
		{
			rotate([0,0,i])
			cutter(diameter/2, overhang);
		}
	}
}

// module to create diamond
module cutter(dist, overhang)
{
	size = dist*2;

	translate([dist,-dist,-dist])
	cube([size,size,size]);

	translate([-dist-size,-dist,-dist])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,-overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,-90+overhang,0])
	cube([size,size,size]);

	translate([dist,-dist,0])
	rotate([0,90+overhang,0])
	cube([size,size,size]);

	translate([-dist,-dist,0])
	rotate([0,180-overhang,0])
	cube([size,size,size]);

}


