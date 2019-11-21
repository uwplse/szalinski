/*

Flying saucer
Gian Pablo Villamil
July 2011

Modifiable flying saucer for GE air show

Now with hinged hatch!

*/

saucer_radius = 45;
slice = 100;
radius = sqrt(pow(saucer_radius,2)+pow(slice,2));

num_legs = 3;
gear_radius = 20;
leg_length = 15;
leg_radius = 2;
foot_radius = 3.5;

num_bumps = 12;
bump_spacing = 30;
bump_radius = 5;
bump_offset = 3.5;

hinge_female_width = 5;
hinge_male_width = 2.5;
hinge_rad = 1.5;

gap = 0.1;

module registration_pins() {
	for (i=[0:2]) {
			translate([sin(360*i/3)*20,cos(360*i/3)*20,0])
			rotate([0,0,0])
			cylinder(r=1.5,h=10,center=true,$fn=12);
		}
}


module female_hinge() {
	difference() {
		union() {
		cylinder(r=hinge_rad,hinge_female_width,center=false,$fn=16);
		translate([-hinge_rad,-4,])
		cube([hinge_rad*2,4,hinge_female_width]);
		}
		sphere(1,$fn=18);
		translate([0,0,hinge_female_width])
		sphere(1,$fn=18);
	}
}

module male_hinge() {
	cylinder(r=hinge_rad,hinge_male_width,center=false,$fn=16);
	translate([0,-hinge_rad,0])
	cube([6,hinge_rad*2,hinge_male_width]);
	translate([0,0,hinge_male_width])
	sphere(0.8,$fn=18);
}

module hinge_assembly() {
	rotate([90,0,0]) translate([0,0,-hinge_female_width/2])
		female_hinge();
	rotate([270,0,0]) translate([0,0,-hinge_female_width-gap])
		male_hinge();
	rotate([90,0,0]) translate([0,0,-hinge_female_width-gap]) rotate([0,0,180])
		male_hinge();
}

module male_hinge_assembly() {
	rotate([270,0,0]) translate([0,0,-hinge_female_width-gap])
		male_hinge();
	rotate([90,0,0]) translate([0,0,-hinge_female_width-gap]) 
		male_hinge();
}

module female_hinge_assembly() {
	rotate([90,0,0]) translate([0,0,-hinge_female_width/2])
		female_hinge();
}

module half_saucer() {
	difference() {
		translate([0,0,-slice])
		sphere(r=radius, $fn = 128);
		translate([-radius,-radius,-radius-slice])
		cube([radius*2,radius*2,radius+slice],center=false);
		#registration_pins();
	}
}


module leg() {
	cylinder(h = leg_length, r=leg_radius,$fn=18);
	translate([0,0,leg_length])
	sphere(r=foot_radius, $fn=18);
}

module landing_gear() {
	for (i = [0:(num_legs - 1)]) {
		translate([sin(360*i/num_legs)*gear_radius, cos(360*i/num_legs)*gear_radius, 5 ]) rotate(a = 10, v = [sin(360*i/num_legs-90),cos(360*i/num_legs-90),0]) 
		leg();
	}
}

module bump(radius) {
	difference() {
		sphere(r=radius, $fn=48);
		translate([-radius,-radius,-radius]) cube([radius*2,radius*2,radius]);
	}
}

module bumps() {
	skew = 15;
	for (i = [0:(num_bumps - 1)]) {
		translate([sin(360*i/num_bumps+skew)*bump_spacing, cos(360*i/num_bumps+skew)*bump_spacing, bump_offset ])  
		bump(bump_radius);
	}
}

module top_bump(bump_od,bump_thickness) {
	offset = 3;
	num_windows=6;
	difference() {
		union() {
			difference() {
				bump(bump_od);
				translate([0,0,15])
					cylinder(r1=10,r2=15,h=5);
			}
			translate([-12.5,0,16.5])
				female_hinge_assembly();
		}
		for(i=[0:num_windows-1]) {
			rotate([0,-10,i*(360/num_windows)])
			translate([0,0,7])
			rotate([0,90,0])
			cylinder(r=5,h=25,$fn=24);
		}
		bump(bump_od-bump_thickness);
	translate([-12.5,0,16.5])
	male_hinge_assembly();

	}
}

module hatch() {
	difference() {
		intersection() {
			bump(20);
			translate([0,0,15])
			cylinder(r1=10,r2=15,h=5);
		}
	}
	translate([-12.5,0,16.5])
	male_hinge_assembly();

}

module bottom_half() {
	union() {
		half_saucer();
		rotate([0,0,30])
		landing_gear();
		bumps();
		translate([0,0,6])
		cylinder(r1=15,r2=10,h=8);
	}
}

module top_half() {
	union() {
		half_saucer();
		translate([0,0,5])
		top_bump(20,2);
		bumps();
	}
}

translate([0,0,5])
hatch();
top_half();
rotate([0,180,0])
bottom_half();


// build platform reference - idea from tbuser
//%cube([100, 100, 1], center=true);