// Depth
X = 15;//[5:100]

//Size
Y = 33;//[5:100]

//High
Z = 7;//[5:30]

//Wall thickness
Wall = 2.8;//[0.8,1.2,1.6,2,2.4,2.8]

//Cut hole for cables
CUT = 5;//[0:none,5,10,15]


/* [Hidden] */
$fn = 100;

module shape(x,y,z) {
    R=6;
    minkowski() {
        cube([x-R,y-R,z], center=true);
        cylinder(d=R);
    }
}

module piece(X,Y,Z,W, CUT=0){
    translate([0,0,Z/2])
    difference() {
        //Outer
        shape(X,Y,Z);
        //Inner
        shape(X-W,Y-W,Z+0.1);
        //Cut
        translate([X/2, 0, 0]) rotate([40,0,0]) cube([W+5, CUT, Z*5], center=true);
    }
}

//Create one piece
piece(X, Y, Z, Wall, CUT);

