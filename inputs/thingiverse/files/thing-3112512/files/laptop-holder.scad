laptopThickness = 20;
length = 100;
thickness = 4;
height = 50;

difference(){
    union(){
        cube([length, laptopThickness + thickness*2, height]);
        translate([length/2, laptopThickness/2 + thickness, 0]) {
            cylinder(height/2, length/2, laptopThickness/2 + thickness, 0);
        }
    }
    translate([-thickness, thickness, thickness]) {
        cube([length+thickness*2, laptopThickness, height]);
    }
}

