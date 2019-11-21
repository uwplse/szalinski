/*
 * CC BY-NC 4.0
 * https://creativecommons.org/licenses/by-nc/4.0/
 *
 * Author: Kevin Lam (kevinlam@bbs2.hk)
 *
 */

/* setup */
part = "holder"; // [holder: Holder, bar: Bar holding the roll]

width = 118;
height = 128;

// excluding the arms
depth = 54;

// this affect the strength of the frame
thickness = 2.5;
// this affect the width at the sides of the frame
padding = 8;

// Distance from the bar to the back, i.e., radius of a toilet paper roll
bar_z = 96;

// this is the width of the bar holding the roll, must be larger than width
bar_width = 135;
bar_diameter = 26;  // diameter of bar


module base() {
    slanted_size = min(height/4, depth*cos(45)/(1+cos(45)));
    slanted_height = slanted_size/cos(45);

    translate([0,0,thickness/2]) {
        difference() {
            cube([width, height-slanted_size*2, thickness], center=true);
            cube([width-padding*2, height-slanted_size*2-padding*2, thickness*2], center=true);
        };
    };
}

module slanted() {
    slanted_size = min(height/4, depth*cos(45)/(1+cos(45)));
    slanted_height = slanted_size/cos(45);
    
    support_angle = atan2(width/6, slanted_height);
    support_width = padding/cos(support_angle);

    translate([0, height/2-slanted_size/2-thickness/2*cos(45), thickness/2*cos(45)+slanted_size/2])
    rotate(45, [1,0,0]) {
        difference() {
            cube([width, slanted_height, thickness], center=true);
            cube([width-padding*2, slanted_height-padding*2, thickness*2], center=true);
        }
        translate([0,0,-thickness/2])
        linear_extrude(thickness) {
            polygon([
                [support_width/2, -slanted_height/2],
                [width/6+support_width/2, slanted_height/2],
                [width/6-support_width/2, slanted_height/2],
                [-support_width/2, -slanted_height/2]
            ]);
            polygon([
                [support_width/2, -slanted_height/2],
                [-width/6+support_width/2, slanted_height/2],
                [-width/6-support_width/2, slanted_height/2],
                [-support_width/2, -slanted_height/2]
            ]);
        }
    };
}

module top() {
    slanted_size = min(height/4, depth*cos(45)/(1+cos(45)));
    slanted_height = slanted_size/cos(45);
    top_height = depth - slanted_size;
    
    support_angle = atan2(width/4-width/6, top_height);
    support_width = padding/cos(support_angle);


    translate([0, height/2-thickness/2, depth-top_height/2])
    rotate(90, [1,0,0]) {

        difference() {
            cube([width, top_height, thickness], center=true);
            cube([width-padding*2, top_height-padding*2, thickness*2], center=true);
        };

        translate([0,0,-thickness/2])
        linear_extrude(thickness) {
            polygon([
                [width/6+support_width/2, -slanted_height/2],
                [width/4+support_width/2, slanted_height/2],
                [width/4-support_width/2, slanted_height/2],
                [width/6-support_width/2, -slanted_height/2]
            ]);
            polygon([
                [-width/6+support_width/2, -slanted_height/2],
                [-width/4+support_width/2, slanted_height/2],
                [-width/4-support_width/2, slanted_height/2],
                [-width/6-support_width/2, -slanted_height/2]
            ]);
        }
    }    
}

module side() {
    holder_length = (bar_width - width)/2+thickness*2;
    holder_inner_radius = (bar_diameter/2)/cos(360/16);
    
    top_inner = bar_z - bar_diameter/2 - thickness - holder_length;
    slanted_size = min(height/4, depth*cos(45)/(1+cos(45)));
    slanted_height = slanted_size/cos(45);
    side_center = height/2-slanted_size-thickness/tan(67.5);
    
    
    // solving equation to find positions
    _a = top_inner - thickness;
    _b = side_center;
    
    A = 4*_a*_a-padding*padding;
    B = 2*_b*padding*padding;
    C = -(_a*_a+_b*_b)*padding*padding;
    
    D = sqrt(B*B - 4*A * C);
        
    y = (-B+D) / 2 / A;
    x = sqrt(1/(4 / padding / padding - 1/y/y));
    
    angle = atan2(x,y);
    
    translate([-width/2+thickness,0,0])
    rotate(-90, [0,1,0])
    rotate(-90, [0,0,1]) {
        linear_extrude(thickness) {
            polygon([
                [-height/2, depth],
                [-height/2+thickness, depth],
                [-height/2+thickness+depth, 0],
                [-height/2+thickness+depth-padding/cos(45), 0],
                [-height/2, depth-padding/cos(45)+thickness],
            ]);
        }
    }
    translate([-width/2+thickness,0,0])
    mirror([0,1,0])
    rotate(-90, [0,1,0])
    rotate(-90, [0,0,1]) {
        linear_extrude(thickness) {
            polygon([
                [-height/2, depth],
                [-height/2+thickness, depth],
                [-height/2+thickness+depth, 0],
                [-height/2+thickness+depth-padding/cos(45), 0],
                [-height/2, depth-padding/cos(45)+thickness],
            ]);
        }
    }
       
