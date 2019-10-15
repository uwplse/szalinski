medallion_diameter = 50;
part_height = 3;
string_hole_diameter = 4;
wall_thickness = 2;
$fn = 50;

difference() {
    cylinder(d=medallion_diameter, h=part_height);
    translate([(medallion_diameter/2)-string_hole_diameter-wall_thickness,0,0]) cylinder(d=string_hole_diameter, h=part_height);
}