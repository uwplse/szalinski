// Copyright <senorjp@gmail.com> August 2018
// Low profile Hirth Joint 


// Number of teeth
teeth=47;
// Radius of the mechanism
r = 42;
// Hole in the center
bore = 15;
// constant
pi=3.14159265;
// constant
in=25.4;
// constant
smidge=0.001;
//////////////////////

angle= 360/teeth;

t=2*(r*tan(angle/2))/cos(30); // How big a hexagonal cone do we need to go around the disc (outscribed)

side=t*sin(30); // side of hexagon
roof_h=side*sin(30); // height of "roof" of hexagon

module side() {

difference() {

union() {
for( x = [ 0 : teeth ]) {
    rotate(angle*x, [0,0,1])    
    translate([0,r-0.5,0])
    rotate(-atan(t/2/r)+atan(roof_h/2/r),[1,0,0])
    rotate(360/12, [0,1,0])
    rotate(90, [1,0,0])
    cylinder(r1=t/2+smidge, r2=smidge, h=r, $fn=6); // Made of hexagonal cones    
}
//basal platten
translate([0,0,side/4])
cylinder(r=r, h=side/2+smidge, center=true);

//patch the void under the cones due to slope
translate([0,0,roof_h/4+side/2])
cylinder(r1=r, r2=0, h=roof_h/2, center=true);
}
// hole in the middle
cylinder(r=bore/2, h=t*2, center=true);
// trim the bottom
translate([0,0,-t/2])
cylinder(r=r*2, h=t, center=true);
    
}

}

// function to align the top and bottom when there is an odd number of teeth
function alignment_rotation(teeth) = angle/2 * abs(1-teeth%2) ;

!side();

// To see how two mesh...
separation = roof_h;

translate([0,0,t-roof_h+separation])
rotate(alignment_rotation(teeth), [0,0,1])
rotate(180, [1,0,0])
side();



