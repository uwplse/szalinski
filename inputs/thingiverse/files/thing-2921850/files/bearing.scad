// ////////////////////////////////////////////////////////////
//
// Parametric Bearing.
//
// Copyright 2018 Kevin F. Quinn
//
// This work is licensed under the Creative Commons
// Attribution-ShareAlike 4.0 International License. To view a
// copy of the license, visit
// https://creativecommons.org/licenses/by-sa/4.0/
//
// This model is set up to work with the built-in OpenSCAD
// Customizer. At the time of writing (May 2018), the Customizer
// is available in the nightly builds. The model works fine
// in the 2015.03 release, just without the customizer interface.
//
// Note - the resolution paramter has a significant impact on
// CGAL rendering time and resource needs. The default settings
// here with 0.2mm resolution take about 10 minutes to render
// on my 2.4GHz CPU and about 3GB RAM.
//
// Just for fun, the code can be made to fit into a tweet, with
// a bit of variable renaming and calculation simplification:
// 
// r=20;t=2;h=15;c=0.4;l=0.2;a=2*asin(h/2/r);n=180/asin(2*l/h);
// rotate_extrude($fn=360)translate([r,0,0])offset(r=1,$fn=30)offset(delta=-1)
// difference(){square([h+2*t,h],center=true);circle(d=h,$fn=n);}
// for(i=[0:a:360-a])rotate([0,0,i])translate([r,0,0])sphere(d=h-c,$fn=n);
//
// which is a comfortable 271 characters when pasted into Twitter
// (268 if you make it all one line!)
  
/* [Bearing dimensions] */
// Bearing radius to ball center
radius=20; // [5:0.1:25]
// Bearing wall minimum thickness
thickness=2; // [0.4:0.01:10.0]
// Bevel radius
bevel_radius=1; // [0.0:0.1:1.0]
// Bearing height (channel radius)
height=15; // [1.0:0.1:20.0]
// Clearance between bearing and balls
clearance=0.4; // [0.01:0.01:0.5]
// Resolution of inner channel and bearing balls (~layer height)
resolution=0.2; // [0.01:0.01:0.8]

/* [Hidden] */
// Ball angle separation, subtended at bearing center
ball_angle=2*asin((height/2)/radius);
// Ball channel resolution (number of segments in a circle)
ball_fn=360/(2*asin(resolution/(height/2)));

module ring() {
  // Extrude the main ring using a 2D drawing of the profile
  rotate_extrude($fn=360)
  translate([radius,0,0])
  offset(r=bevel_radius,$fn=30) offset(delta=-bevel_radius,$fn=30) 
  difference() {
    square([height+2*thickness,height],center=true);
    circle(d=height,$fn=ball_fn);
  }
}

module balls() {
  // Place the balls in the bearing housing
  for (i=[0:ball_angle:360-ball_angle]) {
    rotate(a=i,v=[0,0,1])
    translate([radius,0,0])
    sphere(d=height-clearance,$fn=ball_fn);
  }
}

ring();
balls();
