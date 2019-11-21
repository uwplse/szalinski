// 
// ===============================================================================
//  AUTHOR        : Jose Lopez, JoLoCity
//  DATE          : 12/14/2018
//  DESCRIPTION   : Parametric U Bracket
//  VERSION       : 1.0
// ===============================================================================

width = 50;
height= 20;
thickness = 3;

left_wing_width = 10;
left_wing_height = thickness;

left_column_width = thickness;
left_column_height = height+thickness;

right_wing_width = 10;
right_wing_height = thickness;

right_column_width = thickness;
right_column_height = height+thickness;

bottom_width = width;
bottom_height = thickness;

depth = 7;
hole_size = 5;
resolution = 64;



// main

union() {
    Wing(left_wing_width, left_wing_height, depth, hole_size, 0, left_column_height, "lightgreen");

    //left 
    Side(left_column_width, left_column_height, depth, left_wing_width, 0, "green"); 
    
    //right
    Side(right_column_width, right_column_height, depth, left_wing_width+left_column_width+width, 0, "yellow"); 
    
    //bottom
    Side(width, bottom_height, depth, left_wing_width+left_column_width, 0, "cyan"); 

    Wing(right_wing_width, right_wing_height, depth, hole_size, left_wing_width+left_column_width+width+right_column_width, right_column_height, "red");

}

module Wing(w, h, d, hs, x, z, c) {
    // left wing
    difference () {
        color(c)
            translate([x,0,z-h])
                cube([w,d,h]);

        translate([(w/2)+x, depth/2, (z+1)/2])
            cylinder(h=z+1, d=hs, center=true, $fn=resolution);
    }
}

module Side(w, h, d, x, z, c) {
    color(c)
        translate([x,0,z])
            cube([w,d,h]);    
}
