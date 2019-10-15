echo(version=version());

// simple cut out cylinder
innerDiameter = 4;
outerDiameter = 5;
innerHeight = 8;
outerHeight = 9;

difference() {
cylinder(d=outerDiameter,h=outerHeight, $fn=32);
    CutOut(innerDiameter, innerHeight);
}

module CutOut(innerDiameter, innerHeight) {
    translate([0, 0, outerHeight-innerHeight])
    cylinder(d=innerDiameter, h=outerHeight, $fn=32);
}