//Use input dimensions
wallThickness = 3.4;
rodDiameter = 33;
ceilingToTop=20;//Hanging distance from ceiling to top of rod
unitHeight = 30;
blockY = 50; //Distance on ceiling between screw mounts
sideTabs=10; //Length of side tabs for screw holes
mountingBlockHeight=10; //Thickness of mounting block
screwHeadDiameter=9;
screwHeadHeight=3;
screwShaft=4.2;
tapScrewDiameter=3;
orientation="both";//Either "parallel", "perpendicular", or "both"


//calculated dimensions
ceilingToCenter=rodDiameter/2+ceilingToTop;//Hanging distance from ceiling to center of rod;
blockD = blockY; //Irrelevant; Resized in code below.
blockR = blockD/2;
blockX = ceilingToCenter+wallThickness; 
baseAngle = atan(blockX/(blockY/2));
topAngle = 180-2*baseAngle;
mountingBlockWidth=blockY+2*sideTabs;


//Make the triangular shape
module triangle1() {
    resize([blockX,blockY,unitHeight])
    translate([blockR*sin(30),0,0])
    cylinder(d=blockD,h=unitHeight,$fn=3);
}
module triangle2() {
    blockY1 = blockY-2*wallThickness/tan(baseAngle/2);
    blockX1 = blockX-wallThickness-wallThickness/sin(topAngle/2);
    translate([wallThickness,0,0])
    resize([blockX1,blockY1,unitHeight])
    translate([blockR*sin(30),0,0])
    cylinder(d=blockD,h=unitHeight,$fn=3);
}

module triangle() {
    difference() {
        triangle1();
        triangle2();
    }
    intersection(){
        translate([0,-blockY/2,0])
        cube([mountingBlockHeight,blockY,unitHeight]);
        triangle1();
    }
}

module mountingBlock() {  
    translate([0,-mountingBlockWidth/2,0])
    cube([mountingBlockHeight,mountingBlockWidth,unitHeight]);
}

module unitPerpendicular() {
    difference(){
        union(){
            translate([ceilingToCenter,0,0])
            cylinder(d=rodDiameter+2*wallThickness,h=unitHeight);
            triangle();
            translate([0,-wallThickness/2,0])
            cube([blockX-wallThickness,wallThickness,unitHeight]);
        }
        translate([ceilingToCenter,0,0])
        cylinder(d=rodDiameter,h=unitHeight);
    }
    mountingBlock();
}

//Make screw holes
module finalUnitPerpendicular() {
    difference(){
        unitPerpendicular();
        union(){
            translate([0,mountingBlockWidth/2-screwHeadDiameter/2-wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=screwShaft,h=mountingBlockHeight);
            translate([mountingBlockHeight-screwHeadHeight,mountingBlockWidth/2-screwHeadDiameter/2-wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d1=screwShaft,d2=screwHeadDiameter,h=screwHeadHeight);
            translate([0,-mountingBlockWidth/2+screwHeadDiameter/2+wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=screwShaft,h=mountingBlockHeight);
            translate([mountingBlockHeight-screwHeadHeight,-mountingBlockWidth/2+screwHeadDiameter/2+wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d1=screwShaft,d2=screwHeadDiameter,h=screwHeadHeight);
            translate([ceilingToCenter+rodDiameter/2-wallThickness,0,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=tapScrewDiameter,h=wallThickness*2,$fn=50);
        }
    }
}

module unitParallel() {
    difference(){
        union(){
            translate([ceilingToCenter,unitHeight/2,unitHeight/2])
            rotate([90,0,0])
            cylinder(d=rodDiameter+2*wallThickness,h=unitHeight);
            triangle();
            translate([0,-wallThickness/2,0])
            cube([blockX-wallThickness,wallThickness,unitHeight]);
        }
        translate([ceilingToCenter,mountingBlockWidth/2,unitHeight/2])
        rotate([90,0,0])
        cylinder(d=rodDiameter,h=mountingBlockWidth);
    }
    mountingBlock();
}

//Make screw holes
module finalUnitParallel() {
difference(){
        unitParallel();
        union(){
            translate([0,mountingBlockWidth/2-screwHeadDiameter/2-wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=screwShaft,h=mountingBlockHeight);
            translate([mountingBlockHeight-screwHeadHeight,mountingBlockWidth/2-screwHeadDiameter/2-wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d1=screwShaft,d2=screwHeadDiameter,h=screwHeadHeight);
            translate([0,-mountingBlockWidth/2+screwHeadDiameter/2+wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=screwShaft,h=mountingBlockHeight);
            translate([mountingBlockHeight-screwHeadHeight,-mountingBlockWidth/2+screwHeadDiameter/2+wallThickness,unitHeight/2])
            rotate([0,90,0])
            cylinder(d1=screwShaft,d2=screwHeadDiameter,h=screwHeadHeight);
            translate([ceilingToCenter+rodDiameter/2-wallThickness,0,unitHeight/2])
            rotate([0,90,0])
            cylinder(d=tapScrewDiameter,h=wallThickness*2,$fn=50);
        }
    }
}

if(orientation=="parallel") {
    finalUnitParallel();
}
if(orientation=="perpendicular") {
    finalUnitPerpendicular();
}
if(orientation=="both") {
    translate([0,-mountingBlockWidth*1.2/2,0])
    finalUnitParallel();
    translate([0,mountingBlockWidth*1.2/2,0])
    finalUnitPerpendicular();
}



