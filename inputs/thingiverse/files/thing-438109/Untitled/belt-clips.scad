/* [Global] */

// typically 6 (mm)
belt_width = 6; // [3:15]

// should slightly less than actual belt thickness for compression fit, typically 1 - 0.05 (mm)           
belt_thickness = 0.95;

// - tooth pitch on the belt, 2 for GT2 (mm)
belt_pitch = 2.0;                  

// - belt tooth radius, 0.8 for GT2 (mm) - original version only
tooth_radius = 0.8;                

// - belt tooth length (mm) - remized version only
tooth_length = 2;                    

// (overall clamp width, mm)
clamp_width = 15;
// (overall clamp height, mm)
clamp_length = 15;
// (overall clamp base thickness, mm)
clamp_base = 4;

show = 1; // [1:remixed,2:original,3:both]

//////////////////////////////////////////////////////////////////////////////

/* [Hidden] */

path_height = belt_width + 1;
clamp_thickness = path_height+clamp_base;

$fn = 40;

clamp_inside_radius = clamp_width/2;
clamp_outside_radius = clamp_inside_radius+belt_thickness;
dTheta_inside = belt_pitch/clamp_inside_radius;
dTheta_outside = belt_pitch/clamp_outside_radius;
pi = 3.14159;

small = 0.01;  // avoid graphical artifacts with coincident faces

module tube(r1, r2, h) {
  difference() {
    cylinder(h=h,r=r2);
    translate([0, 0, -1]) cylinder(h=h+2,r=r1);
	echo(h);
  }
}

module belt_cutout(clamp_radius, dTheta) {
  // Belt paths
  tube(r1=clamp_inside_radius,r2=clamp_outside_radius,h=path_height+small);
  for (theta = [0:dTheta:pi/2]) {
    translate([clamp_radius*cos(theta*180/pi),clamp_radius*sin(theta*180/pi),0]) cylinder(r=tooth_radius, h=path_height+small);
  }
}

module belt_clips() {
  difference() {
    cube([clamp_width,clamp_length,clamp_thickness]);
    translate([0,0,clamp_base]) {
      belt_cutout(clamp_inside_radius, dTheta_inside);
      translate([clamp_width,clamp_length,0]) rotate([0, 0, 180])
        belt_cutout(clamp_outside_radius, dTheta_outside);
    }
  };
}

module belt_cutout2(clamp_in, clamp_mid, clamp_out, dTheta) {
  // Belt paths
  tube(r1=min(clamp_in, clamp_mid),r2=max(clamp_in, clamp_mid),h=path_height+1);

  for (theta = [-dTheta/4:dTheta:pi/2+dTheta/4]) {
    linear_extrude(height=path_height+small, center=false) {
      polygon(points = [
        [cos(theta*180/pi) * clamp_out, sin(theta*180/pi) * clamp_out], 
        [cos(theta*180/pi) * ((clamp_in+clamp_mid)/2), sin(theta*180/pi) * ((clamp_in+clamp_mid)/2)], 
        [cos((theta+dTheta/2)*180/pi) * ((clamp_in+clamp_mid)/2), sin((theta+dTheta/2)*180/pi) * ((clamp_in+clamp_mid)/2)],
        [cos((theta+dTheta/2)*180/pi) * clamp_out, sin((theta+dTheta/2)*180/pi) * clamp_out]
      ]);
    }
  }
}

module belt_clips2() {
  difference() {
    cube([clamp_width,clamp_length,clamp_thickness]);
    translate([0,0,clamp_base]) {
      belt_cutout2(clamp_inside_radius, clamp_outside_radius, clamp_outside_radius-tooth_length, dTheta_inside);
      translate([clamp_width,clamp_length,0]) rotate([0, 0, 180])
        belt_cutout2(clamp_outside_radius, clamp_inside_radius, clamp_inside_radius+tooth_length, dTheta_outside);
    }
  };
}

if((show == 1) || (show == 3))
	belt_clips2();

if(show == 3)
	translate([-clamp_width-3,-clamp_length-3,0]) color([1,0,0])
		belt_clips();
if(show == 2)
	belt_clips();