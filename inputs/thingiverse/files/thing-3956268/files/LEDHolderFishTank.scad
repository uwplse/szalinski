length = 150;
height = 15;
thickness = 5;
gap = 15;
overlap = gap/2-thickness/2;
shortBarLength = 5;
shortBarWidth = 10;
longBarLength = shortBarLength + 20;
longOffset = 6;
outerR = 14;
holderOverlap = 2;
holeR = 6;
holderThickness = 1;
supportThickness = 5;
cylinderOverlap = 1;
supportHoleR = 7.5;
boltRadius = 2.5;
boltLength = thickness + cylinderOverlap * 2;
cylinderResolution = 360;
boltHeightOffset = holderThickness+supportThickness + (height - holderThickness-supportThickness) / 2;
boltXOffset = overlap / 2;
boltDepthFromEdge = 3;

difference() {
    // bar
    translate([-length/2,0,0])
        cube([length,thickness,height]);
    // connecting bolt hole    
    translate([length/2-boltXOffset-boltDepthFromEdge,cylinderOverlap+thickness,boltHeightOffset])
        rotate([90,0,0])
            cylinder(h=boltLength, r = boltRadius,$fn=cylinderResolution); 
    // centre bolt hole    
    translate([0,cylinderOverlap+thickness,boltHeightOffset])
        rotate([90,0,0])
            cylinder(h=boltLength, r = boltRadius,$fn=cylinderResolution);
}

difference() {        
    // overlap
    translate([-length/2-overlap-longOffset,-thickness,0])
        cube([overlap*2+longOffset,thickness,height]);
    // bolt hole    
    translate([-length/2-boltXOffset-boltDepthFromEdge,cylinderOverlap,boltHeightOffset])
        rotate([90,0,0])
            cylinder(h=boltLength, r = boltRadius,$fn=cylinderResolution);
}

for (i = [1:5]) {
    // short bars
    translate([-length/2+gap/2+2*(i-1)*gap-shortBarWidth/2,-shortBarLength,0])
        cube([shortBarWidth,shortBarLength,thickness]);

    // long bars
    //translate([-length/2+i*2*gap-gap/2-thickness/2-longOffset,-longBarLength,0])
    //    cube([thickness,longBarLength,thickness]);
    
    // short bar holder
    difference() {
        translate([
            -length/2+gap/2+2*(i-1)*gap,
            -shortBarLength-outerR+holderOverlap,
            0])
            cylinder(h=holderThickness, r = outerR, $fn=cylinderResolution);
        translate([
            -length/2+gap/2+2*(i-1)*gap,
            -shortBarLength-outerR+holderOverlap,
            -cylinderOverlap])
            cylinder(h=holderThickness+cylinderOverlap*2, r = holeR, $fn=cylinderResolution);
        if (i == 1) {
            // Nick the "corner" out of the first one so they fit together
            translate([
                -length/2+(i-1)*2*gap-gap/2,
                -longBarLength-outerR+holderOverlap,
                0])
                cylinder(h=holderThickness, r = outerR+0.5, 
                    $fn=cylinderResolution);
        }
    }

    
    difference() {
        translate([
            -length/2+gap/2+2*(i-1)*gap,
            -shortBarLength-outerR+holderOverlap,
            holderThickness])
            cylinder(h=supportThickness, r = outerR, $fn=cylinderResolution);
        translate([
            -length/2+gap/2+2*(i-1)*gap,
            -shortBarLength-outerR+holderOverlap,
            -1+holderThickness])
            cylinder(h=supportThickness+cylinderOverlap*2, r = supportHoleR, $fn=cylinderResolution);
        if (i == 1) {
            // Nick the "corner" out of the first one so they fit together
            translate([
                -length/2+(i-1)*2*gap-gap/2,
                -longBarLength-outerR+holderOverlap,
                holderThickness])
                cylinder(h=supportThickness, r = outerR+0.5, 
                    $fn=cylinderResolution);
        }
    }
    // long bar holder
    difference() {
        translate([
            -length/2+i*2*gap-gap/2,
            -longBarLength-outerR+holderOverlap,
            0])
            cylinder(h=holderThickness, r = outerR, $fn=cylinderResolution);
        translate([
            -length/2+i*2*gap-gap/2,
            -longBarLength-outerR+holderOverlap,
            -cylinderOverlap])
            cylinder(h=holderThickness+cylinderOverlap*2, r = holeR, $fn=cylinderResolution);
    }
    difference() {
        translate([
            -length/2+i*2*gap-gap/2,
            -longBarLength-outerR+holderOverlap,
            holderThickness])
            cylinder(h=supportThickness, r = outerR, $fn=cylinderResolution);
        translate([
            -length/2+i*2*gap-gap/2,
            -longBarLength-outerR+holderOverlap,
            -1+holderThickness])
            cylinder(h=supportThickness+cylinderOverlap*2, r = supportHoleR, $fn=cylinderResolution);
    }
}