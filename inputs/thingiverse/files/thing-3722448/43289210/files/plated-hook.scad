// Inner radius
bend_radius = 16; // [.2:60]

// Hook width
width = 16; // [4:150]

// Hook thickness
thickness = 6; // [4:20]

// Backing plate width
plate_width = 75; // [4:150]

// Backing plate height
plate_height = 75; // [4:150]

// Backing plate thickness
plate_thickness = 1.2; // [0.2:10]

/* [Hidden] */
vwidth = max([width,thickness]);
$fn = 100;

/* rotate_extrude angle workaround by thehans.
 * http://forum.openscad.org/rotate-extrude-angle-always-360-tp19035p19040.html
 */
module rotate_extrude2(angle=360, convexity=2, size=1000) {

  module angle_cut(angle=90,size=1000) {
    x = size*cos(angle/2);
    y = size*sin(angle/2);
    translate([0,0,-size]) 
      linear_extrude(2*size) polygon([[0,0],[x,y],[x,size],[-size,size],[-size,-size],[x,-size],[x,-y]]);
  }

  // support for angle parameter in rotate_extrude was added after release 2015.03 
  // Thingiverse customizer is still on 2015.03
  angleSupport = (version_num() > 20150399) ? true : false; // Next openscad releases after 2015.03.xx will have support angle parameter
  // Using angle parameter when possible provides huge speed boost, avoids a difference operation

  if (angleSupport) {
    rotate_extrude(angle=angle,convexity=convexity)
      children();
  } else {
    rotate([0,0,angle/2]) difference() {
      rotate_extrude(convexity=convexity) children();
      angle_cut(angle, size);
    }
  }
}

module poly()
{
    polygon([[thickness/3,0], [2*thickness/3,0], [thickness,thickness/3],
        [thickness,vwidth-thickness/3], [2*thickness/3,vwidth],
        [thickness/3,vwidth], [0,vwidth-thickness/3], [0,thickness/3]]);
}

union()
{
    translate([vwidth/2,0,0]) rotate([-90,0,90]) rotate_extrude2(angle=180)
        translate([bend_radius,0]) poly();

    translate([vwidth/2,-bend_radius-thickness,-.01]) rotate([0,0,90]) hull()
    {
        linear_extrude(.01) poly();
        translate([0,0,thickness/3-.01]) linear_extrude(.01)
            translate([thickness/3,thickness/3])
            square([thickness/3,vwidth-2*thickness/3]);
    }

    translate([vwidth/2,bend_radius,-.01]) rotate([0,0,90]) hull()
    {
        linear_extrude(.01) poly();
        translate([0,0,thickness/3])
            linear_extrude(plate_height-thickness/3) union()
            {
                poly();
                translate([thickness/2,0]) square([thickness/2,vwidth]);
            }
        translate([0,0,plate_height+thickness/3]) linear_extrude(.01)
            translate([thickness/3,thickness/3])
            square([2*thickness/3,vwidth-2*thickness/3]);
    }

    translate([-plate_width/2,bend_radius+thickness-plate_thickness,
            thickness/3])
        cube([plate_width,plate_thickness,plate_height]);
}
