//## Stopfen fuer Gaerspund

RadiusBottom = 15;
RadiusTop = 19;
Height = 25;

difference() {
    hull() {
        cylinder(r=RadiusBottom, h=0.1, $fn=64);
        translate([0, 0, Height-0.1])
            cylinder(r=RadiusTop, h=0.1, $fn=64);
    }
    cylinder(r=5, h=Height);
}