// the higher the number, the better the circle
object_quality = 60;

rows = 5;
columns = 9;

module earing_holder () {
    difference() {
        translate ([4,0,0])
            scale ([1,1,1])
            linear_extrude(height=2)
            circle (d=10);
        translate ([5,0,-1])
            linear_extrude(height=4)
            circle (d=3);
    };
    difference() {
        translate ([-4,0,0])
            scale ([1,1,1])
            linear_extrude(height=2)
            circle (d=10);
        translate ([-5,0,-1])
            linear_extrude(height=4)
            circle (d=3);
    };
}

$fn = object_quality;

for (j=[0:columns-1]) {
    for (i=[0:rows-1]) {
        translate ([(18+2)*i,(9+2)*j,0])
        earing_holder();
    }
}