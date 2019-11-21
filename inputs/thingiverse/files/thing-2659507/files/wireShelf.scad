/* [Parameters] */

width = 50;
depth = 20;
numShelves = 1;

/* [Hidden] */
postRadius = 1.5;
wireSize = 1.2;
wireGap = 2;
splitGap = 0.5;

shelfH = 5;

wallThick = 0.8;
clearanceR = 0.25;

outerR = postRadius + wallThick + clearanceR;
innerR = postRadius + clearanceR;

$fn = 32;

module shelf(w, d) {
    
    difference() {
    difference() {
    difference() {
    union() {
        difference() {
            cube([w,d,shelfH/2]);
            translate([wireSize, wireSize, -shelfH/2])
            cube([w-wireSize*2, d-wireSize*2, shelfH*2]);
        }
        
        numWires = floor(d / (wireSize + wireGap));
        
        wireSpaceD = (d / numWires);
        
        for (i=[1:numWires-1]) {
        
            translate([0, i*wireSpaceD - (wireSize/2), 0])    
            cube([w, wireSize, wireSize]);
            
        }
        
        if ((w / d) > 1.25) {
            
            numReinforce = floor(w/d);
            reinforceGap = w / (numReinforce + 1);
            
            for (i=[1:numReinforce]) {
                translate([i*reinforceGap-wireSize/2, 0, 0])
                cube([wireSize, d, shelfH/2]);
            }
        }
        
        translate([0,0,0])
        cylinder(r=outerR, h=shelfH);

        translate([w,0,0])
        cylinder(r=outerR, h=shelfH);

        translate([w,d,0])
        cylinder(r=outerR, h=shelfH);

        translate([0,d,0])
        cylinder(r=outerR, h=shelfH);
    }
    
    
    union() {
        translate([0,0,-shelfH/2])
        cylinder(r=innerR, h=shelfH*2);

        translate([w,0,-shelfH/2])
        cylinder(r=innerR, h=shelfH*2);

        translate([w,d,-shelfH/2])
        cylinder(r=innerR, h=shelfH*2);

        translate([0,d,-shelfH/2])
        cylinder(r=innerR, h=shelfH*2);
    
        translate([-w/2, -d/2, -shelfH/4-2])
        cube([w*2, d*2, 2]);
    }
}

    translate([-splitGap,0,-shelfH/2])
    cube([splitGap, d, shelfH*2]);
    }
    translate([w,0,-shelfH/2])
    cube([splitGap, d, shelfH*2]);
}
}


for (i=[0:numShelves-1]) {
    translate([0, i * (depth + 10),0])
    shelf(width, depth);
}


// cylinder(r=postRadius, h=50);