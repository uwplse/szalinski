//////////////////////////////////////////
// Pipe Flange with Adjustable Mount
// Ryan Stachurski
// 2018-05-20
//////////////////////////////////////////
//Pipe Radius
pipeRad = 26.5/2; // 3/4" conduit: 24/2;

//PipeHeight
pipeHeight = 40;

//Pipe Angle expressed in degrees from perpendicular
pipeAngle = 45;

//Thickness of the flange walls
wallThick = 4;

//Width of the flange
flangeWidth = 60;

//Radius of the screw holes
holeRad = 2;

//Distance of screw holes from center
holeDist = 32;

//Punch a screw hole every n degrees
screwDegrees = 90;

//Angle of screw head agaginst flange [ex. tan(40) = rise / run; rise = tan(40)*run]
screwAngle = 40;

//Mount Style: 0=round, 1=square
mountStyle = 1; 

//Strengthen flange where it meets pipe: 0=no, 1=yes
strengthenFlange = 1;


$fn=100;

flange();

//Examples:
//translate([80,0,0]) flange(flangeWidth= 70, pipeAngle=0, pipeHeight=15, strengthenFlange=0);
//translate([0,-80,0]) flange(flangeWidth = 70, mountStyle = 0, holeDist=26, screwDegrees=30, strengthenFlange=1, pipeAngle=0, screwAngle=0);
//translate([80,-80,0]) flange(flangeWidth = 50, mountStyle = 0, holeDist=26, screwDegrees=30, strengthenFlange=0, pipeAngle=0, screwAngle=0, holeRad=0, wallThick=1, pipeHeight=5, pipeRad=18);


module flange(){
    
    difference(){
        //draw cylinder
        rotate([pipeAngle,0,0])
            difference(){
                translate([0,0,-flangeWidth])cylinder(r=pipeRad+wallThick, h=pipeHeight+flangeWidth);
                translate([0,0,-1-flangeWidth])cylinder(r=pipeRad, h=pipeHeight+2+flangeWidth);
            }
        //clear for plate
        translate([0,0,-2*flangeWidth])cube(4*flangeWidth, true);
    }
    
    difference() {
        translate([0,0,-wallThick/2]) if (mountStyle)
            cube([flangeWidth, flangeWidth, wallThick], true);
            else translate([0,0,-wallThick/2]) cylinder(r=flangeWidth/2, h=wallThick);
        cutHoles(screwDegrees=screwDegrees, holeDist=holeDist, screwAngle=screwAngle, holeRad=holeRad, wallThick=wallThick);
    }
    
    
    
    //Create a thicker flange
    if (strengthenFlange){
        difference(){
            if (mountStyle)
                hull(){
                    translate([0,0,-wallThick/2]) cube([flangeWidth, flangeWidth, wallThick], true);
                    sphere(r=wallThick); 
                }
                else hull(){
                    translate([0,0,-wallThick]) cylinder(r=flangeWidth/2, h=wallThick);
                    cube([pipeRad*2,pipeRad*2,wallThick*2], true); 
                }
                    
            rotate([pipeAngle,0,0])
                translate([0,0,-1-flangeWidth])cylinder(r=pipeRad, h=pipeHeight+2+flangeWidth);
            cutHoles(screwDegrees=screwDegrees, holeDist=holeDist, screwAngle=screwAngle, holeRad=holeRad, wallThick=wallThick);
        }
    }    
}


module cutHoles(){
    screwCutDepth = tan(screwAngle)*holeRad*2;
    for (r=[45:screwDegrees:359+45])
        rotate([0,0,r])
            translate([holeDist, 0, 0]){
            cylinder(r=holeRad, h=wallThick*3, center=true);
            translate([0,0,0-screwCutDepth+.001]) cylinder(r1=0, r2=holeRad*2, h = screwCutDepth);
            translate([0,0,0]) cylinder(r=holeRad*2, h = wallThick);
            }
    
}