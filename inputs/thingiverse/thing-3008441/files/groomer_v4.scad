/*
Description: Coffee Groomer designed to evenly
distribute coffee grind within the portafilter 
basket before tamping.

Created by: Alan Lin
Date: 4/20/2018
*/

module groomer(depth, height, radius){
    $fn=50;

    difference(){ // bottom silo
        // outside wall
        cylinder(depth + 2, radius, radius);
        // inside wall
        cylinder(depth + 2, radius - 1, radius - 1);
    }
    // top rim
    translate([0, 0, depth - 2]){    
        difference(){ // top silo
            // outside wall
            cylinder(height, radius + 1, radius + 1); 
            // inside wall
            cylinder(height, radius - 1, radius - 1);
        }
        difference(){ // top hat rim
            // outside
            cylinder(1, radius + 4, radius + 4);
            // inside
            cylinder(1, radius, radius);
        }
    }
    // groom bridges
    translate([-(radius-1), -.5, 0]){
        cube([((radius-1)*2)+.25, 1, 1]);
    }
    rotate(a=-45, v=[0, 0, 1]){
        translate([-(radius-1), -.5, 0]){
            cube([((radius-1)*2)+.25, 1, 1]);
        }
    }
    rotate(a=45, v=[0, 0, 1]){
        translate([-(radius-1), -.5, 0]){
            cube([((radius-1)*2)+.25, 1, 1]);
        }
    }
}
//(depth, height, radius)
groomer(10, 16, 28);