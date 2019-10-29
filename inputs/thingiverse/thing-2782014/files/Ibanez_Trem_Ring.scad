// A substitute for nylon rings for Low-Pro Edge style tremolo arms


$fn = 50;
innerDiameter = 4;
outerDiameter = 6;
height = 3.8; // make it a bit lower to fit easily
cutout = 2;

difference () {
    difference () {
        cylinder(h = height, r1 = outerDiameter / 2, r2 = outerDiameter / 2, center = true);
        cylinder(h = height *2, r1 = innerDiameter / 2, r2 = innerDiameter / 2, center = true);
    }
    translate ([outerDiameter / 2,0,0])
    cube([outerDiameter, cutout, height * 2], center=true);
}