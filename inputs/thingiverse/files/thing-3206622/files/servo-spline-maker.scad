// Generate test plate for determining proper size, or spline alone for integrating into larger design
part = "plate"; // [ plate:Test Plate, spline:Spline Only ]

// How many points are on the spline (it's important that this is correct)
spline_count = 21;

// Estimated diameter of spline will be fine-tuned for a good fit
approximate_diameter = 4.5;  

// First attempt, recommend 0.2 or greater, finer tuning recommend 0.1
step_size = 0.2;

module dummy() { }  // no more parameters

approx_od = approximate_diameter;
disc_size = approx_od+10;  // for purposes of plate generation...

stepmin = -4;
stepmax = 4;
xmid = (stepmin+stepmax)/2*(approx_od+8);

if (part == "plate") {
  for (i=[stepmin:stepmax]) {
    translate([i*(approx_od+8), 0, 0]) {
      spline_hole(approx_od + i*step_size);
      spline_plate(i);
    }
  }

  translate([xmid, 17, 0])
  linear_extrude(height=1)
  text(str("Nominal: ", approx_od, "  Step: ", step_size), 5, halign="center");
}
else {  // spline or anything else, just make the spline
  spline_hole(approx_od);
}


module spline_hole(inside_points_diameter = approx_od, label) {
  r1 = inside_points_diameter/2;
  // approximate distance along circumference from one bump to the next
  space = r1*sin(360/spline_count);
  r2 = r1 + space*0.75;  // pointy but not *too* pointy
  // about 4mm solid between outer points and outside disc, should be large enough to prevent 
  // slicers from being goofy about the space betewen the splines and the outside.
  disc_d = 2*r2 + 8;  
  
  linear_extrude(height=2.6)
  difference() {
    circle(d=disc_d, $fn=36);
    polygon([ 
      for (i=[1:2*spline_count])
        (i % 2 == 0) ? 
          [ r1*cos(i*360/(2*spline_count)), r1*sin(i*360/(2*spline_count)) ] : 
          [ r2*cos(i*360/(2*spline_count)), r2*sin(i*360/(2*spline_count)) ]
        ]);
  }
}


module spline_plate(label) {
  // text showing which value
  translate([0, disc_size/2+1, 0])
  linear_extrude(height=1)
  text(str(label), 5, halign="center");
  
  // flat plate on which to put text
  translate([-disc_size/2-2, -disc_size/2, -2])
  cube([disc_size+4, disc_size+18, 2]);
}