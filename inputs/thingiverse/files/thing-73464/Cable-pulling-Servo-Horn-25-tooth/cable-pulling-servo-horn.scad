//---------------------------------------------------------------------------------
//-- Cable-pulling Servo Horn
//-- By William M. Hilton (wmhilton) wmhilton@gmail.com / wmhilton@drexel.edu
//-- Derived from "Servo wheel" by Juan Gonzalez (obijuan) juan@iearobotics.com
//---------------------------------------------------------------------------------
//-- A partial wheel with tie-off points, so that a servo can pull a cable.
//---------------------------------------------------------------------------------

// Customizable parameters
// The amount of degrees which you want to be able to pull.
angle = 120;
// The diameter of the cable or line being pulled.
cable_diameter = 0.75;
// The depth of the notch in the wheel. Should be >= your cable diameter.
notch_depth = 1.7;
// The outer diameter of the wheel.
wheel_diameter = 40;
// The height of the wheel. Should be >= 2*notch_depth.
wheel_height = 6;
// How much material you want around the spline connection. Has to be > 6mm.
servo_mount_diameter = 10;
// I ONLY TESTED WITH A 25 TOOTH SERVO. I have no idea if this would generate a reasonable 23 or 24 tooth horn.
num_teeth = 25;

// Computed parameters
cable_radius = cable_diameter/2;
wheel_radius = wheel_diameter/2;
servo_mount_radius = servo_mount_diameter/2;
// Calculate notch dimensions
//notch_depth = cable_radius + cable_radius*sqrt(2);
notch_height = 2*notch_depth;
inner_radius = wheel_radius - notch_depth;
//wheel_height = 2*notch_height;
// Calculate trimming dimensions
extra_theta = asin(servo_mount_radius/wheel_radius);
true_angle = angle+2*extra_theta;
// Calculate tie off hole placement. Tie off holes are 2mm in from the notch radius.
hole_enter_distance = inner_radius + cable_radius*sqrt(2);
hole_exit_x = inner_radius*cos(extra_theta) - 2 - cable_radius;
hole_angle = atan((hole_enter_distance - hole_exit_x)/servo_mount_radius);
//hole_offset_y = hole_exit_distance*sin(extra_theta);
//hole_offset_x = hole_enter_distance - hole_exit_distance*cos(extra_theta);
//hole_angle = atan(hole_offset_x/hole_offset_y);

main();

module main() {
	difference() {
		union() {
			rotate([0,0,-extra_theta])
			difference() {
				// Base wheel.
				cylinder(r=wheel_radius,h=wheel_height,$fn=100);
			
				// Cut to angle.
				cut_pie(wheel_radius,wheel_height,true_angle);
			}

			// Give the servo attachment area some circular space.
			cylinder(r=servo_mount_radius,h=wheel_height,$fn=100);

			// Add filler material on sides to give it a nice concave look.
			translate([0,-servo_mount_radius,0])
			cube([wheel_radius*cos(extra_theta),servo_mount_radius,wheel_height]); // Bottom right edge

			rotate([0,0,angle])
			cube([wheel_radius*cos(extra_theta),servo_mount_radius,wheel_height]); // Left edge
		}
		
		// Put notch in rim.
		translate([0,0, wheel_height/2-notch_depth]) // Center along rim
		rotate_extrude($fn=100)
		polygon([[inner_radius,notch_height/2],[wheel_radius+1,notch_height+1],[wheel_radius+1,-1]]);
	
		// Subtract servo mount.
		servomount(counter_sink_height=wheel_height, counter_sink_diameter=7.0);

		// Holes for tying cable off.		
		translate([hole_exit_x,-servo_mount_radius,wheel_height/2]) 
		rotate([0,0,-hole_angle]) 
		rotate([-90,0,0]) 
		translate([0,0,-2])
		cylinder(r=cable_diameter,h=wheel_diameter,$fn=6); 

		mirror([cos(angle/2+90),sin(angle/2+90),0])
		translate([hole_exit_x,-servo_mount_radius,wheel_height/2]) 
		rotate([0,0,-hole_angle]) 
		rotate([-90,0,0]) 
		translate([0,0,-2])
		cylinder(r=cable_diameter,h=wheel_diameter,$fn=6); 

	}
}

//---------------------------------------------------------------------------------
//-- Pie Cut
//-- By William M. Hilton (wmhilton) wmhilton@gmail.com / wmhilton@drexel.edu
//---------------------------------------------------------------------------------
//-- Generate a solid that can be subtracted from a cylinder to make a pie-shape.
//---------------------------------------------------------------------------------
module cut_pie(radius,height,degrees) {
	angle_to_remove = 360 - degrees;
	bite_size = 30;	
	num_bites = ceil(angle_to_remove/bite_size);
	last_bite_size = angle_to_remove - bite_size*(num_bites-1);
	echo(str("angle_to_remove: ",angle_to_remove));
	echo(str("num_bites: ",num_bites));
	echo(str("last_bite_size: ",last_bite_size));
	if (angle_to_remove <= bite_size) {
		bite(angle_to_remove,radius,height);
	} else {
		for (i=[0:num_bites-2]){
			rotate([0,0,-i*bite_size])
			bite(bite_size+1,radius,height);
			echo(str("i=",i));
		}
		#rotate([0,0,-(num_bites-1)*bite_size])
		bite(last_bite_size,radius,height);
	}
}

module bite(delta,radius,height) {
	linear_extrude(height=height)
	polygon([
		[0,0],
		[radius,0],
		[radius,-radius*tan(delta)]
	]);
}

//---------------------------------------------------------------------------------
//-- Servo Spline (Female)
//-- By William M. Hilton (wmhilton) wmhilton@gmail.com / wmhilton@drexel.edu
//---------------------------------------------------------------------------------
//-- A negative model of the part of a servo horn that attaches to the splines.
//---------------------------------------------------------------------------------
module tooth(num_teeth, outer_diameter, inner_diameter) {
	// The .99 keeps the teeth from overlapping, which seems to cause tremendous trouble.
	polygon([
		[outer_diameter/2,0],
		[inner_diameter/2*cos(180/num_teeth), inner_diameter/2*sin(180/num_teeth)*.99],
		[inner_diameter/2*cos(180/num_teeth),-inner_diameter/2*sin(180/num_teeth)*.99]
	]);
}

module splinewheel(spline_height,num_teeth,outer_diameter,inner_diameter) {
	union() {
		linear_extrude(height=spline_height)
		for (i=[1:num_teeth])
		{
			rotate([0,0,i*360/(num_teeth)])
			tooth(num_teeth, outer_diameter, inner_diameter);
		}
		linear_extrude(height=spline_height)
		circle(r=inner_diameter/2,center=true,$fn=6*num_teeth);
	}
}

module servomount(counter_sink_height=1.5, counter_sink_diameter=6.0, num_teeth=25) {
	spline_height = 3.8;
	outer_diameter = 6.1; //This is what I increased from v1 to v2. Was 6.0, now 6.1. Hopefully it'll not be such a tight press fit.
	inner_diameter = 5.3;
	screw_diameter = 3.0;
	splinewheel(spline_height,num_teeth,outer_diameter,inner_diameter);
	cylinder(r1=outer_diameter/2,r2=0,h=outer_diameter/2,$fn=100);
	cylinder(r=screw_diameter/2,h=spline_height+0.9+counter_sink_height,$fn=100);
	translate([0,0,spline_height+0.9])
	cylinder(r=counter_sink_diameter/2,h=counter_sink_height,$fn=100);
}



