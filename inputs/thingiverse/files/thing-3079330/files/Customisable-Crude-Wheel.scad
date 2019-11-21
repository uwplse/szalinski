//
//  A simple customisable wheel design by MattKi
//  Created because someone had a wheel design in the facebook group which
//  wasn't designed as a proper circle.
//

// How thick is the wheel?
height = 2;
// What's it's outer diameter?
outer_dia = 50;
// What's it's inner diameter?
inner_dia = 40;
// If you want a circle in the middle set this to something greater than zero.
hub_dia = 12;
// How detailed does the wheel need to be? Advisable to keep to 64 or less.
detail = 32;
// How many spokes are there?
spoke_count = 8;
// How thick are the spokes?
spoke_thickness = 3;
// A variable used to avoid face fighting in difference operations.
tol = 0.01;

union(){
    difference(){
        cylinder(h=height,d=outer_dia,$fn=detail*4,center=true); // Our wheel
        cylinder(h=height+tol,d=inner_dia,$fn=detail*4,center=true); // Cut out the inner diameter from the wheel.
    }
    for (a=[0:spoke_count-1]){
        rotate([0,0,a*(360/spoke_count)]) translate([inner_dia/4+tol/2,0,0]) cube([inner_dia/2+tol,spoke_thickness,height],center=true); // Create spokes and rotate them into the right positions.
    }
    cylinder(h=height,d=hub_dia,$fn=detail*4,center=true); // Add a hub in the middle if the user wants it.
}