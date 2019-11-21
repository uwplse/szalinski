/*
 * CC BY-NC 4.0
 * https://creativecommons.org/licenses/by-nc/4.0/
 *
 * Author: Kevin Lam (kevinlam@bbs2.hk)
 *
 */

/* setup */
part = "holder"; // [holder: Holder, bar: Bar holding the roll]

width = 120;
height = 130;

// excluding the arms
depth = 55;

// this affect the strength of the frame
thickness = 4;
// this affect the width at the sides of the frame
padding = 8;

// Distance from the bar to the back, i.e., arm length
bar_z = 90;

// this is the width of the bar holding the roll
bar_width = 135;    
bar_diameter = 26;  // diameter of bar


module back() {
    corner = thickness*cos(135/2);
    
    difference() {
        translate([-width/2,0,depth])
        rotate(90,[0,1,0])
        linear_extrude(width)
        polygon([
            [0,height/2],
            [depth/2, height/2],
            [depth, (height-depth)/2],
            [depth, -(height-depth)/2],
            [depth/2, -height/2],
            [0,-height/2],
            [0,-height/2+thickness],
            [depth/2-corner, -height/2+thickness],
            [depth-thickness, -(height-depth)/2+corner],
            [depth-thickness, (height-depth)/2-corner],
            [depth/2-corner, height/2-thickness],
            [0,height/2-thickness]
        ]);
        translate([0, 0, (depth-padding)/2+thickness])
            cube([width-padding*2,height*2,depth-padding-thickness], center=true);
        cube([width-padding*2, (height-depth)-padding*2, thickness*4], center=true);
    }
}

module holder_arm_outer(arm_height, hyp, tang, arm_angle) {

    polygon([
        [0,-arm_height/2],
        [tang * sin(arm_angle), -arm_height/2+tang*cos(arm_angle)],
        [bar_z, 0],
        [bar_z/2, 0],
        [0,0]
    ]);
    
}


module holder_arm_inner(arm_height, hyp, tang, arm_angle) {

    upperangle = atan2(bar_z, arm_height);
    polygon([
        [padding, -arm_height/2+padding/tan(arm_angle)+padding/sin(arm_angle) ],
        [(arm_height/2-padding-padding/sin(arm_angle))*tan(arm_angle), -padding],
    [padding,-padding],
        [(arm_height/2+padding-padding/sin(arm_angle))/arm_height*bar_z, -padding],
        [padding, -padding]
    ]);
    
}

module holder_ring(arm_height, arm_angle) {
    translate([bar_z, 0, 0]) {
        difference() {
            circle(bar_diameter/2+thickness);
            circle(bar_diameter/2);
            translate([-bar_diameter/2-thickness,0,0])
                square(bar_diameter+thickness*2);
        }
    }
}

module holder_ring_outer() {
    translate([bar_z, 0, 0]) {
        difference() {
            circle(bar_diameter/2+thickness);
        }
        translate([-bar_diameter/2-thickness,0,0])
            square([bar_diameter+thickness*2, bar_diameter+thickness*2]);
    }
}

module holder_arm() {
    
    arm_height = (height-depth);
    hyp = sqrt(pow(arm_height/2,2) + bar_z*bar_z);
    hyp_angle = atan2(bar_z, arm_height/2);
    
    tang = sqrt(hyp*hyp - pow(bar_diameter/2+thickness,2));
    arm_angle = atan2(bar_z, arm_height/2) + acos(tang/hyp);

    linear_extrude(thickness) {
        difference() {
            holder_arm_outer(arm_height, hyp, tang, arm_angle);
            holder_arm_inner(arm_height, hyp, tang, arm_angle);
            
            holder_ring_outer();
        }
    }

    
    linear_extrude(bar_width/2-width/2+thickness) {
        holder_ring(arm_height,arm_angle);
    }
    
    
    translate([bar_z, 0, bar_width/2-width/2+thickness])
        linear_extrude(thickness) {
            difference() {
                circle(bar_diameter/2+thickness);
                translate([-bar_diameter,0,0])
                    square(bar_diameter*2);
            }
        }

}

module holder() {
    back();

    translate([-width/2+1*thickness,0,0])
        rotate(-90,[0,1,0]) {
            holder_arm();
        }

    translate([width/2-1*thickness,0,0])
        mirror([1,0,0])
        rotate(-90,[0,1,0])
           holder_arm();
}

module bar() {
    cylinder(bar_width/2, bar_diameter/2, bar_diameter/2*0.9);
    translate([0,0,bar_width])
    rotate(180, [0,1,0])
        cylinder(bar_width/2, bar_diameter/2, bar_diameter/2*0.9);
}


// I like it this way :D
$fn = 64;

print_part();

module print_part() {
	if (part == "holder") {
        holder();
	} else if (part == "bar") {
        bar();
	}
}
