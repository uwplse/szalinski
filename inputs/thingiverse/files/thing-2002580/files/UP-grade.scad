// UP-grade is a customisable roll holder for the UP mini 3D printer
// so this small printer can carry big filament rolls
// https://www.up3d.com/?r=mini

// Written for OpenScad by Bruno Herfst 2016
// http://www.openscad.org

// NOTE: If I added a 0 to a variable it is it doesn't show in the custumizer

// Roll Spec
rollWidth = 70;

// Holder spec
holderDepth        = 10;
holderLever        = 0;
bevelWidth         = 5;
lipTickness        = 3;
holderDiameter     = 30;
backWallThickness  = 5+0;
frontWallThickness = 3+0;

// Printer Spec
pHoleWidth = 22+0; // 24 Actual
pHoleHeiht = 10+0; // 12 Actual
pWall      = 2 +0;  //  1 Actual

// Short cuts
hDepth   = holderDepth/2;
rWidth   = rollWidth + bevelWidth;
// Material Saver
ms_Height = ((holderDiameter+holderDepth)/100)*25;
ms_Offset = ((holderDiameter+holderDepth)/100)*25;
// Backwall
bwWidth  = holderDiameter + holderDepth;
bwHeight = holderDiameter + (holderDepth*2) + holderLever;

$fn = 100;

module prism(l, w, h){
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

difference() {
// Create holder
union() { 
    // Create lip
    translate([-(pHoleWidth/2),-(pWall+lipTickness),0]) {
        cube([pHoleWidth,lipTickness,pHoleHeiht]);
        translate([0,0,pHoleHeiht-lipTickness]) {
            cube([pHoleWidth,lipTickness+pWall,lipTickness]);
        }
    }

    // Create backWall
    translate([-bwWidth/2,0,-(bwHeight-pHoleHeiht)+hDepth]){
        cube([bwWidth,backWallThickness,bwHeight]);
    }
    
    // Bevel
    translate([0,backWallThickness+(bevelWidth/2),pHoleHeiht-hDepth-(holderDiameter/2)]){
        rotate([-90,0,0])
        cylinder(  bevelWidth, d1=holderDiameter+holderDepth, d2=holderDiameter, center=true);
    }
    
    // Create holder
    translate([0,rWidth/2+backWallThickness,pHoleHeiht-hDepth-(holderDiameter/2)]){
        rotate([90,0,0])
        cylinder(  rWidth, d=holderDiameter, center=true);
    }

    // Create holder finish
    // Bevel
    translate([0,rWidth+backWallThickness-(bevelWidth/2),pHoleHeiht-hDepth-(holderDiameter/2)]){
        rotate([90,0,0])
        cylinder(  bevelWidth, d1=holderDiameter+holderDepth, d2=holderDiameter, center=true);
    }
    translate([0,rWidth+backWallThickness+frontWallThickness-(frontWallThickness/2),pHoleHeiht-hDepth-(holderDiameter/2)]){
        rotate([90,0,0])
        cylinder(  frontWallThickness, d=holderDiameter+holderDepth, center=true);
    }
}
// Create material saver
union() {
    translate([-bwWidth/2,backWallThickness,pHoleHeiht-hDepth-holderDiameter+ms_Offset]){
        prism(bwWidth, rWidth+frontWallThickness+3, ms_Height);
    }
    translate([-bwWidth/2,backWallThickness,pHoleHeiht-hDepth-holderDiameter-bwHeight+ms_Offset]){
        cube([bwWidth, rWidth+frontWallThickness+3, bwHeight]);
    }
}
}