// Beer holder scad file by QBA.WTF
// ATTENTION! This is experimental rewrite of my project to the openscad from SolidWorks
// This is NOT TESTED and provided AS IS - use at your own risk!
// NOTE: Screws holes is without threading

// Variables customization

/* [Part Select] */

part = "open_wall"; // [open_wall: Open Wall, closed_wall: Closed Wall, mounting: Mounting tower]

/* [Wall Settings] */

// Beer bottle/can max diameter [mm]
beer_diameter=90;
// Beer bottle/can holes in one row
beer_holes=3;
// Beer bottle/can rows
beer_rows=2; 

// Space between each rows [mm]
rows_space=3; 
// Space between each beer hole [mm]
beer_space=5; 

// Open Wall height [mm]
open_wall_height=5;
// Closed Wall height [mm]
closed_wall_height=7;
// Closed Wall bottom height [mm]
closed_wall_bottom_height=3;

/* [Wall Mounting Settings] */

// Margin between top and bottom line [mm]
top_and_bottom_margin=3;
// Margin between left and right line [mm]
left_and_right_margin=4.43;

// Screw diameter [mm]
screw_diameter=3; 
// Space between each screw and corner in x/y [mm]
screw_position=6;

/* [Mounting Tower] */

// [Tower] Height of the mounting tower [mm]
tower_mounting_height=120;

// [Tower] Margin between screw [mm]
tower_screw_margin=3;

// Do not touch - system variables!
x_size = (beer_diameter*beer_holes)+(beer_space*(beer_holes-1))+(left_and_right_margin*2);
y_size = (beer_diameter*beer_rows)+(rows_space*(beer_rows-1))+(top_and_bottom_margin*2);

if(part == "open_wall") {
    open_wall();
} else if(part == "closed_wall") {
    closed_wall();
} else if(part == "mounting") {
    mounting();
}

module open_wall() {
    // Main code
    difference() {
                // Rendering open wall and holes
                 translate([0,0,0])
                    cube([x_size,y_size,open_wall_height],center=false);
                 for(r = [0 : 1 : (beer_rows-1)]) {
                     for(i = [0 : 1 : (beer_holes-1)]) {
                         translate([(beer_diameter/2)+left_and_right_margin+(beer_diameter*i)+(beer_space*i),(beer_diameter/2)+top_and_bottom_margin+(beer_diameter*r)+(rows_space*r),0])
                            linear_extrude(height = open_wall_height, center = false, convexity = 10, twist = 0)
                                circle(d=beer_diameter,$fn=360);
                     }
                }
        
        // Rendering screws
        translate([screw_position,screw_position,0])
                    linear_extrude(height = open_wall_height+0, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([x_size-screw_position,screw_position,0])
                    linear_extrude(height = open_wall_height+0, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([screw_position,y_size-screw_position,0])
                    linear_extrude(height = open_wall_height+0, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([x_size-screw_position,y_size-screw_position,0])
                    linear_extrude(height = open_wall_height+0, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
    }
}

module closed_wall() {
    // Main code
    difference() {
        union() {
            difference() {
                // Rendering open wall and holes
                 translate([0,0,closed_wall_bottom_height])
                    cube([x_size,y_size,closed_wall_height],center=false);
                 for(r = [0 : 1 : (beer_rows-1)]) {
                     for(i = [0 : 1 : (beer_holes-1)]) {
                         translate([(beer_diameter/2)+left_and_right_margin+(beer_diameter*i)+(beer_space*i),(beer_diameter/2)+top_and_bottom_margin+(beer_diameter*r)+(rows_space*r),closed_wall_bottom_height])
                            linear_extrude(height = closed_wall_height, center = false, convexity = 10, twist = 0)
                                circle(d=beer_diameter,$fn=360);
                     }
                }
            }
                // Rendering closed wall
                translate([0,0,0])
                    cube([x_size,y_size,closed_wall_bottom_height],center=false);
            }
        
        // Rendering screws
        translate([screw_position,screw_position,0])
                    linear_extrude(height = open_wall_height+closed_wall_bottom_height, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([x_size-screw_position,screw_position,0])
                    linear_extrude(height = open_wall_height+closed_wall_bottom_height, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([screw_position,y_size-screw_position,0])
                    linear_extrude(height = open_wall_height+closed_wall_bottom_height, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
        
        translate([x_size-screw_position,y_size-screw_position,0])
                    linear_extrude(height = open_wall_height+closed_wall_bottom_height, center = false, convexity = 10, twist = 0)
                        circle(d=screw_diameter,$fn=360);
    }
}

module mounting() {
    difference() {
        translate([0,0,0])
            linear_extrude(height = tower_mounting_height, center = false, convexity = 10, twist = 0)
            circle(d=screw_diameter+tower_screw_margin,$fn=360);
        
         translate([0,0,0])
            linear_extrude(height = tower_mounting_height, center = false, convexity = 10, twist = 0)
            circle(d=screw_diameter,$fn=360);
    }
}