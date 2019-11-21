res = 150;
dMiddle = 25;
dWallThickness = 5;
dHeight = 30;
dLength = 30;

dXOffsetHolder = dMiddle + (2*dWallThickness);

dHeightHolder = 20;

union() {
    
    // Main Clip
    difference() {
        cubeChamfer([dLength, dXOffsetHolder, dHeight], 3);
        translate([0, dWallThickness, 0]) cube([dLength, dMiddle, dHeight-dWallThickness]);
    }
    
    // Bridge to Holder
    translate([15-2.5, dXOffsetHolder, 15]) cube([5, 6, 10]);
    
    // Holder
    translate([15, dXOffsetHolder+5+5, 10]) difference()
    {
        cylinder(r =7, h = dHeightHolder, $fn=res);
        cylinder(r=4, h=dHeightHolder, $fn=res);
        xCube = 4.5;
        yCube = 7;
        translate([-0.5*xCube, 0, 0]) cube([xCube, yCube, dHeightHolder]);
    }

}

module cubeChamfer(xyz, radius)
{
    x = xyz[0] - 2*radius;
    y = xyz[1] - 2*radius;
    z = xyz[2] - 1;
    translate([radius, radius, 0]) minkowski() {
        cube([x, y, z]);
        cylinder(r=radius, h= 1, $fn=100);
    }
}