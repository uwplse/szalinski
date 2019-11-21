/* [Flat ring settings] */

ringWidth = 40;
ringDepth = 20;
ringHeight = 10;
wall = 3;

/* [Pin settings] */

pinNbWidth = 2;
pinNbHeight = 2;
pinTopHeight = 8.25;
pinMargin = 0.5;

/* [Pegboard settings] */

pegboardOffsetWidth = 25;
pegboardOffsetHeight = 25;
pegboardHole = 3.5;
pegboardThickness = 1;

/* [Hidden] */

// calc settings

//MpinNbWidth = floor(ringWidth/pegboardOffsetWidth);
//MpinNbHeight = floor(ringHeight/pegboardOffsetHeight) == 0 ? 1:floor(ringHeight/pegboardOffsetHeight);

MpinNbWidth = pinNbWidth-1;
MpinNbHeight = pinNbHeight-1;


// file settings

$fn = 100;
rotX = [1,0,0];
rotY = [0,1,0];
rotZ = [0,0,1];


module Pin( x, y ){
    
    height = pinTopHeight+pegboardOffsetHeight*y;
    
    translate([x*pegboardOffsetWidth, 0, 0])
        intersection() {
            rotate(90,rotY)
                rotate_extrude(angle = 90)
                    translate([height, 0, 0])
                        circle(pegboardHole-pinMargin);

            translate([-height, -(pinTopHeight+(pegboardHole-pinMargin)), -height*2])
                cube([height*2,(pinTopHeight+(pegboardHole-pinMargin))*2,height*2]);
        }
    
}

module Pins(nb){
    translate([-(MpinNbWidth*pegboardOffsetWidth)/2, 0, 0]) {
        Pin( 0, 0 );
        Pin( 0, MpinNbHeight );
        Pin( MpinNbWidth, 0 );
        Pin( MpinNbWidth, MpinNbHeight );
    }
}

module Plate(){
    translate([-(MpinNbWidth*pegboardOffsetWidth)/2, 0, 0]) {
        height = MpinNbHeight*pegboardOffsetHeight+pinTopHeight-(pegboardHole-pinMargin);
        width = MpinNbWidth*pegboardOffsetWidth;
        minkowski() {
            translate([0, -wall+1, -height])
                cube([width,wall-1,height]);
            translate([0, 0, -wall])
                rotate(90,rotX)
                    cylinder(1, r=pegboardHole-pinMargin);
        }
    }
}

module In(){
    height = MpinNbHeight*pegboardOffsetHeight+pinTopHeight+pegboardHole-pinMargin;
    hull() {
        translate([-ringWidth/2+ringDepth/2, -ringDepth/2, -height*1.5])
            cylinder((height)*2, r=(ringDepth-wall*2)/2);
        translate([ringWidth/2-ringDepth/2, -ringDepth/2, -height*1.5])
            cylinder((height)*2, r=(ringDepth-wall*2)/2);
    }
}

module Ovale(){
    height = MpinNbHeight*pegboardOffsetHeight+pinTopHeight+pegboardHole-pinMargin-ringHeight;
    translate([0, -ringDepth, -height-ringHeight])
    resize([ringWidth,ringDepth*2-wall*2,height*2])
    rotate(90,rotY)
    cylinder(1, r=1, center=true);
}

module ring(){
    difference() {
        translate([0, 0, 0]) {
            height = MpinNbHeight*pegboardOffsetHeight+pinTopHeight+pegboardHole-pinMargin;
            difference() {
                hull() {
                    translate([-ringWidth/2+ringDepth/2, -ringDepth/2, -height])
                        cylinder(height, r=ringDepth/2);
                    translate([ringWidth/2-ringDepth/2, -ringDepth/2, -height])
                        cylinder(height, r=ringDepth/2);
                }
                In();
            }
        }
        Ovale();
    }
}


difference() {
    Pins();
    In();
    Ovale();
}
ring();
//Plate();








