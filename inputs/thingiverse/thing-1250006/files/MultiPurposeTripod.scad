BaseRadius = 30;
BaseHeight = 4;
LegWidth = 10;
LegThicknes = 3;
LegHeight = 100;
LegPlugThickness = 4;
LegAngle = 15;
LegOffset = 0;
// Workarround for slicer software without XY/Horz. Compensation
LegPlugXYCompensation = 0;
HolderRadius=10;
HolderType = "Hexagon"; //[Circle,Hexagon]
DrawType = "All"; //[Head,Legs,All,Demo]

/* [HIDDEN] */
$fn = 50;

if(DrawType == "Head") Head();
if(DrawType == "Demo") rotate([180,0,0])Head();
if(DrawType == "Legs") rotate([90,0,0])Leg();
if(DrawType == "All") {
    Head();
    for(a=[1:3]) 
        translate([BaseRadius+5+a*(LegWidth+5),LegHeight/2,LegThicknes/2])
            rotate([90,0,0])
                Leg();
}

module Head(){
    difference(){
        hFn = HolderType == "Circle" ? 50:6;
        union(){
            Base();
            translate([0,0,BaseHeight]) 
                cylinder(r=HolderRadius+2,h=BaseHeight*2,center=true,$fn=hFn);
        }    
        cylinder(r=HolderRadius,h=100,center=true,$fn=hFn);
    }
}
module Base(){
    cylinder(r=BaseRadius,h=BaseHeight);
    for(a=[1:3]){
        rotate(30+a*120)
            translate([BaseRadius-LegWidth,0,BaseHeight])
                Plug();
    }
}
module Plug(){
    bHeigh = LegWidth*1.5;
    if(DrawType == "Demo"){
        translate([0,0,bHeigh/2]) 
            cube([LegWidth+LegPlugThickness*2,LegThicknes+LegPlugThickness, bHeigh],center=true);
        translate([-3,0,0])
            rotate([0,LegAngle,0]) 
                translate([-LegOffset,0,LegThicknes+4])
                    Leg(LegPlugXYCompensation);
    }
    else{
        difference(){
            translate([0,0,bHeigh/2]) 
                cube([LegWidth+LegPlugThickness*2,LegThicknes+LegPlugThickness, bHeigh],center=true);
            translate([-3,0,0])
                rotate([0,LegAngle,0]) 
                    translate([-LegOffset,0,LegThicknes+4])
                        Leg(LegPlugXYCompensation);
        }
    }
}

module Leg(legThModf=0){
    rotate([90,-90,0]){
        hull(){
            cube([LegWidth+legThModf,LegWidth+legThModf,LegThicknes+legThModf],center=true);
            translate([LegHeight,0,0]) cylinder(d=LegWidth,h=LegThicknes+legThModf,center=true);
        }
    }
}