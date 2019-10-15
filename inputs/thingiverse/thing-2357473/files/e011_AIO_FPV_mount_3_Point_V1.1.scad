
// Eachine AIO FPV mount
// E011 quadcopter

camWidth = 15.5; // wall thickness .8mm = 17.1 mm outer box size
camDepth = 8;
camHeight = 12;

camLensWidth = 10.2;
camLensOffsetRight = 5; // distance from right side of camera to right side of lens
camLensOffsetBottom = 1;
lensDepth = 8;

LED_CutoutWidth = 8;
LED_CutoutHeight = 4;
LED_OffsetRight = 3.3;
LED_OffsetBottom = 5;

//switchCutoutWidth = 5;
//switchCutoutHeight = 3.2;
//switchOffsetRight = 9.8;
//switchOffsetBottom = 9;

wireCutoutWidth = 3;
wireCutoutHeight = 3.5;
wireOffsetRight = -1.5;
wireOffsetFront = 7;
wireOffsetBottom = 2.5;

wallThickness = 0.8; // 2x .4mm extrusion width

baseHeight = 0.6;

cameraAngle = -20;

antennaDiameter = 2;

module tx01_mount() {

    difference() {
        union() {
            e010_bottom_plate();
            translate ([-((camLensWidth/2)+camLensOffsetRight),-4.5,-1.5]) rotate ([cameraAngle,0,0]) tx01_box();
        }
        // xtal cutout
        translate ([-5,-1,0]) rotate([90,0,0]) cylinder(r=1.8, h=9, center=true, $fn=64);
        // cap cutout
        //translate ([-5,3,-0.2]) cube([3,7,1]);
        // bottom cutoff
        translate ([-18,-18,-36]) cube(36);
    }
}

module tx01_box() {
    difference() {
        // camera box outer size
        cube([camWidth+(wallThickness*2),camDepth+(wallThickness*2),camHeight+6], center=false);
        
        
        // main camera cutout
        translate ([wallThickness,wallThickness,-1]) cube([camWidth,camDepth,32]);
        
        // lens cutout
        translate ([camLensOffsetRight, -.2,camLensOffsetBottom+5.1]) cube([camLensWidth,3,14]);
        // wire cutout
        translate ([wireOffsetRight,wireOffsetFront,wireOffsetBottom+5]) cube ([3,wireCutoutWidth,wireCutoutHeight]);
        // LED cutout
        translate ([LED_OffsetRight+wallThickness,camDepth,LED_OffsetBottom+6]) cube ([LED_CutoutWidth,LED_CutoutHeight,4]);
        // switch cutout
        //translate ([switchOffsetRight+wallThickness,camDepth,switchOffsetBottom+6]) cube ([switchCutoutWidth,switchCutoutHeight,4]);
    }
    
    // right lens protector
    difference() 
    {
        // main baffle
        translate ([camLensOffsetRight-wallThickness*2,-lensDepth-1,-6]) cube([wallThickness,lensDepth+1,camHeight+12]);
        // bottom chamfer
        translate ([camLensOffsetRight-wallThickness*2-.1,-lensDepth-1,-3]) rotate ([25,0,0]) cube([55,4.8,55]);
        // top chamfer
        translate ([camLensOffsetRight-wallThickness*2-.1,-lensDepth-1,17]) rotate ([45,0,0]) cube([55,4.8,55]);
    }
    // left lens protector
    difference() 
    {
        // main baffle
        translate ([camLensOffsetRight+camLensWidth+wallThickness,-lensDepth-1,-6]) cube([wallThickness,lensDepth+1,camHeight+12]);
        // bottom chamfer
        translate ([camLensOffsetRight+camLensWidth+wallThickness-.2,-lensDepth-1,-3]) rotate ([25,0,0])  cube([55,4.6,55]);
        // top chamfer
        translate ([camLensOffsetRight+camLensWidth+wallThickness-.2,-lensDepth-1,17]) rotate ([45,0,0])  cube([55,4.6,55]);
        // hole through baffle
        translate ([camLensOffsetRight+camLensWidth+wallThickness-1,-2,4])rotate ([0,35,0]) cylinder(r=antennaDiameter/1.5,h=8,$fn=32);
    }
    
    // Antenna Mount
    difference() {
        translate ([camWidth+(wallThickness*3)+.2,-2,10]) cylinder(r=(antennaDiameter/2)+wallThickness,h=5,$fn=32);
        translate ([camWidth+(wallThickness*3)+.2,-2,9]) cylinder(r=(antennaDiameter/2),h=7,$fn=32);
        translate ([camWidth,-4,9]) rotate ([0,45,0]) cube ([8,8,8]);
    }
}


module e010_bottom_plate() {
    
    // mount left
    difference() {
        translate([-18,4,0]) cylinder(r=2.8,h=baseHeight,$fn=64);
        translate([-18,4,-0.5]) cylinder(r=0.8, h=2,$fn=32);
    }
    //mount right
    difference() {
        translate([18,4,0]) cylinder(r=2.8,h=baseHeight,$fn=64);
        translate([18,4,-0.5]) cylinder(r=0.8, h=2,$fn=32);
    }
    //mount front
    difference() {
        translate([0,-14,0]) cylinder(r=2.4,h=baseHeight,$fn=64);
        translate([0,-14,-0.5]) cylinder(r=0.8, h=2,$fn=32);
    }
    // beam front
    translate ([-11.9,-4.1,0]) cube ([23.9,2,baseHeight]);
    // right beam
    translate ([-17.5,1.5,0]) rotate ([0,0,-45]) cube ([22,2.8,baseHeight]); 
    // left beam
    translate ([16.7,4,0]) rotate ([0,0,225]) cube ([23.5,2.8,baseHeight]); 
    
    /*
    // back rounded corner right
    difference() {
        translate ([-5.5,13,0]) cylinder(r=2,h=baseHeight,$fn=64);
        translate ([-4,9.5,-0.5]) cylinder(r=3.55,h=2,$fn=64);
    }
    // back rounded corner left
    difference () {
        translate ([5.5,13,0]) cylinder(r=2,h=baseHeight,$fn=64);
        translate ([4,9.5,-0.5]) cylinder(r=3.55,h=2,$fn=64);        
    }
    translate ([-5.5,13,0]) cube ([11,2,baseHeight]);
    // back angle beam Right
    translate([-17,1.0,0]) rotate ([0,0,46.15]) cube([17, 2,baseHeight]);
    // back gusset right
    translate([-16.3,4.2,0]) rotate ([0,0,24]) cube([3,1.5,baseHeight]);
    
    // back angle beam Left
    translate([5.5,13.0,0]) rotate ([0,0,-46]) cube([16.7, 2,baseHeight]);
    // back gusset left
    translate([17,5.4,0]) rotate ([0,0,156]) cube([3,1.5,baseHeight]);
    
    */
    // middle beam
    translate([-17,3.8,0]) cube([34,2.8,baseHeight]);
}

tx01_mount();