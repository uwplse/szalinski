//simple plant pot

//Diameter of base in mm
baseD = 35;

//Height of pot in mm
potH = 40;

// The sides are this many degrees from verticle
sideSlope = 10; //[0:1:90]

//Thickness of the pot size
potThick = 1;


/* [Holes in Base] */

// Number of holes
nHoles = 6;//[0:1:10]

// Size of Holes diameter in mm
sHoles = 3;//


difference() {
    pot();
    holes(nHoles, sHoles);
}

// preview[view:south, tilt:top]

module holes(n, s){
    for(i = [0:n]){
        rotate([0,0,i*360/n]) translate([baseD/4,0,0]) cylinder(d=s, h=2*potThick, center=true, $fn=16);
    }
}

module pot(){
difference(){
minkowski(){    
cylinder(d1=baseD, d2=baseD+potH*tan(sideSlope) , h=potH, $fa=3);
sphere(r=potThick, $fn=16);
}//!minkowski
cylinder(d1=baseD, d2=baseD+potH*tan(sideSlope) , h=potH, $fa=3);
//slice top off
translate([0,0,potH]) cylinder(d=2*baseD, h= 2*potThick, center=true);

    
}//!diff
}