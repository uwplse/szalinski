// Inner diameter of the cylinder
innerDiameter = 61.0;
innerRadius = innerDiameter / 2.0;

// Height of cylinder base
baseHeight = 1.2;

// Height of each item being put in the stack
itemHeight = 9.5;
// Number of items to put in the stack
itemCount = 11;

// Wall thickness
wallThickness = 2.0;

$fn=50;
difference() {
    union() {
        cylinder(h=(itemHeight*itemCount) + baseHeight,
                 r=(innerRadius + wallThickness)
        );
    }
    
    // Bottom finger hole
    translate([0,0,-0.1])
        cylinder(h=baseHeight+0.2,d=innerDiameter/3);
    
    // Inner cylinder
    translate([0,0,baseHeight]) cylinder(h=(itemHeight*itemCount)+0.1,r=innerRadius);
    
    // Rounded cutouts
    rotate([0,90,0])
        translate([-(itemHeight*itemCount)-15-baseHeight-1,0,-innerDiameter*0.75])      hull() {
            cylinder(h=innerDiameter*1.5,d=30);
            translate([itemHeight*itemCount,0,0])
                cylinder(h=innerDiameter*1.5,d=30);
          }
}