    translate([-width/2,0,thickness])
    rotate(90, [0,0,1])
    rotate(90, [1,0,0])
    linear_extrude(thickness) {
        difference() {
            polygon([
                [0, top_inner-thickness],
                [side_center-padding/2/sin(angle), -padding/2/tan(angle)],
                [side_center,-padding/2/tan(angle)],
                [side_center+padding/2/sin(angle), padding/2/tan(angle)],
                [0, top_inner+x*2-thickness],
                [-(side_center+padding/2/sin(angle)), padding/2/tan(angle)],
                [-side_center,-padding/2/tan(angle)],
                [-(side_center-padding/2/sin(angle)), -padding/2/tan(angle)],
            ]);
            translate([0,bar_z-thickness])
            rotate(360/16)
                circle(holder_inner_radius, $fn=8);
        }
    }
}

module holder_main() {
    holder_length = (bar_width - width)/2+thickness*2;
    holder_side = 2*(bar_diameter/2+thickness)*tan(360/16);
    holder_inner_radius = (bar_diameter/2)/cos(360/16);
    holder_radius = (bar_diameter/2+thickness)/cos(360/16);
    
    linear_extrude(thickness)
    rotate(360/16)
        circle(holder_radius, $fn=8);
    
    difference() {
        union() {
            rotate(360/16)
            linear_extrude(holder_length)
            difference() {
                circle(holder_radius, $fn=8);
                circle(holder_inner_radius, $fn=8);
            };
            translate([0,-bar_diameter/2-thickness, holder_length])
            rotate(180, [0,1,0])
            linear_extrude(holder_length, scale=[1,0.001])
            translate([-holder_side/2,-holder_length])
                square([holder_side, holder_length]);
        }
        
        translate([-holder_side/2+thickness*tan(360/16),0,holder_length]) 
        rotate(atan2(holder_length-thickness*2, holder_side-2*thickness*tan(360/16)), [0,1,0])
            cube(bar_diameter*4);
        
        translate([0,-bar_diameter*4,holder_length]) 
        rotate(atan2(holder_length-thickness*2, holder_side/2-thickness*tan(360/16)), [0,1,0])
            cube(bar_diameter*4);

    };
   
    rotate(360/16)
    linear_extrude(thickness*2)
    difference() {
        circle(holder_radius, $fn=8);
        circle(holder_inner_radius, $fn=8);
    };
}

module holder_arm() {
    holder_length = (bar_width - width)/2+thickness*2;
    holder_inner_radius = (bar_diameter/2)/cos(360/16);
    
    top_inner = bar_z - bar_diameter/2 - thickness - holder_length;
    side_center = height/4-thickness/tan(67.5);
    
    
    // solving equation to find positions
    _a = top_inner - thickness;
    _b = side_center;
    
    A = 4*_a*_a-padding*padding;
    B = 2*_b*padding*padding;
    C = -(_a*_a+_b*_b)*padding*padding;
    
    D = sqrt(B*B - 4*A * C);
        
    y = (-B+D) / 2 / A;
    x = sqrt(1/(4 / padding / padding - 1/y/y));
    
    angle = atan2(x,y);
    
        
    translate([-width/2,0,thickness])
    rotate(90, [0,0,1])
    rotate(90, [1,0,0])
    linear_extrude(thickness) {
        difference() {
            polygon([
                [0, top_inner-thickness],
                [side_center-padding/2/sin(angle), -padding/2/tan(angle)],
                [side_center+padding/2/sin(angle), padding/2/tan(angle)],
                [0, top_inner+x*2-thickness],
                [0, top_inner+x*2-thickness],
                [-(side_center+padding/2/sin(angle)), padding/2/tan(angle)],
                [-(side_center-padding/2/sin(angle)), -padding/2/tan(angle)],
            ]);
            translate([0,bar_z-thickness])
            rotate(360/16)
                circle(holder_inner_radius, $fn=8);
        }
    }
}

module holder_one() {
    holder_length = (bar_width - width)/2+thickness*2;

    translate([-holder_length-width/2+thickness,0,bar_z])
    rotate(90, [0,0,1])
    rotate(90, [1,0,0])
        holder_main();
    
}

module holder() {
    base();

    slanted();
    rotate(180) slanted();

    top();
    rotate(180) top();
    
    side();
    rotate(180) side();

    holder_one();
    mirror([1,0,0]) holder_one();
   
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
