// pipe cutting jig
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 

pipe_diam = 26; // [3.0:0.1:40.0]
angle = 60;     // [15:90]
jig_width = 32; // [20:100]
jig_length=120; // [50:150]
jig_depth = 70; // [20:100]
bolt_diam = 5;  // [3:0.1:8]
wall = 6;       // [3:0.5:10]
slope = "uphill";  // [uphill,downhill]

if (slope=="uphill")
  mirror([1, 0, 0])
    PipeCuttingJigPart();
else
  PipeCuttingJigPart();


module PipeCuttingJigPart()  {
  width = max(pipe_diam + 2*wall, jig_length*sin(angle));
  depth = max(pipe_diam + 2*wall, jig_depth);
  offset_y = depth - wall - 0.5*pipe_diam;
  guide_height = wall/sin(angle);
  extra_height = width*cos(angle)/sin(angle);
  height = jig_width/sin(angle) + guide_height + extra_height;
  corner_r = 1.5;
  slot_width = 2.4;

  difference() {
    union() {
      // main block
      translate([-0.5*width, -offset_y])
        ClampBlock(width, depth, height - extra_height, height, corner_r);
      
      guide_depth = 0.5*pipe_diam + 2*wall;
      difference() {
        // guide
        translate([-0.5*width, 0])
          cube([width, guide_depth, guide_height+extra_height]);
          
        // slope of guide
        h0 = 0.5*extra_height;
        cut_length = 1.01*width/sin(angle);
        translate([0, 0, h0 + guide_height])
          rotate([0, 90-angle])
            translate([-0.5*cut_length, 0])
              cube([cut_length, guide_depth, 2*extra_height]);
        translate([0, 0, h0])
          rotate([0, 90-angle])
            translate([-0.5*cut_length, 0, -2*extra_height])
              cube([cut_length, guide_depth, 2*extra_height]);
      }
      
    }    
    // hole for the pipe
    cylinder(d=pipe_diam, h=height, $fn=120);
    // chamfer
    cylinder(d1=pipe_diam + 2*corner_r, d2=pipe_diam, h=corner_r, $fn=120);
    
    // Slot used to clamp the pipe
    translate([-0.5*slot_width, 0])
      cube([slot_width, 0.5*depth+2*wall, height]);
  }
  
  // Rails
  fancy_corners = corner_r*(1 + tan(0.5*angle));
  tangent = (wall + 0.5*bolt_diam)*(tan(90-0.5*angle) - 1);
  rail_height = height - extra_height - max(fancy_corners, tangent);
  translate([0.5*width, -offset_y])
    Rail(rail_height, wall);
  translate([-0.5*width, -offset_y])
    mirror([1,0,0])
      Rail(rail_height, wall);
}

module ClampBlock(width, depth, h1, h2, corner_r) {
  // "fancy" right corner
  dz1 = corner_r*tan(0.5*angle);
  dx1 = corner_r*(1-cos(angle));
  // "fancy" left corner
  dz2 = corner_r*tan(90-0.5*angle);
  dx2 = corner_r*(1+cos(angle));
  
  difference() {
    // main block
    cube([width, depth, h2]);
    
    // leaning cut
    cut_length = 1.01*width/sin(angle);
    translate([0, 0, h2])
      rotate([0, 90-angle])
          cube([cut_length, depth + wall, 2*max(h2 - h1, width)]);
    
    // Cut outs for fancy corners
    translate([width-dx1, 0, h1-dz1])
      cube([dx1, depth, corner_r]);
    translate([0, 0, h2-dz2])
      cube([dx2, depth, dz2]);
  }
  
  // fancy corners
  translate([width-corner_r, 0, h1-dz1])
    rotate([-90,0])
      cylinder(r=corner_r, h=depth, $fn=12);
  translate([corner_r, 0, h2-dz2])
    rotate([-90,0])
      cylinder(r=corner_r, h=depth, $fn=12);
}

module Rail(height, thickness) {
  width = bolt_diam + 2*thickness;
  r = 0.5*width;
  fillet_r = 1.5;
  difference() {
    union() {
      // main rail
      cube([width, thickness, height - r]); 
      translate([0, 0, height - r]) {
        // rounded end
        rotate([-90, 0])
          translate([r, 0])
            cylinder(d=width, h=thickness, $fn=60);
        // fills in gap (makes round end a quarter circle)
        cube([r, thickness, r]);        
      }
      // fillet
      cube([fillet_r, thickness+fillet_r, height + fillet_r]);
    }
      
    // slot
    translate([r, 0, r - 0.5*bolt_diam])
      rotate([90, 0]) {
        slot_h = height - r;
        bolt_r = 0.5*bolt_diam;
        translate([-bolt_r, 0, -thickness])
          cube([bolt_diam,  slot_h - bolt_diam, 2*thickness]);
        cylinder(d=bolt_diam, h=2*thickness, $fn=30, center=true);
        translate([0, slot_h - bolt_diam])
          cylinder(d=bolt_diam, h=2*thickness, $fn=30, center=true);
      }
      
    // fillet
    translate([fillet_r, thickness+fillet_r])
      cylinder(r=fillet_r, h=height + fillet_r, $fn=12);
    translate([fillet_r, 0, height+fillet_r])
      rotate([90, 0])
        cylinder(r=fillet_r, h=3*thickness, center=true, $fn=12);
  }
}
