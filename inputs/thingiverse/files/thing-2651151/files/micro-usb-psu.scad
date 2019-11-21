// micro USB power supply
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 
//
// Remix of thing:2487915 Ultimate PSU Profile
// by paul0 https://www.thingiverse.com/paul0
//
// The enclosure consists of two halves (called left and right).
// There are two optional parts: a fan grill and a cable pass-through.

/* [PCB] */
show_left_part = "yes"; // [yes,no]
show_right_part = "yes"; // [yes,no]
pcb_length = 25.4; // [20.0:0.1:80.0]
pcb_width = 13.3; // [10.0:0.1:60.0]
pcb_clearance_above = 3.7; // [2.0:0.1:20.0]
pcb_clearance_below = 2.7; // [2.0:0.1:20.0]
pcb_thickness = 1.6; // [1.0:0.1:2.0]
pcb_slot_depth = 0.5; // [0.2:0.1:1.0]

/* [Features] */
box_thickness = 2;  // [1.0:0.1:4.0]

with_usb_cutout = "yes"; // [yes,no]
// height of usb connector relative PCB (0=same height as PCB)
usb_connector_offset_y = 0; // [-2.0:0.1:2.0]

with_outtake = "yes"; // [yes,no]

with_cable_pass_through = "yes"; // [yes,no]
show_cable_pass_through = "yes"; // [yes,no]
cable_pass_through_diameter = 5;  // [2.0:0.1:10.0]
cable_pass_through_brim = 0.8; // [0.4:0.1:2.0]

with_fan_grill = "yes"; // [yes,no]
show_fan_grill = "yes"; // [yes,no]
fan_grill_diameter  = 7; // [5.5:0.1:25.0]

// preview[view:south east, tilt:top]

tol = 0.2*1;
eps = 0.01*1;

inner_height = pcb_clearance_below + pcb_thickness + pcb_clearance_above;
inner_width = pcb_width - min(2*pcb_slot_depth, box_thickness-tol);  // avoid cutting through wall
half_inner_length = pcb_length/2;
corner_size = 0.125*min(inner_height, inner_width);
  
if (show_left_part=="yes")
  LeftPart();

if (show_right_part=="yes")
  RightPart();

if (with_fan_grill=="yes" && show_fan_grill=="yes")
  FanGrillPart();

if (with_cable_pass_through=="yes" && show_cable_pass_through=="yes")
  CablePassThrough();

module FanGrillPart() {
  // A bit of fuzzy scaling (vary the space between the rings)
  // aim for 1.2 mm rings and spaces
  target_w = 0.8;
  diameter = fan_grill_diameter + 2*tol;
  h = 0.5;
  numRings = max(floor(0.25*(diameter+target_w)/target_w), 0);
  w = 0.4*floor(diameter/(4*numRings-1)/0.4);
  space = (diameter - 2*numRings*w)/(2*numRings-1);
  delta = 2*(w+space);

  // arrange the parts so that all of them can be displayed simultaneously
  and_some = 1;
  translate([0, -0.5*fan_grill_diameter-0.5*inner_height-box_thickness-corner_size-and_some]) {  
    // rings
    for (i=[0:numRings-1]) {
      d = space+i*delta;
      
      difference() {
        cylinder(d=d+2*w, h=h, $fn=24);
        cylinder(d=d, h=h, $fn=24);
      }
    }
    
    // the part that goes through the wall
    difference() {
      cylinder(d=fan_grill_diameter-2*tol, h=box_thickness+h, $fn=24);
      cylinder(d=space+(numRings-1)*delta, h=box_thickness+h, $fn=24);
    }
    
    // radial "cross" 
    r0 = (space+w)/2;
    length = 0.5*(fan_grill_diameter-w) - r0;
    for (a=[0:60:300])
      rotate(a)
        translate([r0, -w/2])
          cube([length, w, h]);
  }  
}

module CablePassThrough() {
  brim_h = 0.5;
  brim_d = cable_pass_through_diameter+2*cable_pass_through_brim;
  height = box_thickness + 2*(brim_h + tol);
  slot_w = min(6.28*tol, 0.5*cable_pass_through_diameter);
  
