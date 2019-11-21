// What type of framing finger?
part=1; // [1:Top Finger, 2:Bottom Finger, 3:Side Finger, 4:Bar Holder]

// Distance from back of glass to wall.
height=40;

// How tall is the frame?
frame_height_v=590;

// How wide is the frame?
frame_width_v=742;

// How tall is the space in the frame for the glass?
glass_height_v=461;

// How wide is the space in the frame for the glass?
glass_width_v=612;

// How deep is the glass from the back of the frame?
glass_offset=8.7;

// Monitor thickness at the top edge.
monitor_thickness_top=11;

// Monitor thickness at the bottom edge.
monitor_thickness_bottom=8;

// Monitor width
monitor_width_v=545;

// Monitor height
monitor_height_v=322;

// How much wiggle room?
wiggle=0.5;

// Layer thickness.
layer=0.41;

// Total finger width.
width=25.4;

/* [Hidden] */

inch=25.4;
thickness=width/4;
screw_depth=inch / 4 + 1;

frame_height=frame_height_v + wiggle;
frame_width=frame_width_v + wiggle;
glass_height=glass_height_v - wiggle;
glass_width=glass_width_v - wiggle;
monitor_width=monitor_width_v + wiggle;
monitor_height=monitor_height_v + wiggle;

frame_hook=(frame_height - glass_height)/2 - height/2;

module ovoid(len,width,height) {
  hull() {
    translate([(len-width)/2, 0, ]) cylinder(r=width/2, h=height);
    translate([(width-len)/2, 0, ]) cylinder(r=width/2, h=height);
  }
}

module basic_finger(width, offset, monitor_thickness) {
  length = frame_hook+ offset + width/2;
  difference() {
    ovoid(length, width, height);
    translate([0,0,-1]) 
      difference() {
      ovoid(length-thickness*2, width - thickness*2, height * 2);
      translate([-length/2,-width/2,-1+glass_offset]) {
	difference() {
	  cube([length - 1, width,screw_depth + 2]);
	  translate([width/2, width/2, 0]) cylinder(r=2, $fn=10, h=screw_depth+2-layer);
	  translate([length - width/2, width/2, 0]) cylinder(r=2, $fn=10, h=screw_depth+2-layer);
	  translate([length/2, width/2, 0]) cylinder(r=2, $fn=10, h=screw_depth+2-layer);
	}
      }
    }

    translate([0,0,0]) cube([length + 2,width+2,glass_offset * 2], center=true);

    translate([length/2-width/2-4,0,height - 5])
      rotate([90,0,0])
      cylinder(r=3 / cos(180/6), $fn=6, h=width + 2, center=true);

    translate([0,0,height - 5])
      rotate([90,0,0])
      cylinder(r=3 / cos(180/6), $fn=6, h=width + 2, center=true);

    rotate([0,0,180])
      translate([length/2-width/2-4,0,height - 5])
      rotate([90,0,0])
      cylinder(r=3 / cos(180/6), $fn=6, h=width + 2, center=true);
  }
}


module finger(width, offset, monitor_thickness) {
  length = frame_hook+ offset + width/2;
  difference() {
    ovoid(length, width, height);
    translate([0,0,-1]) 
      difference() {
      ovoid(length-thickness*2, width - thickness*2, height * 2);
      translate([length/2-frame_hook+1,-width/2,-1+glass_offset]) {
	difference() {
	  cube([frame_hook - thickness/2,width,screw_depth + 2]);
	  translate([thickness, width/2, 0]) cylinder(r=2, $fn=10, h=screw_depth+2-layer);
	  translate([frame_hook - width/2 -1, width/2, 0]) cylinder(r=2, $fn=10, h=screw_depth+2-layer);
	}
      }
    }

    translate([-length/2,0,0]) cube([width,width+2,monitor_thickness * 2], center=true);
    translate([length/2,0,0]) cube([frame_hook*2,width+2,glass_offset * 2], center=true);

    translate([length/2-width/2-4,0,height - 5])
      rotate([90,0,0])
      cylinder(r=3 / cos(180/6), $fn=6, h=width + 2, center=true);

    rotate([0,0,180])
      translate([length/2-width/2-4,0,height - 5])
      rotate([90,0,0])
      cylinder(r=3 / cos(180/6), $fn=6, h=width + 2, center=true);
  }
}

rotate([180,0,0]) {

// Fingers for the top edge
if(part == 1) finger(width, (glass_height-monitor_height)/2, monitor_thickness_top);

// Fingers for the bottom edge
if(part == 2) finger(width, (glass_height-monitor_height)/2, monitor_thickness_bottom);

// Fingers for the side
if(part == 3) finger(width, (glass_width-monitor_width)/2, monitor_thickness_bottom);

// Bar holder
if(part == 4) basic_finger(width, (glass_width-monitor_width)/2, 0);

}