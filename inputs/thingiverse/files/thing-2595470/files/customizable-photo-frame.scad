// Customizable photo frame
// by Stellar Innovation
// http://www.thingiverse.com/stellarinnovation/about
// licensed under the Creative Commons - Attribution license. 
//
// Consists of three different parts:
// * Back of frame, with hanger
// * Front of frame (no hanger)
// * Clip, you need four clips, which fit in the holes at the corners of
//   the front/back parts
//
// The front and back don't make sense to 3D print. It's intended to laser cut them instead.
//
// First revision 19 October 2017
// Second rev.  20 October 2017, fixes in module Hanger2D

part = 1; // [1:Back, 2:Front, 3:Clips]
frame_width = 203;  // [50:500]
frame_height = 254;  // [50:500]

clip_gap = 6.2;            // [3:0.1:10]
clip_thickness = 2;        // [2:0.1:4]
hole_width = 8;      // [6:0.1:16]
peg_depth = 1.5;     // [1:0.1:1.5]

hanger_big_diam = 3; // [2:0.1:6]
hanger_small_diam = 1; // [0.5:0.1:3]
hanger_thickness = 1; // [1:0.1:5]

hole_distance = 0.8*hole_width;
hole_length = 0.6*hole_width; // hole dimension, radius of "peg" 

if (part==1)
  linear_extrude(height=1)
    BackOfFrame2D();  
else if (part==2)
  linear_extrude(height=1)
    FrontOfFrame2D();
else
  FourClips();


// Export this one as an SVG file or "flatten" the STL into 2D for laser cutting
module BackOfFrame2D() {
  // Back looks basically the same as the front
  FrontOfFrame2D();
  
  // ...plus a hanger
  translate([0, frame_height/2])
    Hanger2D();
}

// Export this one as an SVG file or "flatten" the STL into 2D for laser cutting
module FrontOfFrame2D() {
  difference() {
    // The actual frame
    square([frame_width, frame_height], center=true);
    
    // The four holes in the corners
    x = frame_width/2 - (hole_distance + hole_width)/sqrt(2);
    y = frame_height/2 - (hole_distance + hole_width)/sqrt(2);
    for (i=[0:3]) {
      angle = 90*i+45;             // 45, 135,...
      dx = (i-1.5)*(i-1.5) - 1.25;   // +1, -1, -1, +1 direction vector
      dy = sign(1.5-i);             // +1, +1, -1, -1
      translate([x*dx, y*dy])
        rotate(angle)
          translate([0, -hole_width/2])
            square([hole_length, hole_width]);
    }
  }
}

module Hanger2D() {
  // The hanger is shaped as a triangle with rounded corners
  // and two holes inside. The hole is constructed from two circles:
  // a big one for the head of a nail,  and a small hole on top, 
  // where the frame hangs from the nail itself  
  c = sqrt(3)/2; // cos 30
  s = 0.5;       // sin 30
  R = max(hanger_big_diam, hanger_small_diam)/2;
  height = 3*R + 2*hanger_thickness;
  base = 2*height/sqrt(3);
  
  // center of small hole
  y0 = height - hanger_small_diam - 2*hanger_thickness;
  // tangent, where the rounded corner ends
  r1 = hanger_small_diam/2 + hanger_thickness;
  x1 = r1*c;
  y1 = y0 + r1*s;
  
  // tangent, small hole
  x2 = c*hanger_small_diam/2;
  y2 = y0 + s*hanger_small_diam/2;
  
  // tangent, big hole
  x3 = c*R;
  y3 = (1+s)*R;
  
  dRadius = 1/tan(60);
  echo(dRadius);
  difference() {
    union() {
      // rounded top
      translate([0, y0])
        circle(r=r1, $fn=24);
      // rest of the triangle
      polygon([[x1, y1], [base/2, 0], [-base/2, 0], [-x1, y1]]);
      // a piece to cut out a 1mm radius at the base
      translate([-base/2-dRadius, 0])
        square([base+2*dRadius, s]);
    }
    // Small circular hole
    translate([0, y0])
      circle(d=hanger_small_diam, $fn=24);
    // Big circular hole
    translate([0, R])
      circle(r=R, $fn=24);
    // rest of the hole
    polygon([[x2, y2], [x3,y3], [-x3,y3], [-x2,y2]]);
    
    // Fillets
    translate([-base/2-dRadius, 1])
      circle(r=1, $fn=24);
    translate([base/2+dRadius, 1])
      circle(r=1, $fn=24);
  }
}

// Four identical clips
module FourClips() {
  and_some = 1;
  
  // Space the four clips, rotated around the Origin
  for (a=[0:90:270])
    rotate(a)
      translate([0, (clip_gap + 2*clip_thickness)/1.4 + and_some])
        Clip();
}

module Clip() {
  // two "legs"
  Leg();
  mirror([1, 0, 0])
    Leg();
  // and a round "joint"
  Joint();
}

module Joint() {
  tol = 0.2;

  height = 2*clip_thickness + clip_gap;
  difference() {
    // Outer cylinder
    w = hole_width - 2*tol;
    cylinder(d=height, h=w, $fn=32);

    // takes away half of the cylinder
    translate([-height/2, 0])
      cube([height, height, hole_width]);
    
    // takes away center (rounds it off)
    cylinder(d=clip_gap, h=hole_width, $fn=24);  
    
    // a slot to make it more flexible
    translate([0, -0.1*height, 0.4*w])
      scale([clip_gap, height])
        cylinder(d=1, h=0.2*w, $fn=24);
  }
}

module Leg() {
  tol = 0.2;

  w = hole_width - 2*tol;
  d = hole_distance + hole_length/2 + tol;
  r = hole_length/2 - tol;

  translate([clip_gap/2, 0]) {  
    cube([clip_thickness, d, w]);
    translate([clip_thickness, d])
      scale([(peg_depth+clip_thickness)/2/r, 1, 1])
        translate([-r, 0])
          cylinder(r=r, h=w, $fn=16);
  }
}