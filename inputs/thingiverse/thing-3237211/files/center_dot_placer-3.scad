placer=0; //1 = Generate a Placement tool, so you can use it to place the center dot through the locator tool. 0 = Don't generate. 
locator=1; // 1 = Generate a Locator tool, which is the main tool, 0= Don't generate

arms=3; //Accepts 3 or 4, if you wanted to use more, you'd need to modify the code. Especially the 150*(4-arms)

mirror_diameter=152;
arm_height=3;
arm_width=20;
arm_cutout=60; //along half of each arm
support_height=20;
support_thickness=5;
center_dot_diameter=14; 

center_dot_hole_diameter=center_dot_diameter+0.5; //If using placer, you might add 0.1 - 0.5mm 
center_dot_inner_diameter=4;
close_distance=0; //0 for flat supports touching the mirror, 1 or more for a round support.

placer_length=30;
placer_diameter=center_dot_diameter;

$fn=50;


module locator() {
difference(){
union(){
	//cube([mirror_diameter+support_thickness*2, arm_width, arm_height], center=true);
	
	for (i = [0:arms-1]) {
		rotate([0,0,(360/arms)*i]) {
	translate([mirror_diameter/2-close_distance,-arm_width/2,-arm_height/2-support_height])
		cube([support_thickness+close_distance, arm_width, support_height]);
		}
		rotate([0,0,(360/arms)*i+150*(4-arms)]){ 
			
			translate([0,(mirror_diameter+support_thickness*2)/4,0])
		cube([arm_width, (mirror_diameter+support_thickness*2)/2,  arm_height], center=true);
		}
	}
	
} //union
	translate([0,0,-arm_height/2-support_height])
	cylinder(h=support_height, r=mirror_diameter/2);
	cylinder(h=arm_height*2,r=center_dot_hole_diameter/2, center=true);
    if (arm_cutout > 0) {
	for (i = [0:arms-1]) {
		rotate([0,0,(360/arms)*i]) 
	translate([mirror_diameter/4+center_dot_hole_diameter/2,0,0])
		cube([arm_cutout, arm_width/2, arm_height*2], center=true);
	}
}
}
}


module placer() {
		cylinder(h=placer_length,r=center_dot_diameter/2, center=true);
	
	
}

if (locator == 1 )
locator();
if (placer == 1)
placer();