  // arrange the parts so that all of them can be displayed simultaneously
  and_some = 1;
  translate([0.5*fan_grill_diameter+0.5*brim_d+and_some, 
            -0.5*brim_d-0.5*inner_height-box_thickness-corner_size-and_some]) {  
              
    difference() {
      union() {
        // base
        cylinder(d=brim_d, h=brim_h, $fn=24);
        
        // the part with the slot
        cylinder(d=cable_pass_through_diameter-2*tol, h=height, $fn=24);
        translate([0,0,height-brim_h])
           cylinder(d1=brim_d, d2=cable_pass_through_diameter, h=brim_h, $fn=24);
      }
      
      // center hole 
      cylinder(d=cable_pass_through_diameter-2*tol-1.6, h=height, $fn=24);
      
      // slot
      translate([0, -0.5*slot_w, brim_h])
        cube([brim_d, slot_w, height]); 
    }
  }
}

module LeftPart() {
  // arrange the parts so that all of them can be displayed simultaneously
  and_some = 1;
  translate([-pcb_width/2 - box_thickness - and_some, 0])
    difference() {
      HalfACase();
    
      if (with_usb_cutout=="yes") {
        y = -inner_height/2 + pcb_clearance_below + pcb_thickness + usb_connector_offset_y;
        
        translate([0, y])
          MicroUSBConnector();
      }
      
      if (with_fan_grill=="yes") {
        max_heat_sink = 5;
        
        translate([0, inner_height/2, half_inner_length/2])
          rotate([-90,0]) {
            cylinder(d=fan_grill_diameter, h=box_thickness+and_some,$fn=24);
            translate([0, 0, box_thickness])
              cylinder(d=fan_grill_diameter+4*tol, h=max_heat_sink, $fn=24);
          }
      }
    }
}

module RightPart() {
  // arrange the parts so that all of them can be displayed simultaneously
  and_some = 1;
  translate([+pcb_width/2 + box_thickness + and_some, 0])
    difference() {
      HalfACase();
      
      if (with_cable_pass_through=="yes") {
        // place to the left (outside view) if there is an outtake, center otherwise
        x = (with_outtake=="yes")? 0.5*(inner_width-cable_pass_through_diameter) -cable_pass_through_brim-tol : 0;
        translate([x, 0])
          cylinder(d=cable_pass_through_diameter, h=box_thickness+and_some, $fn=24);
      }
      
      if (with_outtake=="yes") {
        // use total width of box unless there is a cable pass-through
        pass_through_width = (with_cable_pass_through=="yes")? 
          cable_pass_through_diameter + 2*(cable_pass_through_brim+tol) : 0;
        width = inner_width - pass_through_width;
        translate([-0.5*inner_width+tol, -0.5*inner_height+tol])
          Outtake(width-2*tol, inner_height-2*tol);
      }
    }
}

module HalfACase() {
  pcb_y0 = pcb_clearance_below - inner_height/2 - tol;
  x0 = 0.5*inner_width;
  y0 = 0.5*inner_height;
  
  difference() {
    union() {
      ExtrudedCaseProfile(inner_width, inner_height, half_inner_length);
      
      // pegs at the corners to attach the two halves
      peg_length = box_thickness;
      linear_extrude(height=half_inner_length+box_thickness+peg_length) {
        translate([x0, -y0])
          mirror([0, 1])
            CornerProfile2D(corner_size, outline=-tol);
        translate([-x0, y0])
          mirror([1, 0])
            CornerProfile2D(corner_size, outline=-tol);
      }
      
      // heat sinks
      heatSinkWidth = max(inner_width - 2*corner_size - sqrt(2)*box_thickness, 0);
      heatSinkHeight = max(0.8, min(corner_size, 5));
      translate([0, 0.5*inner_height + box_thickness])
        HeatSink(heatSinkWidth, heatSinkHeight);
      translate([0, -0.5*inner_height - box_thickness - heatSinkHeight])
        HeatSink(heatSinkWidth, heatSinkHeight);
      
      // make sure there is enough material to cut the slots in
      ledger_thickness = 1;
      
      translate([-pcb_width/2-tol, pcb_y0 - ledger_thickness])
        cube([pcb_slot_depth, pcb_thickness + 2*ledger_thickness, half_inner_length+box_thickness]);
      translate([pcb_width/2+tol-pcb_slot_depth, pcb_y0 - ledger_thickness])
        cube([pcb_slot_depth, pcb_thickness + 2*ledger_thickness, half_inner_length+box_thickness]);
     
    }
    
    translate([-pcb_width/2-tol, pcb_y0, box_thickness])
      cube([pcb_width+2*tol, pcb_thickness+2*tol, half_inner_length]);
  }
}

