LENGTH = 100;
NUT_CUTOUT = 6;
NUT_HEIGHT = 2.7;
SLOT_HEIGHT = 1.2;
CUT_DEPTH = 1.5;
EXTERIOR_SIZE = 15;
CHAMFER = 1.5;
SLOT_OPENING = 3.4;
$fs = 0.1;

module rounded_square(size, fillet){
    
    translation = size/2 - fillet/2;
    
    hull(){
        translate([translation,translation,0])
            circle(d=fillet);
         translate([translation,-translation,0])
            circle(d=fillet);
        translate([-translation,translation,0])
            circle(d=fillet);
        translate([-translation,-translation,0])
            circle(d=fillet);    
    }
    
}

module extrusion_cutout(){
    translate([0,EXTERIOR_SIZE/2 - SLOT_HEIGHT,0])
        square([SLOT_OPENING, SLOT_HEIGHT*2], true);
    translate([0,EXTERIOR_SIZE/2-SLOT_HEIGHT,0])
        polygon([[-NUT_CUTOUT/2,0],[NUT_CUTOUT/2,0],[NUT_CUTOUT/2, -NUT_HEIGHT],[0, -NUT_HEIGHT - CUT_DEPTH],[-NUT_CUTOUT/2, -NUT_HEIGHT]]);
}

module extrusion(){
    difference(){
        rounded_square(EXTERIOR_SIZE, CHAMFER);
        extrusion_cutout();
        rotate([0,0,90])
            extrusion_cutout();
        rotate([0,0,180])
            extrusion_cutout();
        rotate([0,0,270])
            extrusion_cutout();
    }
}

linear_extrude(LENGTH){
    extrusion();
}