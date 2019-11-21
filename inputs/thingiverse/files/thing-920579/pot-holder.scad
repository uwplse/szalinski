// pot_holder.scad
// By Gregg Christopher, 2015. 
// This file is public domain. Use at your own risk.


/* [Canister Bottom Edge Dimensions] */
// Height of the rolled metal portion (Rolled metal bottom of canister) Defaults are for a typical large 230g-ish canister.
edge_height = 4.5; // [0.5:0.1:15.0]
// Width (thickness) of the rolled metal portion
edge_width = 2.7; // [0.5:0.1:10.0]
// Radius to bevel the inside of the clip portion of the canister foot. Probably just cosmetic. 
edge_bevel_radius = 0.5; // [0.01:0.05:2.0]
// Thickness of the thinner metal portion above the rolled edge. Decrease to enlarge the portion of the foot pressing against the canister, if the foot tends to tilt up.
metal_thickness = .8; // [0.1:0.05:3.0]

/* [Holder Foot Dimensions] */
// Option to include a small support directly below the canister; might make it harder to break when set on a flat surface with a heavy load.
include_support_peg = "Include_Support_Peg"; // [No_Support_Peg, Include_Support_Peg]
// Width of the entire support. (Viewed from above as it sticks out from the canister.)
foot_width = 4; // [1.0:0.1:10.0]
// Thickness of the support structure.
foot_thickness = 2.25; // [0.5:0.1:10.0]
// Length of the bottom of the support leg, before it curves down to the ground.
foot_inner_length = 10; // [3.0:0.1:40.0]
// Height of the support leg, nominally how high it will hold the canister up. (Since these are plastic, a large value here is probably unwise.)
foot_lower_height = 5; // [0.1:0.1:20.0]
// Length of the portion of the leg that makes contact with the ground.
foot_base_length = 15; // [3.0:0.1:40.0]
// Height of the vertical section that makes contact with the side of the canister. 
cannister_contact_segment_height = 7; // [2.0:0.1:20.0]
// Height of the flange that grabs the inside bottom of the canister.
inner_flange_height = 3.1; // [0.5:0.1:10.0]
// Radius of the rounded portion on the outside of the upper leg of the support.
outer_leg_bevel_radius = 8; // [1.0:0.1:20.0]

/* [Hidden] */
// Calculate the angle at which the tangent line of the outer foot circle hits the rectangular top upper portion of he leg.

// Distance between the origin of the circle and the top corner of the leg

target_x_distance = (edge_width - 2*foot_thickness - metal_thickness) - (-foot_base_length - foot_inner_length - foot_lower_height + outer_leg_bevel_radius);
target_y_distance = (edge_height + cannister_contact_segment_height) - (-foot_lower_height - foot_thickness*0.5);
distance = sqrt(target_x_distance*target_x_distance + target_y_distance*target_y_distance);

// Radius of the outer foot circle portion
radius = outer_leg_bevel_radius + foot_thickness;

// Angle between the center point and the target point
otherangle = atan(target_y_distance/target_x_distance);

// Angle at which the line tangent to the circle intersects the target point
tangent_angle = acos(radius/distance) + otherangle - 90;

// Calculate the length of the upper leg segment, given all the above measurements.
tangent_point_x = -radius * sin(tangent_angle); 
tangent_point_y = radius * cos(tangent_angle); 

top_segment_x_distance = target_x_distance - tangent_point_x;
top_segment_y_distance = target_y_distance - tangent_point_y;

top_segment_length = sqrt(top_segment_x_distance * top_segment_x_distance + top_segment_y_distance * top_segment_y_distance);

module edge_outline() {
  translate([edge_bevel_radius, edge_bevel_radius])
  minkowski() {
    square([edge_width - 2*edge_bevel_radius, edge_height - 2*edge_bevel_radius]);
    circle(r = edge_bevel_radius, $fn = 20);
  }
}

