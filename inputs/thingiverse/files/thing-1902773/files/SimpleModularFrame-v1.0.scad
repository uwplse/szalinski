/*
 * Simple Modular Frame v1.0
 *
 * http://www.thingiverse.com/thing:1902773
 *
 * By: Maxstupo
 */


/* [Frame Settings] */
// (Select what part to generate):
framePart = 1; // [0:3]

// (The width of the plate):
width = 152;

// (The length of the plate):
length = 60;

// (The height of the plate, also used for the stilt generation):
height = 5;

// (The stilt size, and the stilt slot size):
slotSize = 5;

// (The spacing between the edges of the plate and the stilt slots):
spacing = 5;

// (The plate fillet):
fillet = 10;



/* [Frame 2 Settings] */
// (The width between the mount holes from center-to-center):
mountWidth = 20;

// (The length between the mount holes from center-to-center):
mountLength = 40;

// (The diameter of the mount holes):
mountHoleSize = 3;

// (The spacing from the edge of the plate):
mountSpacingFromEdge = 10;


/* [Frame 3 Settings] */
// (The height of the stilt):
stiltHeight = 50;


/* [Misc] */
// (The tolerance to apply to both plates or stilts):
tolerance = 0;

// (The tolerance for the test part #0):
toleranceTest = 0;

$fn=100;

if(framePart == 0) {
    toleranceTest(rodSize=5,rodLength=30,thickness=5,tolerance=toleranceTest);  
    
} else if (framePart == 1) {
    plate(width, length, height, slotSize + tolerance / 2, spacing, fillet);

} else if (framePart == 2) {
    plateWithMotorMountHoles(width, length, height, slotSize + tolerance / 2, spacing, fillet, mountWidth, mountLength, mountHoleSize, mountSpacingFromEdge);

} else if (framePart == 3) {
    stilt(stiltHeight, slotSize - tolerance / 2, height);

}


module toleranceTest(rodSize=5, rodLength=30, thickness=5,tolerance=0){
    // The hole.
    difference(){
        rs=rodSize+(tolerance/2);
        cube([thickness * 2 + rs, thickness * 2 + rs, rodLength / 3]);
        translate([(thickness * 2 + rs) / 2 - rs / 2, (thickness * 2 + rs) / 2 - rs / 2, -1]) cube([rs, rs, rodLength / 3 + 2]);
    }
    
    // The rod.
    translate([thickness * 2 + rodSize + 10, 0, 0]) cube([rodSize - (tolerance / 2), rodLength, rodSize - (tolerance / 2)]);
}

module plate(width=152, length=60, height=5, slotSize=5, spacing=5, fillet=10) {
    r = min(length, fillet);
    
    difference(){
       
        // The plate. 
        if(r > 0){
            hull(){
                translate([(r / 2), (r / 2), 0]) cylinder(h=height, d=r);
                translate([width - (r / 2), (r / 2), 0]) cylinder(h=height, d=r);
                translate([width - (r / 2), length - (r / 2), 0]) cylinder(h=height, d=r);
                translate([(r / 2), length - (r / 2), 0]) cylinder(h=height, d=r);
            }
        }else{
            cube([width, length, height]);
        }
        
        // Stilt holes.
        translate([spacing, spacing, -1]) cube([slotSize, slotSize, height + 2]);
        translate([spacing, length - slotSize - spacing, -1]) cube([slotSize, slotSize, height + 2]);
        translate([width - slotSize - spacing,  spacing, -1]) cube([slotSize, slotSize, height + 2]);
        translate([width - slotSize - spacing, length - slotSize - spacing, -1]) cube([slotSize, slotSize, height + 2]);
    }
}

module plateWithMotorMountHoles(width=152, length=60, height=5, slotSize=5, spacing=5, fillet=10, mountWidth=20,mountLength=40,mountHoleSize=3,mountSpacingFromEdge=5){
    difference(){
        plate(width, length, height, slotSize, spacing, fillet);
        
        translate([mountSpacingFromEdge + mountHoleSize / 2, length / 2 - mountWidth / 2, -1]){
           translate([0, 0, 0]) cylinder(d=mountHoleSize, h=height + 2);
           translate([mountLength, 0, 0]) cylinder(d=mountHoleSize, h=height + 2);
           translate([0, mountWidth, 0]) cylinder(d=mountHoleSize, h=height + 2);
           translate([mountLength, mountWidth, 0]) cylinder(d=mountHoleSize, h=height + 2);
        }
        
        translate([width - mountLength - mountHoleSize / 2 - mountSpacingFromEdge, length / 2 - mountWidth / 2, -1]){
           translate([0, 0, 0]) cylinder(d=mountHoleSize, h=height + 2);
           translate([mountLength, 0, 0]) cylinder(d=mountHoleSize, h=height + 2);
           translate([0, mountWidth, 0]) cylinder(d=mountHoleSize,h=height + 2);
           translate([mountLength, mountWidth, 0]) cylinder(d=mountHoleSize, h=height + 2);
        }
    }
}

module stilt(height=50, size=10, plateHeight=5) {
    union(){
        cube([height+plateHeight, size, size]);
        translate([plateHeight / 2, size, 0]) rightAngleTriangle(a=size, b=size, height=size);
        translate([height+plateHeight/2, size, size]) rotate([0, 180, 0]) rightAngleTriangle(a=size, b=size, height=size);
    }
}


module rightAngleTriangle(a, b, height=1) {
	aCos = cos(90) * a;
	aSin = sin(90) * a;
	polyhedron(
		points=[[0, 0, 0], [b, 0, 0], [aCos, aSin, 0], [0, 0, height], [b, 0, height], [aCos, aSin, height]],
        faces=[[0, 1, 2], [2, 1, 4, 5], [0, 2, 5, 3], [3, 4, 1, 0], [4, 3, 5]]
    );
}