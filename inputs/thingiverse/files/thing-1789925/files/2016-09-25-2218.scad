plate_thickness = 2;
stand_length = 100;
stand_width = 100;
stand_height = 100;
stand_rounding = 10;
support_radius = 12;
support_stopper_length = 5;
support_stopper_scale = 1.5;

$fn=100;


module semicircle(radius, thickness) difference() {
    circle(r=radius);
    circle(r=radius-thickness);
    translate([0,-radius]) square(radius*2);
}

cube([stand_width,stand_length,plate_thickness], center=true);
translate([0,0,stand_height/2]) rotate([0,90,0]) cube([stand_height,stand_length,plate_thickness], center=true);

difference() {
    translate([0,0,stand_rounding/2]) cube([stand_rounding*2,stand_length,stand_rounding], center=true);
    translate([stand_rounding+plate_thickness/2,0,stand_rounding+plate_thickness/2])
      rotate([90,0,0]) cylinder(r=stand_rounding,h=stand_length+1, center=true);
    translate([-stand_rounding-plate_thickness/2,0,stand_rounding+plate_thickness/2])
      rotate([90,0,0]) cylinder(r=stand_rounding,h=stand_length+1, center=true);
}

translate([0,stand_length/2,stand_height-support_radius+1]) rotate([90,90,0]) {
    
  translate([0,0,support_stopper_length])
    linear_extrude(stand_length-2*support_stopper_length) semicircle(support_radius,plate_thickness);
  //cylinder(r=stand_rounding,h=stand_length+1, center=true);
  translate([0,0,support_stopper_length]) rotate([180,0,0]) linear_extrude(support_stopper_length, scale=support_stopper_scale) semicircle(support_radius,plate_thickness);
  translate([0,0,stand_length-support_stopper_length]) linear_extrude(support_stopper_length, scale=support_stopper_scale) semicircle(support_radius,plate_thickness);
}


module filler() translate([0,0,-plate_thickness/2]) difference() {
  cube([10,10,plate_thickness]);
  translate([0,0,-0.5]) rotate([0,0,45]) cube([15,10,plate_thickness+1]);
}


translate([0,-stand_length/2,stand_height+5]) rotate([0,90,0]) filler();
translate([0,stand_length/2,stand_height+5]) rotate([0,90,180]) filler();