linear_extrude(height = foot_width) {
  union() {
    // The main outline of the cannister clip
    difference() {
      union() {
        offset(delta = foot_thickness) edge_outline();
        // Extra material to reinforce the pot holder clip. (The weakest part of the structure.)
        translate([edge_width, foot_thickness*1.5*.1])
        scale([1, 1.1])
        intersection() {
          circle(r = foot_thickness*1.5, $fn = 30);
          //translate([0, -foot_thickness*1.5]) square([foot_thickness*1.5, foot_thickness*1.5]);
          translate([0, -foot_thickness*1.5]) 
          square([foot_thickness*1.5, foot_thickness*3.0]);
        }
      }

      edge_outline();
      //translate([edge_width - metal_thickness, edge_height - edge_bevel_radius])
      //square([metal_thickness, foot_thickness + edge_bevel_radius]);
      //translate([edge_width - metal_thickness, foot_thickness*1.0])
      translate([edge_width - metal_thickness, inner_flange_height])
      square([metal_thickness + foot_thickness*2, foot_thickness + edge_bevel_radius + edge_height - edge_bevel_radius - foot_thickness*1.0 + inner_flange_height]);
    }
    
    
    /* 
    // Full length thicker flange
    //translate([edge_width, 0])
    // square([foot_thickness*1.5, edge_height/2 - foot_thickness/2]); 

    translate([edge_width, edge_height - foot_thickness/2])
    %intersection() {
      circle(r = foot_thickness*1.5, $fn = 30);
      square([foot_thickness*1.5, foot_thickness*1.5]);
    }
    */
    
    // Inner segment holding the side of the cannister
    translate([edge_width - foot_thickness - metal_thickness, edge_height])
    square([foot_thickness, cannister_contact_segment_height]);

    translate([edge_width - 2*foot_thickness - metal_thickness, edge_height + cannister_contact_segment_height - foot_thickness])
    square([foot_thickness*2, foot_thickness]);
    
    // Optional support peg directly below the canister
    if(include_support_peg == "Include_Support_Peg") {
      translate([edge_width - foot_thickness, -foot_lower_height - foot_thickness*1.5])
      square([foot_thickness, foot_lower_height]);
    }

    // Main segment of bottom leg extension
    translate([-foot_inner_length - foot_thickness, -foot_thickness*1.5])
    square([foot_inner_length + foot_thickness + edge_width, foot_thickness]);
    
    // The curved portion of the lower leg extension
    translate([-foot_inner_length - foot_thickness, -foot_lower_height - foot_thickness*1.5])
    intersection() {
      difference() {
        circle(r = foot_lower_height + foot_thickness, $fn = 30);
        circle(r = foot_lower_height, $fn = 30);
      }
      translate([-foot_lower_height - foot_thickness, 0])
      square([foot_lower_height + foot_thickness, foot_lower_height + foot_thickness]);
    }
    
    // The bottom segment that rests on the ground
    translate([-foot_base_length - foot_inner_length - foot_thickness - foot_lower_height, -foot_lower_height - foot_thickness*1.5])
    square([foot_base_length, foot_thickness]);
    
    // The annoyingly shaped top leg extension
    
    translate([-foot_base_length - foot_inner_length - foot_lower_height + outer_leg_bevel_radius, -foot_lower_height - foot_thickness*0.5])
    intersection() {
      difference() {
        circle(r = outer_leg_bevel_radius + foot_thickness, $fn = 40);
        circle(r = outer_leg_bevel_radius, $fn = 40);
      }
      rotate([0, 0, 90]) square([outer_leg_bevel_radius + foot_thickness, outer_leg_bevel_radius + foot_thickness]);
      rotate([0, 0, 90 + tangent_angle]) square([outer_leg_bevel_radius + foot_thickness, outer_leg_bevel_radius + foot_thickness]);
    }
    
    translate([-foot_base_length - foot_inner_length - foot_lower_height + outer_leg_bevel_radius, -foot_lower_height - foot_thickness*0.5])
    rotate([0, 0, tangent_angle])
    translate([0, outer_leg_bevel_radius])
    square([top_segment_length, foot_thickness]);

    //translate([edge_width - 2*foot_thickness - metal_thickness, edge_height + cannister_contact_segment_height - foot_thickness])
    //circle(r = 0.5);
    
  }
}
  
  