module ExtrudedCaseProfile(length, width, inner_height) {
 height = inner_height + box_thickness;
  
  difference() {
    // exterior
    linear_extrude(height=height)
      CaseProfile2D(length, width, outline=box_thickness);
    
    // hole
    translate([0,0,box_thickness])
      linear_extrude(height=height)
        CaseProfile2D(length, width, outline=0, withSkippedCorners=true);
  }
}

module CaseProfile2D(length, width, outline, withSkippedCorners) {
  x0 = 0.5*length;
  y0 = 0.5*width;
  
  square([length+2*outline, width+2*outline], center=true);
  
  // the fancy corners
  translate([x0, y0])
    CornerProfile2D(corner_size, outline);
  translate([-x0, -y0])
    mirror([1, 1])
      CornerProfile2D(corner_size, outline);
  
  // just two corners are fully cut out (this is where the two halves attach)
  if (!withSkippedCorners) {
    translate([x0, -y0])
      mirror([0, 1])
        CornerProfile2D(corner_size, outline);
    translate([-x0, y0])
      mirror([1, 0])
        CornerProfile2D(corner_size, outline);
  }
}

module CornerProfile2D(size, outline) {
  d0 = max(outline, 0);
  d1 = outline/sqrt(2);
  d2 = d1 + size;
  d3 = size + outline;
  
  polygon([[0,0], [-d2,d0], [-d1,d3], [d3,d3], [d3,-d1], [d0,-d2]]);
}

module HeatSink(width, height) {
  // a bit of fuzzy scaling so that it looks good regardless of size
  target = max(0.8, min(5, width/20));     // aim for 0.8 mm notches (for small dimensions)
  n = max(floor(0.5*(width-target)/target), 0); // this many
  w = 0.4*round(width/0.4/(2*n+1));            //  this wide
  space = (width-n*w)/(n+1);                 // this amount of space
  x0 = -width/2 + space;
  dist = w+space;
  
  for(i=[0:n-1])
    translate([x0+i*dist, 0])
      cube([w, height, half_inner_length+box_thickness]);
}

module MicroUSBConnector() {
  h = box_thickness - 0.6;
  
  linear_extrude(h=box_thickness)
    MicroUSBProfile2D();
  
  if (h > 0) {
    x0 = 4.5;
    y0 = 2.7;
    y1 = -0.5;
    r = 1.5;
    for (x=[-x0,x0], y=[y0,y1])
      translate([x,y])
        cylinder(r=r, h=h, $fn=12);
    
    translate([-x0, y1-r])
      cube([2*x0, y0-y1+2*r, h]);
    translate([-x0-r, y1])
      cube([2*(x0+r), y0-y1, h]);
  }
}

module MicroUSBProfile2D() {
  height = 2.2 + 2*tol;
  x1 = 3.9; // max width (50% of)
  x2 = 2.7; // min width (50% of)
  x3 = 3.6; // tangent point
  r = 0.8 + tol; // radius
  x0 = x1-r;  // center
  y0 = height-r;
  y3 = y0 - sqrt(r*r - (x3-x0)*(x3-x0));
  translate([-x0, y0])
    circle(r=r, $fn=12);
  translate([x0, y0])
    circle(r=r, $fn=12);
  polygon([[x0, height], [x3,y3], [x2,-tol], [-x2,-tol], [-x3,y3], [-x0,height]]); 
}

module Outtake(width, height) {
  // a bit of fuzzy scaling so that it looks good regardless of size
  // Aim for 1.2 mm slots, but at most 10 slots.
  numSlots = min(floor(width/2), 10);
  dist = width/numSlots;
  space = 0.4*round((0.5/0.4)*width/numSlots);
  w = dist - space;
  r = 0.5*w;
  h = height - 2*r;
  x0 = 0.5*space + r;
  
  for (i=[0:numSlots-1]) {
    x = x0 + i*dist;
    translate([x,r])
      cylinder(r=r, h=box_thickness, $fn=12);
    translate([x-r,r])
      cube([w,h,box_thickness]); 
    translate([x,h+r])
      cylinder(r=r, h=box_thickness, $fn=12);
    }
}