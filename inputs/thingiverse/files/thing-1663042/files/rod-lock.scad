$fn = 30;
screw_radius = 1.5;
inner_radius = 4.25;
outer_radius = 7.25;

part_height = 6;

module ring(inner_radius,outer_radius) {
    difference() {
        cylinder(r=outer_radius, h=part_height);
        cylinder(r=inner_radius, h=part_height);
    }
}



module screw_collar() {
    difference() {
        ring(inner_radius,outer_radius);
        translate([0,0,part_height/2])
       { 
           rotate([90,0,0]) {
               cylinder(r=screw_radius,h=part_height*2);
           }
       }
    }
}

screw_collar();