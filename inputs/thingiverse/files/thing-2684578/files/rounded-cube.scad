/* [Dimensions] */

width = 30;
height = 20;
depth = 15;

// The radius of the corners. Zero will make a normal box.
radius = 2;

/* [Hidden] */

$fn = 100;
c = true;

module cubeR( size=10, r=1, center=false ) {
    if( len(size) == undef ) {        
        cubeR(size=[for(i = [1 : 3]) size], r=r, center=center);
    } else {
        translate([for(i = size) center ? 0 : r ])
        minkowski() {
            cube(size=[for(i = size) i - (r * 2) ], center=center);
            sphere(r=r, center=center);
        }
    }
}

render(1) 
cubeR([width, height, depth], radius, c);
