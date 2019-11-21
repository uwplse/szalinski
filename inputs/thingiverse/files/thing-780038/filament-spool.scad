/**
Parametric loose filament spool
**/

/* [Spool Options] */
// Width of spool (mm)
spool_width = 25; //[10:100]
// Outer diameter of spool (mm)
spool_diameter = 130; //[60:240]
// Depth of filament channel (mm) *Depth near spool edges will be affected by fillet
channel_depth = 18; //[10:40]
// Filament holes *Include holes to hold start and end of filament
filament_holes = "Yes"; //[Yes,No]
// Diameter of filament (mm) *Used to make holes to hold filament if enabled
filament_diameter = 1.75; //[1.0:5.0]
/* [Hub Options] */
// Inner diameter of hub (mm)
hub_diameter = 34; //[5:80]
// Hub thickness (mm)
hub_thickness = 5; //[5:12]
/* [Support Options] */
// Thickness of supports (mm)
support_thickness = 5; //[4:12]
// Enable or disable holes on supports
support_holes = "Yes"; //[Yes,No]
/* [Hidden] */
spool_inner_diameter = (spool_diameter-(channel_depth*2));
wall_thickness = 2;
filament_hole_diameter = filament_diameter+.5;
hub_outer_diameter = hub_diameter+(hub_thickness*2);
support_length = ((spool_inner_diameter/2)-(hub_outer_diameter/2))+1;
support_hole_diameter = support_length/2;


$fn=80;

if (hub_diameter+hub_thickness > (spool_diameter-channel_depth*2)-4) {
  echo("Hub diameter is greater that spool diameter, please adjust!");
} else {
  spool();
}


module ring_fillet_angled(ring_radius,profile_angle,fillet_width,fillet_height)
{
  fillet_height = fillet_height == undef ? fillet_width : fillet_height;
  rotate_extrude(convexity=10)translate([ring_radius,0,0])rotate([0,0,profile_angle])polygon( points=[[0,0],[fillet_width,0],[0,fillet_height]] );
}

module hub() {
  difference() {
    cylinder(r=hub_outer_diameter/2,h=spool_width);
    translate([0,0,-.1])
      cylinder(r=hub_diameter/2,h=spool_width+.2);
  }
}

module create_support_holes() {
  translate([(hub_outer_diameter/2)+(support_length/2),(support_thickness/2)+0.5,spool_width/2])
    rotate([90,0,0])
      cylinder(r=support_hole_diameter/2,h=support_thickness+1,$fn=30);
  translate([(support_thickness/2)+0.5,(hub_outer_diameter/2)+(support_length/2),spool_width/2])
    rotate([270,0,90])
      cylinder(r=support_hole_diameter/2,h=support_thickness+1,$fn=30);
  translate([-((hub_outer_diameter/2)+(support_length/2)),(support_thickness/2)+0.5,spool_width/2])
    rotate([90,0,0])
      cylinder(r=support_hole_diameter/2,h=support_thickness+1,$fn=30);
  translate([(support_thickness/2)+0.5,-((hub_outer_diameter/2)+(support_length/2)),spool_width/2])
    rotate([270,0,90])
      cylinder(r=support_hole_diameter/2,h=support_thickness+1,$fn=30);
}

module support() {
  difference() {
    union() {
      translate([(hub_diameter/2)+(hub_thickness-.5),0,spool_width/2])
        rotate([90,90,90])
          linear_extrude(height = support_length, center = false, convexity = 5, twist = 0,slices = 256)
            square(size = [spool_width,support_thickness/2],center = true);
      translate([0,(hub_diameter/2)+(hub_thickness-.5),spool_width/2])
        rotate([0,90,90])
          linear_extrude(height = support_length, center = false, convexity = 5, twist = 0,slices = 256)
            square(size = [spool_width,support_thickness/2],center = true);
      translate([-((hub_diameter/2)+(hub_thickness-.5)),0,spool_width/2])
        rotate([270,90,90])
          linear_extrude(height = support_length, center = false, convexity = 5, twist = 0,slices = 256)
            square(size = [spool_width,support_thickness/2],center = true);
      translate([0,-((hub_diameter/2)+(hub_thickness-.5)),spool_width/2])
        rotate([90,90,0])
          linear_extrude(height = support_length, center = false, convexity = 5, twist = 0,slices = 256)
            square(size = [spool_width,support_thickness/2],center = true);
    };
    if (support_holes == "Yes") {
      create_support_holes();
    }
  }
}

module create_filament_holes() {
  translate([(spool_diameter/2)-(filament_hole_diameter+0.6),0,0])
    rotate([0,0,90])
      cylinder(r=(filament_hole_diameter/2)+.25,h=5);
  translate([0,(spool_diameter/2)-(filament_hole_diameter+0.6),0])
    rotate([0,0,90])
      cylinder(r=(filament_hole_diameter/2)+.25,h=5);
  translate([-((spool_diameter/2)-(filament_hole_diameter+0.6)),0,0])
    rotate([0,0,90])
      cylinder(r=(filament_hole_diameter/2)+.25,h=5);
  translate([0,-((spool_diameter/2)-(filament_hole_diameter+0.6)),0])
    rotate([0,0,90])
      cylinder(r=(filament_hole_diameter/2)+.25,h=5);
  translate([((spool_diameter/2)-(channel_depth-3)),-5,spool_width/2])
    rotate([90,0,-45])
      cylinder(r=(filament_hole_diameter/2)+.25,h=sqrt(pow((spool_inner_diameter/2),2)+pow((spool_inner_diameter/2),2))+5);
}

module outer_ring() {
  difference() {
    union() {
      difference() {
        cylinder(r=(spool_inner_diameter/2)+2,h=spool_width);
        translate([0,0,-.1])
          cylinder(r=spool_inner_diameter/2,h=spool_width+.2);
      }
      difference() {
        cylinder(r=spool_diameter/2,h=wall_thickness);
        translate([0,0,-.1])
          cylinder(r=spool_inner_diameter/2,h=wall_thickness+.2);
      }
      translate([0,0,wall_thickness])
          rotate([0,180,0])
            ring_fillet_angled((spool_inner_diameter/2)+(wall_thickness-1),270,(spool_width-wall_thickness)/4,channel_depth-(wall_thickness-1));
      translate([0,0,spool_width-wall_thickness])
        difference() {
          cylinder(r=spool_diameter/2,h=wall_thickness);
          translate([0,0,-.1])
          cylinder(r=spool_inner_diameter/2,h=wall_thickness+.2);
        }
      translate([0,0,spool_width-wall_thickness])
        ring_fillet_angled((spool_inner_diameter/2)+(wall_thickness-1),270,(spool_width-wall_thickness)/2.5,channel_depth-(wall_thickness-1));
    }
    if (filament_holes == "Yes") {
      create_filament_holes();
    }
  }
}

module spool() {
  union() {
    hub();
    support();
    outer_ring();
  }
}