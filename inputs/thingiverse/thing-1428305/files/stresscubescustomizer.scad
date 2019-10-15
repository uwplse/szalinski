//These are the midle cubes of the snake, print as many as you like of these


// Show me an end or middle cube (or Both)
show_cubes = "Both"; // [Middle,End,Both]

// How big should the cube  be?
cube = 15; // [10:30]


// How big should the hole be? (I'm using 2mm cord, so have set the hole to 2.4mm)
elastichole = 2.4; 


$fn = 72;



module base() {
    hull(){
        translate([0,0,0])
        cube([cube,cube,cube],center = false);    
    }   
}


module holes_Middle() {
    rotate([0,90,0])
    translate([-cube/2,cube/2,0])
    cylinder(h = cube+1, d = elastichole, center = false);

    translate([cube/2-elastichole/2,0,0])
    cube([elastichole,cube,cube/2],center = false);    

    rotate([90,0,0])
    translate([cube/2,cube/2,-cube])
    cylinder(h = cube, d = elastichole, center = false);

    translate([0,cube/2-elastichole/2,cube/2])
    cube([cube,elastichole,cube/2],center = false);    
}




module holes_end() {

//Top hole for the knot (I've made it 2.4 times bigger than the cord hole    
    translate([cube/2,cube/2,cube-cube/3.5+0.3])
    cylinder(h = cube/3.5, d = elastichole*2.4, center = false);

//I've made the hole for the cord 0.6 bigger so the cord goes through easily
    translate([cube/2,cube/2,7.5])
    cylinder(h = cube, d = elastichole+.6, center = false);


    translate([cube/2-elastichole/2,0,0])
    cube([elastichole,cube,cube/2],center = false);    



    rotate([90,0,0])
    translate([cube/2,cube/2,-cube])
    cylinder(h = cube, d = elastichole, center = false);

}


module Middlecube() {
difference(){
    base();
    holes_Middle();
}
}

module Endcube() {
difference(){
    base();
    holes_end();
}
}


if (show_cubes == "Both") {

Middlecube();

translate([cube+5,0,0])
Endcube();
    
}

if (show_cubes == "Middle") {

Middlecube();


    
}

if (show_cubes == "End") {


Endcube();
    
} 

// preview[view:south, tilt:top]