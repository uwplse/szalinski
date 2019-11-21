screw_tolerance=.2; play_tolerance=.5; fit_tolerance=.1;

// Glass holder thickness (probably a bit thicker than your thickest glass).
thickness = 5;
// The minimum radius (something less than the distance between your biggest glass to the mounthole).
r0=4;
// The maximum radius (something a bit greather than the distance between your smallest glass to the mounthole).
r1=8.5;
// The diameter of the mount screw.
screw_diameter = 3;
// The diameter of the mount screw head (it's definitely better when smaller than the minimum radius).
screwhead_diameter = 5.5;
// The thickness of the screw head (you better make it less than the whole thing thickness).
screwhead_thickness = 3;
// The length of the handle
handle_length = 15;

fn=180;

module glassfit(r0=r0,r1=r1,fn=fn,thickness=thickness,sd=screw_diameter,shd=screwhead_diameter,sht=screwhead_thickness,handle=handle_length) {
 module shape(r0=r0,r1=r1,a0=0,a1=360) {
  polypoints = [
   for(a=[a0:(a1-a0)/fn:a1])
    let(r=r0+(r1-r0)*(a-a0)/(a1-a0)) [ r*cos(a),r*sin(a) ]
  ];
  r=.5;
  offset(r=-r,$fn=60) offset(r=+r,$fn=60)
  offset(r=r) offset(r=-r)
  polygon(polypoints);
 }
 module eshape(r0=r0,r1=r1,a0=0,a1=360) {
  linear_extrude(height=thickness,scale=1.1)
  shape(r0=r0,r1=r1,a0=a0,a1=a1);
 }
 difference() {
  if(handle) hull() {
   eshape(a0=180);
   translate([0,handle-1,0])
   cylinder(d=screwhead_diameter,h=thickness,$fn=30);
  } else eshape();
  translate([0,0,-1]) cylinder(d=sd+screw_tolerance,h=thickness+2,$fn=24);
  translate([0,0,thickness-sht]) cylinder(d=shd+fit_tolerance,h=sht+1,$fn=24);
 }
}

glassfit();