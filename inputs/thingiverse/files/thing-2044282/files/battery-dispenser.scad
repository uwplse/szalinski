/////////////////////////////////////////////////////////////////////
// Battery dispenser
/////////////////////////////////////////////////////////////////////

// Common rechargeable battery sizes:
// AA:		50.5 x 14.5
// AAA:		44.5 x 10.5
// 18650:	65.2 x 18.6

// Length of the battery. Leave a little margin for error (0.5-1mm is good).
battery_length = 51;

// Diameter of the battery. Leave a little margin for error (0.5-1mm is good).
battery_diameter = 15;

// How many batteries per level of the dispenser. Minimum 2.
batteries_per_level = 4.5;

// How many levels. Minimum 1.
levels = 5;

// The angle of the slope for each level.
ramp_angle=4;

// The ratio of diameter to curve at the end of each level. Values between 1.0 and 2.0 are valid.
drop_ratio = 2;

// The thickness of the front, back, top and bottom walls and slopes. Usually a good formula for this is 8 * nozzle_size + gap
main_wall = 3.5;

// The thickness of the side walls.
side_wall = 1.5;

// Height of the plastic lip that stops the one battery falling out the side of the tray.
lip_retainer = 2.5;

// How much the lip juts out. A good value is usually the battery diameter.
lip_length = 15;

// How much ceiling is cut away so the battery can be taken out. A good value is usually the battery diameter.
lip_cutaway_length = 15;

// How big the windows are on the sides so you can see the batteries in the dispenser
window_size = 5;

// How much overlap to create for each side, for when they are stuck together.
overlap = 15;

// How much additional space to leave as error tolerance for the overlap.
gap = 0.3;

// Which parts to print
parts_to_print = "both"; //[left,right,both]

// Generate the screw wall mount sections
print_wall_mount = false;

// How far in to the left/right should the hole for wall mounting be
wall_mount_hole_x_offset = 5;

// How far off center (up/down) should the hole for wall mounting be
wall_mount_hole_y_offset = -3.5;

// How big the hole needs to be to pass over the head of the screw
screw_head_diameter = 7;

// The diameter of the shaft.
screw_shaft_diameter = 4;

// The length of the offset of the shaft hole vs the head hole.
screw_shaft_length_multiplier = 1.4;

// Some additional required calculations
$fn=96*1;
eps = 0.001*1;
outer_length = battery_length+side_wall*2;

if (parts_to_print == "left" || parts_to_print == "both") {
	main_left();
}
if (parts_to_print == "right" || parts_to_print == "both") {
	main_right();
}

module main_right() {
	mirror()
	translate([-cos(ramp_angle)*battery_diameter*(batteries_per_level-0.5)-main_wall-1,0,0])
	difference() {
		union() {
			outer(outer_length/2,main_wall);
			wall_mount();
		}
		translate([0,0,side_wall])
			battery_path(skip_top_rim=true);
		window_path(window_size,side_wall);
		lip_cutaway(outer_length,main_wall,side_wall);
		translate([0,0,side_wall+outer_length/2-overlap]) {
			battery_path(radius_offset=main_wall/2+gap/2,skip_top_rim=true);
			base(outer_length,main_wall/2+gap/2);
			lip_cutaway(outer_length,main_wall/2+gap/2,0,main_wall+gap);
		}
	}
}

module main_left() {	
	translate([-cos(ramp_angle)*battery_diameter*(batteries_per_level-0.5)-main_wall-1,0,0])
	difference() {
		union() {
			outer(outer_length/2,main_wall);
			outer(outer_length/2+overlap-side_wall-gap,main_wall/2-gap/2,skip_top_rim=true);
			wall_mount();
		}
		translate([0,0,side_wall])
			battery_path();
		window_path(window_size,side_wall);
		lip_cutaway(outer_length,main_wall,side_wall);
	}
}

module outer(length,wall,skip_top_rim=false) {
	battery_path(radius_offset=wall,length=length,skip_top_rim=skip_top_rim);
	base(length,wall);
	lip_outer(length,wall);
}

