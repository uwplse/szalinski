/*
 * Juicer Pusher for Waring JEX328
 * @model JEX328
 *
 * @author Ivan Mihov
 * @email ivan@imihov.com
 * @web imihov.com
 * @date 06/19/2018
 */

//=============================
//Render Variables
//=============================
$fn=150;

//=============================
//Part Variables in mm
//=============================
top_shaft_height = 54;
bottom_shaft_height = 15;
radius = 35;
cross_section_cut = 34;

ring_thickness = 5;
ring_diameter_offset = 5;

// Build the top section of the pusher
module topShaft() {
	translate([0,0,top_shaft_height+(2*bottom_shaft_height)+ring_thickness]) difference(){
		cylinder(r=radius, h=2*top_shaft_height,  center=true);
		translate([cross_section_cut,0,0])
            cube([radius*2,radius*2+ring_thickness,2*top_shaft_height+1], center=true);
	}
}

// Build the bottom section of the pusher
module bottomShaft() {
	translate([0,0,bottom_shaft_height]) difference(){
		cylinder(r=radius, h=2*bottom_shaft_height,  center=true);
		translate([cross_section_cut,0,0])
            cube([radius*2,radius*2+ring_thickness,2*bottom_shaft_height+1], center=true);
	}
}

// Build the ring (stopper) around the pusher
module ring() {
    translate([0,0,2*bottom_shaft_height+ring_thickness/2]) difference() {
        cylinder(r=(radius)+ring_diameter_offset, h=ring_thickness,  center=true);
        translate([cross_section_cut+ring_diameter_offset,0,0])
            cube([radius*2,(radius*2)+(ring_diameter_offset*2),ring_thickness+1], center=true);
    }
}

bottomShaft();
ring();
topShaft();