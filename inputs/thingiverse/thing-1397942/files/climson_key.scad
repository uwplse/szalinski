width= 24;
thickness = 8;
length = 30;
cross_thickness = 2;
cross_length = 6;
cross_width = thickness;
hole_rayon = 3;
intersection(){
difference()
{
union()
{
    cube([width, thickness, length], center = false);
    translate([0,4-cross_thickness/2,-cross_length])
        cube([cross_width, cross_thickness, cross_length]);
    translate([width-8,4-cross_thickness/2,-cross_length])
        cube([cross_width, cross_thickness, cross_length]);
    translate([cross_width/2-cross_thickness/2,0,-cross_length])
        cube([cross_thickness, cross_width, cross_length]);
    translate([width-cross_width/2-cross_thickness/2,0,-cross_length])
        cube([cross_thickness, cross_width, cross_length]);
}
translate([width/2, thickness+1, length-hole_rayon-3])
    rotate([90,0,0])
      cylinder(h=thickness+2, r=hole_rayon);
}
translate([width/2,thickness/2, -1])
    sphere(r=length);
}