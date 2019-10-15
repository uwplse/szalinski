holder_height = 50;
holder_width = 54;
holder_wall_thickness = 2;

length = holder_height+1;
width = holder_width-(2*holder_wall_thickness)-1;

union(){
    difference(){
        cube([width, length, 2], center=true);
        translate([0,(length/2)-2,0])cube([20, 4, 2], center=true);
    }
    translate([0, -((length/2)-2), .5])cube([holder_width, 4, 3], center=true);
}