module base(length,wall) {
	hull() {
		translate([-cos(ramp_angle)*lip_length,-sin(ramp_angle)*lip_length,0])
		translate([0,-(battery_diameter/2+wall),0])
			cube([battery_diameter+wall*2,battery_diameter/2+wall*2,length]);			
		translate([battery_diameter*(batteries_per_level-1)*cos(ramp_angle),-sin(ramp_angle)*lip_length,0])
			cylinder(r=battery_diameter/2+wall, h=length);
		translate([battery_diameter*(batteries_per_level-1)*cos(ramp_angle),sin(ramp_angle)*battery_diameter*(batteries_per_level-1),0])
			cube([battery_diameter/2+wall,battery_diameter/2+eps,length]);
	}
}

module wall_mount() {
	if (print_wall_mount && levels >= 3) {
		wall_mount_plate(3);
	}
	if (print_wall_mount && levels >= 5) {
		wall_mount_plate(levels);
	}
}

module wall_mount_plate(offset) {
	x_offset = (battery_diameter)*(0.5+cos(ramp_angle)*(batteries_per_level-1))+cos(ramp_angle)*(main_wall/2+gap/2);
	y_offset = (battery_diameter+main_wall/2)*(0.5+sin(ramp_angle)*(batteries_per_level-1))*(floor((offset+1)/2)*3-5);
	
	translate([x_offset,y_offset,0]) 
	difference() {
		cube([main_wall/2-gap/2,(battery_diameter+main_wall)*2,outer_length/2]);
		
		translate([0,battery_diameter+main_wall+wall_mount_hole_y_offset,screw_head_diameter/2+wall_mount_hole_x_offset]) {
			rotate([0,90,0])
				cylinder(r=screw_head_diameter/2, h=main_wall/2-gap/2);
		
			shaft_offset=screw_head_diameter/2+screw_shaft_diameter*(screw_shaft_length_multiplier-1);
			
			translate([0,0,-screw_shaft_diameter/2])
				cube([main_wall/2-gap/2,shaft_offset,screw_shaft_diameter]);
			
			translate([0,shaft_offset,0])
			rotate([0,90,0])
				cylinder(r=screw_shaft_diameter/2, h=main_wall/2-gap/2);
		
		}
	}
}



module lip_outer(length,wall) {
	hull() {
		rotate([0,0,ramp_angle])
		translate([-(battery_diameter/2+wall),-(battery_diameter/2+wall),0])
			cube([battery_diameter+wall*2,battery_diameter+wall*2,length]);
		
		rotate([0,0,ramp_angle])
		translate([-lip_length,0,0])
			cylinder(r=battery_diameter/2+wall, h=length);
	}
}

module lip_cutaway(length,wall,side_wall_height,radius_offset=0,) {
	translate([0,0,-eps])
	rotate([0,0,ramp_angle]) {
		hull() {
			translate([-(battery_diameter+radius_offset)/2+0.5,-(battery_diameter+radius_offset)/2,side_wall_height])
				cube([battery_diameter+radius_offset+1,battery_diameter+radius_offset,length]);
			
			translate([-lip_length,0,side_wall_height])
				cylinder(r=(battery_diameter+radius_offset)/2, h=length);
		}
		
		translate([-lip_length-battery_diameter*0.5,0,side_wall]) {
			cube([lip_cutaway_length,battery_diameter/2+wall,length]);
		}
		
		translate([-lip_length,lip_retainer,0]) {
			hull() {
				rotate([0,0,180])			
					partCylinder(r=battery_diameter/2, h=length,a=90);
				
				translate([lip_length-battery_diameter,0,0])
				rotate([0,0,270])			
					partCylinder(r=battery_diameter/2, h=length,a=90);
			}
			
			translate([-battery_diameter*0.5,0,0])
				cube([lip_cutaway_length,battery_diameter/2+wall-lip_retainer,length]);
		}
	}
}

module battery_path(radius_offset=0,length=outer_length,skip_top_rim=false,skip_first=false) {
	radius = battery_diameter/2+radius_offset;
	angle_offset = battery_diameter*sin(ramp_angle)*(batteries_per_level-1);
	drop_offset = battery_diameter/2-(drop_ratio*battery_diameter/2);
	for (l=[0:levels-1]) {
		if (l%2 == 0) {
			translate([0,l*(battery_diameter+angle_offset),0])
				level(radius_offset,length,skip_start=l==0);
		} else {
			translate([0,l*battery_diameter+(l+1)*angle_offset,0])
			mirror([0,1,0])
				level(radius_offset,length);
		}
	}
	
