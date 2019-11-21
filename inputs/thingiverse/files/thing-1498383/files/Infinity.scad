// needle size
holeSize = 5;
number = 2;

module earing_holder () {
    difference() {
        union() {
            translate ([4,0,0])
                scale ([1,1,1])
                circle (d=10,center=true);
            translate ([-4,0,0])
                scale ([1,1,1])
                circle (d=10,center=true);
        }
        union() {
            holeCenter = 4+5-2 -(holeSize+tolerance)/2; 
            translate ([holeCenter,0,-1])
                circle (d=holeSize+tolerance,center=true);
            translate ([-holeCenter,0,-1])
                circle (d=holeSize+tolerance,center=true);
        }
    };
}

// for volume printg
rows = 1;


tolerance = 0.5;

object_quality = 60;
$fn = object_quality;

linear_extrude(height=2)
for (j=[0:number-1]) {
    for (i=[0:rows-1]) {
        translate ([(18+2)*i,(9+2)*j,0])
        earing_holder();
    }
}