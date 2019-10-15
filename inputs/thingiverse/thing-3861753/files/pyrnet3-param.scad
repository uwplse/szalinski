
height = 20;

pyramid(height);
translate([0,2*height+1,0]) pyramid(height);
translate([0,4*height+2,0]) pyramid(height);
translate([0,6*height+3,0]) pyramid(height);

translate([2*height+1,0,0]) pyramid(height);
translate([-2*height-1,0,0]) pyramid(height);

translate([0,3*height+2,0]) cube(size=[2*height+1, 8*height+4,.4], center=true);
translate([0,0,0]) cube(size=[6*height+3, 2*height+1,.4], center=true);

module pyramid(height) {
    edge = 2*height;
    tinyValue = 0.0001;
    hull() {
        cube(size=[edge, edge,tinyValue], center=true);
        translate([0, 0, height]) cube(size=[tinyValue, tinyValue, tinyValue], center=true);
    }


}