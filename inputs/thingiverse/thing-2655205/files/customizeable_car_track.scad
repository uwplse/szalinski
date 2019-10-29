part = "straight"; // [curved_left:Curve Left,curved_right:Curve Right,straight:Straight,intersection:Intersection]

// Interior width of the track.
track_width = 25;
// Length of straight parts compared to width of the track.
track_length_to_width_ratio = 4;
track_length = track_width * track_length_to_width_ratio;
track_lip_width = 2;
track_lip_height = 2;
// Thickness of the track's base. Recommend a minimimum of at least 2mm.
track_base_height = 2;
// Radius of curved track vs. length of a straight track segment.
track_curve_radius_to_length_ratio = 1.3333;  
track_height = track_base_height + track_lip_height;
// Size of the ball joint.
ball_diameter = 10;
// The amount of gap to leave around the joined parts.  Varies by printer.  
join_tolerance = 0.5;  

/* [Hidden] */
$fn = 50;

/*
track_intersection();
translate([0,track_length,0]) track_straight();
translate([0,-track_length,0]) track_straight();
translate([track_length/2,-track_length/2+track_width/2+track_lip_width,0]) rotate([0,0,180]) track_curved_left();
translate([-track_length/2,track_length/2-track_width/2-track_lip_width,0]) rotate([0,0,-90]) track_curved_right();
*/

print_part();

module print_part() {
    if(part == "curved_left") {
        track_curved_left();
    } else if(part == "curved_right") {
        track_curved_right();
    } else if(part == "straight") {
        track_straight();
    } else if(part == "intersection") {
        track_intersection();
    }
}

module track_straight() {
    deck(track_width, track_length, track_base_height);
    translate([-track_width/2-track_lip_width,-track_length/2,0]) cube([track_lip_width, track_length, track_height]);
    translate([track_width/2,-track_length/2,0]) cube([track_lip_width, track_length, track_height]);
}

module track_curved_left() {
    curve_diameter = track_length / (track_curve_radius_to_length_ratio / 2);
    difference() {
        union() {
            difference() {
                cylinder(d=curve_diameter,h=track_height);
                translate([0,0,track_base_height]) cylinder(d=curve_diameter-track_lip_width*2,h=track_height);
            }
            cylinder(d=curve_diameter-((track_width+track_lip_width)*2),h=track_height);
        }
        translate([0,0,-1]) cylinder(d=curve_diameter-((track_width+track_lip_width*2)*2),h=track_height+2);
        translate([-100,0,-1]) cube([200,100,100]);
        translate([0,-100,-1]) cube([100,200,100]);
        translate([-curve_diameter/2+track_lip_width+track_width/2,-ball_diameter,-1]) cylinder(d=ball_diameter,h=track_base_height+2);
        translate([-curve_diameter/2+track_lip_width+track_width/2-ball_diameter/4,-ball_diameter,-1]) cube([ball_diameter/2,ball_diameter+1,track_base_height+2]);
        groove_size = 1;
        for(i=[-200:20:200]) {
            translate([-100,i + 3,0]) rotate([-45,90,0]) rotate([0,0,45]) translate([-groove_size/2,-groove_size/2,0]) cube([groove_size,groove_size,200]);
        }
    }
    translate([ball_diameter,-curve_diameter/2+track_lip_width+track_width/2,0]) cylinder(d=ball_diameter-join_tolerance,h=track_base_height);
    translate([0,-curve_diameter/2+track_lip_width+track_width/2-(ball_diameter/2-join_tolerance)/2,0]) cube([ball_diameter,ball_diameter/2-join_tolerance,track_base_height]);
}

module track_curved_right() {
    mirror() track_curved_left();
}

module track_intersection() {
    deck(track_width, track_length, track_base_height);
    rotate([0,0,90]) deck(track_width, track_length, track_base_height);
    
    for(i=[0:90:270]) {
        rotate([0,0,i]) track_intersection_quadrant();
    }
}

module track_intersection_quadrant() {
    inner_radius = track_width/2;
    difference() {
        union() {
            translate([track_width/2+inner_radius, track_width/2+inner_radius, 0]) cylinder(r=inner_radius, h=track_height);
            translate([track_width/2, track_width/2, 0]) cube([inner_radius, inner_radius, track_base_height]);
        }
        translate([track_width/2+inner_radius, track_width/2+inner_radius, -1]) cylinder(r=inner_radius-track_lip_width, h=track_height+2);
        translate([track_width/2+inner_radius, track_width/2+track_lip_width, -1]) cube([inner_radius*2+1,inner_radius*2+1,track_height*2+2]);
        translate([track_width/2+track_lip_width, track_width/2+inner_radius, -1]) cube([inner_radius*2+1,inner_radius*2+1,track_height*2+2]);
    }
    translate([track_width/2+inner_radius, track_width/2, 0]) cube([track_length/2-track_width/2-inner_radius, track_lip_width, track_height]);
    translate([track_width/2, track_width/2+inner_radius, 0]) cube([track_lip_width, track_length/2-track_width/2-inner_radius, track_height]);
}

module deck(x, y, z) {
    difference() {
        translate([-x/2,-y/2,0]) cube([x,y,z]);
        
        translate([0,-y/2+ball_diameter,-1]) cylinder(d=ball_diameter,h=z+2);
        translate([-ball_diameter/4,-y/2-1,-1]) cube([ball_diameter/2,ball_diameter,z+2]);
        groove_size = 1;
        for(i=[-200:20:200]) {
            translate([-100,i - 13,0]) rotate([-45,90,0]) rotate([0,0,45]) translate([-groove_size/2,-groove_size/2,0]) cube([groove_size,groove_size,200]);
        }
    }
    translate([0,y/2+ball_diameter,0]) cylinder(d=ball_diameter-join_tolerance,h=z);
    translate([-(ball_diameter/2-join_tolerance)/2,y/2,0]) cube([ball_diameter/2-join_tolerance,ball_diameter,z]);
}