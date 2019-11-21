
// in mm
spacer_radius = 16;
// in mm
spacer_height = 20;
// in mm
hole_radius = 5;
// in mm
wall_thickness = 1.2;
// level of detail
$fn = 150;

difference(){
    cylinder(r=spacer_radius, h=spacer_height);
    
    union(){
        translate([0, 0, wall_thickness])
        difference(){
            cylinder(r=spacer_radius-wall_thickness, h=spacer_height+0.1);
            cylinder(r=hole_radius+wall_thickness, h=spacer_height+0.2);
        }
        translate([0, 0, -0.01])
        cylinder(r=hole_radius, h=spacer_height+0.1);
    }
}

translate([0, hole_radius + wall_thickness/2, 0])
cube([wall_thickness, spacer_radius - hole_radius - wall_thickness, spacer_height]);