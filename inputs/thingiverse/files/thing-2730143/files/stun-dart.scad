$fn=100;

// Outside diameter of cone base.
cone_diameter = 9.45;
// Height of cone.
cone_height = 7.25;
cone_hull_height=3.25;
//Thickness of cone walls.
wall = 0.6;
// Outside diameter of cone neck.
cone_neck_diameter = 6.25;
// Height of cone neck.
cone_neck_height = 4;

//baffle
use_baffle=true;
baffle_height=1.75;
baffle_diamerter=3;

// Height of tip neck.
tip_neck_height = 1.25;
// tip
tip_height=5;
tip_diameter=8.65;
//point
use_point=true;

difference() {
    // bottom cylinder
    cylinder(h = cone_height, r1 = cone_diameter/2, r2 = cone_neck_diameter/2);
    // inside cylinder
    #cylinder (h = cone_hull_height, r1 = cone_diameter/2 - wall, r2 = cone_neck_diameter/2 - wall);
}
//baffle
if(use_baffle){
    translate([0,0,-baffle_height])
        cylinder(h = cone_hull_height+baffle_height, d = baffle_diamerter); 
}

translate([0,0,cone_height]) {
    // cone neck
    cylinder(h = cone_neck_height, d = cone_neck_diameter);
    translate([0,0,cone_neck_height]) {
        // tip neck
        cylinder (h = tip_neck_height, r1 = cone_neck_diameter/2, r2 = tip_diameter/2);
        
        translate([0,0,tip_neck_height]) {
            // tip
            cylinder (h = tip_height, r1 = tip_diameter/2, r2 = tip_diameter/2);

            //point
            if(use_point){
                translate([0,0,tip_height])  sphere(r=tip_diameter/2);

            }
        }
    }
}