
thicknessOfMetal = 2.7;
diameterOfMetal = 24;
stickLength = 90;
heightPadding=2.9;

difference() {
    union() {
        cylinder (r=diameterOfMetal/2+2, h=thicknessOfMetal+heightPadding);
        /* Stick */
        hull() {
            cylinder(r=5, h=thicknessOfMetal+heightPadding);
            translate([0,-stickLength,0]) {
                cylinder(r=5, h=thicknessOfMetal+heightPadding);
            }
        }
        
    }
    translate([0,0,heightPadding == 0 ? -0.05 : heightPadding]) {
        cylinder(r=diameterOfMetal/2+0.4, h=thicknessOfMetal+2, $fn=50);
    }
}


