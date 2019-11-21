// Customizable Ord Bot Z-Wobble Suppressor

// CUSTOMIZER VARIABLES

$fn=36;

// Height of suppressor
height=9.5;
// Thickness of parts (This is the width of the makerslide gap)
thickness=5.2;
// Width of plate which will mount to your Z screw
mount_width=33;
// Offset between mount plate and arm.
offset=3;
// Length of arm, this needs to reach the makerslide gap.
arm_length=40;
// Diameter of screw holes.
hole_diameter=5.0;
// Separation between screw holes (center to center).
hole_separation=18.5;

difference(){
	linear_extrude(height=height){
		union(){
			// mount plate
			square([mount_width, thickness]);
			// anti-wobble arm
			translate([-arm_length,offset,0]) square([arm_length,thickness]);
		
			// attach them
			polygon(points=[[-5-thickness,offset],[0,offset+thickness],[0,thickness],[0,0], [-5,0]],paths=[ [0,1,2,3,4,5] ]);
		}
	}
	rotate([-90,0,0]) translate([(mount_width-(hole_separation))/2,0,0]) translate([0,-height/2,-1]) cylinder(r=hole_diameter/2, h=thickness+2);
	rotate([-90,0,0]) translate([(mount_width-(hole_separation))/2 + (hole_separation),0,0]) translate([0,-height/2,-1]) cylinder(r=hole_diameter/2, h=thickness+2);
}
