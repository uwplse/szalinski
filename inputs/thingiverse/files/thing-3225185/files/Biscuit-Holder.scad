$fn=128;

// Jumbo = 130
// Mini = 110
// Overall height, including base
height = 110;

// Jumbo = 75
// Mini = 54
// Inner diameter -- make this bigger than the product to be held
innerDiameter = 54;

// Thickness of the tines at the top
minimumThickness = 1.5;

// Thickness of the tines at the bottom
maximumThickness = 14;

// Thickness (top to bottom) of the base
baseThickness = minimumThickness * 4;

// Calculated diameters for the cylinder() function
topDiam = innerDiameter + minimumThickness * 2;
bottomDiam = innerDiameter + maximumThickness * 2;

difference() {
    cylinder(d1=bottomDiam, d2=topDiam, h=height);
    translate([0,0,baseThickness])
        cylinder(d=innerDiameter, h=height);
    translate([0,0,baseThickness+height/2])
        cube([bottomDiam*2, topDiam/2, height], center=true);
    translate([0,0,baseThickness+height/2])
        cube([topDiam/2, bottomDiam*2, height], center=true);
}