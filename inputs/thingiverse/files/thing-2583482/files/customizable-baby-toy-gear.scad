use <MCAD/involute_gears.scad>

// Include locating pins that make the gears stackable?
LocatingPins = true; 

01_number_of_teeth = 15; //15 teeth minimum for first gear, 20 teeth for second, 25 teeth for largest gear

//the distance from the pitch apex to the outside pitch diameter
02_cone_distance = 10000;

//THICKNESS OF THE GEAR
03_face_width = 12;

//controls the size of the teeth (and hence the size of the gear). The circular pitch at the outside pitch diameter.
04_outside_circular_pitch =  530;

//controls the shape of the teeth
05_pressure_angle = 20;

//gap between the tip of the teeth on one gear and the root of the teeth on another meshing gear
06_clearance = .2;

//size of the hole in the middle
07_bore_diameter = 15;

//??JUNK 08_gear_thickness = 10;

//makes the tooth width smaller to make a gap between teeth of correctly spaced gears to allow for manufacturing tolerances
09_backlash = 0;

//the number of facets in one side of the involute tooth shape
10_involute_facets = 0;

11_finish = 0; //[0:Flat,1:Back Cone]

difference(){
union(){
bevel_gear(	number_of_teeth = 01_number_of_teeth,
		cone_distance = 02_cone_distance,
		face_width = 03_face_width,
		outside_circular_pitch =  04_outside_circular_pitch,
		pressure_angle = 05_pressure_angle,
		clearance = 06_clearance,
		bore_diameter = 07_bore_diameter,
		gear_thickness = 08_gear_thickness,
		backlash = 09_backlash,
		involute_facets = 10_involute_facets,
		finish = 11_finish
);
    
// /*
    if (LocatingPins == true){
//Locating Pins 
    difference(){
translate([15,0,14]){cylinder(h=8,r1=6./2,r2=5.8/2, center = true);}
translate([15,0,18]){cube([10,1.,10],center = true);}

}
 difference(){
translate([0,15,14]){cylinder(h=8,r1=6/2,r2=5.8/2, center = true);}
translate([0,15,18]){cube([10,1.,10],center = true);}
}

 difference(){
translate([0,-15,14]){cylinder(h=8,r1=6/2,r2=5.8/2, center = true);}
translate([0,-15,18]){cube([10,1.,10],center = true);}
}
 difference(){
translate([-15,0,14]){cylinder(h=8,r1=6/2,r2=5.8/2, center = true);}
translate([-15,0,18]){cube([10,1.,10],center = true);}
}
// */

}}

//Locating Pin Holes
translate([15,0,0]){cylinder(h=10*2,r1=6.5/2,r2=6.05/2, center = true);}
translate([0,15,0]){cylinder(h=10*2,r1=6.5/2,r2=6.05/2, center = true);}
translate([-15,0,0]){cylinder(h=10*2,r1=6.5/2,r2=6.05/2, center = true);}
translate([0,-15,0]){cylinder(h=10*2,r1=6.5/2,r2=6.05/2, center = true);}


//Press fit for bearing
cylinder(h=7.25*2,r1=22.5/2,r2=22.1/2, center = true);

/*
difference(){//Cut out for making a press on handle cover or lever arm 
cylinder(h=300,r=200, center = true);
    cylinder(h=300,r=18.75, center = true);
}
*/
}

//HANDLE
//rotate([0,0,45]){translate([60/2+17.5,0,6]){cube([60,12,12],center = true);}}


//Just for Sizing, because im not sure what the diamete rof the gear is right now..
//I want it to be 40mm, 60mm, & 80mm range
//cylinder(h=1,r=60/2, center = true);