	if (skip_top_rim == false) {
		y_offset = (levels-1)*battery_diameter+(levels)*angle_offset+battery_diameter/2;
		if (levels%2 == 0) {		
			translate([0,y_offset,0]) {
				translate([-radius,0,0])
					cube([radius_offset,main_wall/2,length]);
				translate([radius,0,0])
					cube([radius_offset,main_wall/2,length]);
			}
		} else {
			translate([battery_diameter*cos(ramp_angle)*(batteries_per_level-1),y_offset,0]) {
				translate([battery_diameter/2,0,0])	{
					cube([radius_offset,main_wall,length]);
				}
				translate([-radius,0,0]) {
					cube([battery_diameter/2+radius,main_wall,side_wall]);
					cube([radius_offset,main_wall,length]);
				}				
			}
		}
	}
}

module window_path(diameter,length) {
	radius = diameter/2;
	y_angle_offset = battery_diameter*sin(ramp_angle)*(batteries_per_level-1);
	x_angle_offset = battery_diameter*cos(ramp_angle)*(batteries_per_level-1);
	for (l=[0:levels-1]) {
		translate([0,l*(battery_diameter+y_angle_offset),-eps])
		if (l%2 == 0) {
			hull() {
				cylinder(r=radius, h=length+eps*2);
				translate([x_angle_offset,y_angle_offset,0])
					cylinder(r=radius, h=length+eps*2);
			}			
		} else {
			hull() {
				translate([x_angle_offset,0,0])
					cylinder(r=radius, h=length+eps*2);
				translate([0,y_angle_offset,0])
					cylinder(r=radius, h=length+eps*2);
			}			
		}
	}
}

module level(radius_offset,length,skip_start=false) {	
	radius = battery_diameter/2+radius_offset;		
	
	rotate([0,0,ramp_angle])
	translate([radius,-radius,0])
		cube([battery_diameter*(batteries_per_level-1)-radius*2,radius*2,length]);

	if (skip_start == false)
		end_shape(radius,length);
	
	rotate([0,0,ramp_angle])
	translate([battery_diameter*(batteries_per_level-1),0,0])
	rotate([0,0,180-ramp_angle])
		end_shape(radius,length);
}

module end_shape(radius,length) {
	ca = cos(ramp_angle);
	sa = sin(ramp_angle);
	rthin = battery_diameter/2;
	rdiff = radius - rthin;
	ravg = rthin+rdiff/drop_ratio;
	linear_extrude(height=length,center=false)
	polygon([
		[-radius,-rthin-eps],
		[-radius, ((sa*ca - sa*sa - ca)*rthin)*(drop_ratio-1)],
		[((drop_ratio-1)*(1-sa) - sa)*rthin-sa*rdiff,(ca-(drop_ratio-1)*(sa-ca)*sa)*rthin+ca*rdiff],
		[(ca-sa)*(radius)+ca,(sa+ca)*(radius)+sa],
		[(ca+sa)*(radius)+ca,(sa-ca)*(radius)+sa],
		[rthin,(sa*ca - sa*sa - ca)*radius],
		[rthin,-rthin-eps]			
	]);
		
	translate([(drop_ratio-1)*rthin,((sa*ca-sa*sa-ca)*(drop_ratio-1))*rthin,0])	
	rotate([0,0,ramp_angle+90])	
		partCylinder(ravg*drop_ratio,length,90-ramp_angle);
}

module partCylinder(r,h,a) {
	linear_extrude(height=h,center=false)
	union() 
	for (i=[0:$fn-1]) {
		a1 = i*(a/$fn);
		a2 = (i+1)*(a/$fn);
		polygon([[0,0],[r*cos(a1),r*sin(a1)],[r*cos(a2),r*sin(a2)],[0,0]]);
	}
}

module centerCube(r,h) {
	translate([-r,-r,0])
		cube([r*2,r*2,h]);
}