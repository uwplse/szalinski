
wallThickness = 1.6;
bowlSizeX = 166;
bowlSizeY = 166;
lidHeight=10;

difference() {
    cube([bowlSizeX+2*wallThickness, bowlSizeY+2*wallThickness, lidHeight+wallThickness]);
    translate([wallThickness, wallThickness, wallThickness]) {
        cube([bowlSizeX, bowlSizeY, lidHeight+1]);
        for (i=[10:10:bowlSizeX-10]) {
            for (j=[10:10:bowlSizeY-10]) {
                translate([i+(bowlSizeX%10)/2,j+(bowlSizeY%10)/2,-wallThickness-1]) {
                    cylinder(r=5/2, h=wallThickness+2, $fn=6);
                }
            }
        }
    }
}


