iphone_size_x = 65;
iphone_size_y = 12;
iphone_size_z = 30;

hole_size_x = 45;
hole_size_y = 7.5;

iphone_cable_z = 60;

screen_size_x = 55;
screen_pos_z = 5;

box_over = 5;

rotate([-90, 0, 0]) {
    difference() {
        translate([0, 0, -iphone_cable_z/2])
            cube([iphone_size_x+box_over, iphone_size_y+box_over, iphone_size_z+box_over+iphone_cable_z], center=true);
        translate([0, 0, box_over])
            cube([iphone_size_x, iphone_size_y, iphone_size_z], center=true);
        translate([0, -box_over, box_over*2])
            cube([screen_size_x, iphone_size_y, iphone_size_z], center=true);
        translate([0, -box_over/2, -(iphone_cable_z/2)-box_over*4])
            cube([iphone_size_x, iphone_size_y+box_over, iphone_cable_z], center=true);
        translate([0, 0, -(iphone_cable_z/2)])
            cube([hole_size_x, hole_size_y, iphone_cable_z], center=true);
    }
}