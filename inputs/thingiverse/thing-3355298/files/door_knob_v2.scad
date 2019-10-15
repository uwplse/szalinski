// door_knob_v2.scad
// code inspired by: https://www.thingiverse.com/thing:3341986
// last update:19.01.2019 by djgan
// Version: 2.0

//Radius of the wheel inner
wheel_radius=15.15; 
//Radius of the wheel outer
wheel_radius2=20; 

//Height of the wheel inner
wheel_height=25;
//Height of the wheel outer
wheel_height2=25;

//Number of steps on the wheel for grip
wheel_steps=6; // inner
wheel_steps2=8; // outer

$fn=120;

module regular_polygon(order, r=1){
 	angles=[ for (i = [0:order-1]) i*(360/order) ];
 	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
 	polygon(coords);
 }
 
 
union()  {
    translate([0,0,wheel_height]);  // inner
    translate([0,0,wheel_height2]); // outer
            // start outer
     difference() {
         cylinder(wheel_height2,wheel_radius2,wheel_radius2);
         grip_radius2=2*3.14*wheel_radius2/4/wheel_steps2; 
         grip_translate2=wheel_radius2+1/3*grip_radius2; 

         for(count=[0:1:wheel_steps2-1]) {
             angle=360/wheel_steps2*count;
             rotate(angle,[0,0,1]) {
             translate([grip_translate2,0,0]) cylinder(wheel_height2,grip_radius2,grip_radius2);
             }
         } 
        // start inner
            difference() {
                cylinder(wheel_height,wheel_radius,wheel_radius);
                grip_radius=1*3.14*wheel_radius/5/wheel_steps; 
                grip_translate=wheel_radius+1/2*grip_radius; 

                for(count=[0:1:wheel_steps-1]) {
                    angle=360/wheel_steps*count;
                    rotate(angle,[0,0,1]) {
                    translate([grip_translate,0,0]) cylinder(wheel_height,grip_radius,grip_radius);
                    }
                   } 
            }  // end inner
     }  // end outer
 } 