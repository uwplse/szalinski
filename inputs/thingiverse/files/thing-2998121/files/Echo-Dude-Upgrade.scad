/**
 * Echo Dot (2nd generation) upgrade to Echo Dude.
 * Based on "Echo Dude" by redbobpants, https://www.thingiverse.com/thing:2894087
 * @author Robert Schrenk
 * @date 2018-07-10
**/

/* General Options */
// Print a solid back
has_back=1; // [0, 1]

/* Customize Dot Dimensions */
// Width of dot in mm
dot_diameter=85;
// Height of dot in mm
dot_height=33;
// Overhang to hold the dot in mm
dot_overhang=4; // [2,4,6,8]
// Overhang in the top middle to hold the spot in mm, only works when has_back is set to 1
dot_top_overhang=20;

/* Customize Connectors */
// distance from cable-hole from bottom of dot in mm
cable_from_back=9;
// height of cable-hole in mm
cable_height=10;
// width of cable-hole in mm
cable_width=26;
// rotation of cable hole in degree
cable_rotate=-45;

/* Customize Glue Spot */
// Glue spot
gluespot_depth = 1;
gluespot_height = 24;
gluespot_width = 11;

// Do not customize below this line
// width of walls
wall_width=3*1;

difference() {
    cylinder(d=dot_diameter+2*wall_width,h=dot_height+2*wall_width);
    // This is the dot itself
    translate([0,0,wall_width])
        cylinder(d=dot_diameter,h=dot_height);
    if(has_back==1) {
        translate([0,0,wall_width])
            cylinder(d=dot_diameter-dot_overhang,h=dot_height+3*wall_width);
    } else {
        translate([0,0,-2*wall_width+1])
            cylinder(d=dot_diameter-dot_overhang,h=dot_height+4*wall_width);
        // Also cut off the dot_top_overhang
        translate([0,-(dot_diameter+2*wall_width)/2,-wall_width])
        cube([(dot_diameter+2*wall_width),(dot_diameter+2*wall_width),dot_height+4*wall_width]);
    }
    // Cut off upper left area
    translate([0,-(dot_diameter+2*wall_width)/2-dot_top_overhang/2,-wall_width])
        cube([(dot_diameter+2*wall_width)/2,(dot_diameter+2*wall_width)/2,dot_height+4*wall_width]);
    // Cut off upper right area
    translate([0,dot_top_overhang/2,-wall_width])
        cube([(dot_diameter+2*wall_width)/2,(dot_diameter+2*wall_width)/2,dot_height+4*wall_width]);
    rotate([0,0,cable_rotate])
        connectors();
    gluespot();
}

module gluespot() {
    translate([-dot_diameter/2-wall_width,-gluespot_width/2,(dot_height+2*wall_width-gluespot_height)/2])
        cube([gluespot_depth,gluespot_width,gluespot_height]);
}

module connectors(){
    translate([-dot_diameter,0,cable_from_back+wall_width])
    rotate([0,90,0]) {
        translate([-cable_from_back/2,-cable_width/2,0])
            cylinder(d=cable_height,h=dot_diameter);
        translate([-cable_from_back/2,cable_width/2,0])
            cylinder(d=cable_height,h=dot_diameter);
        translate([-cable_from_back/2-cable_height/2,-cable_width/2,0])
            cube([cable_height,cable_width,dot_diameter]);
    }
}