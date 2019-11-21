$fs = 0.5;
$fa = 0.5;
off = 0.2; //printer offset

//hull Parameter
smallerInnerDiameter = 16.9;
widerInnerDiameter = 19;
smallPartLength = 14;
longPartLength = 44;
totalLength = 61;
outerDiameter = 22;
wallThickness = 1;

//earProtectorParameter
earMaxDiameter = 14;
earLengthWide = 12.5;
earMidDiameter = 9;
earLengthSmall = 5.5;

spaceToFirst = 31;
spaceToSecond = 8;

earLapLength = 8;
earLapMaxWidth = 7;
earLapThickness = 2;

//sennerBox();
difference(){
earPieceHolder();
translate([0,0,spaceToFirst])rotate([0,180,0])earProtector();
translate([0,0,spaceToFirst+spaceToSecond])earProtector();
}

module sennerBox(){
    color("grey",0.5)
    difference(){
cylinder(d= outerDiameter, h=totalLength);

translate([0,0,wallThickness])cylinder(d= smallerInnerDiameter, h=smallPartLength+1);

translate([0,0,smallPartLength+wallThickness])cylinder(d=widerInnerDiameter, h=longPartLength);
    
    translate([-50,0,-2])cube([100,100,100]);
}
}
module earPieceHolder(){
    difference(){
        translate([0,0,wallThickness]) cylinder(d= smallerInnerDiameter-off, h=smallPartLength+longPartLength-3);

intersection(){
        translate([-widerInnerDiameter/2,0,smallPartLength+wallThickness])cube([widerInnerDiameter,widerInnerDiameter/2,longPartLength]);
        
        translate([0,0,smallPartLength-5])cylinder(d1=0,d2=100,h=70);
}
translate([0,0,smallPartLength/2+wallThickness])cube([1,outerDiameter,smallPartLength],center=true);
rotate([0,0,90])translate([0,0,smallPartLength/2+wallThickness])cube([1,outerDiameter,smallPartLength],center=true);
translate([0,0,53])cylinder(d=2,h=longPartLength+ smallPartLength-spaceToFirst-spaceToSecond-earLengthWide-wallThickness-1);
}
}

module earProtector(){
    cylinder(d1=earMaxDiameter,d2=earMidDiameter,h=earLengthWide);
    translate([0,0,earLengthWide])cylinder(d1=earMidDiameter,d2=0,h=earLengthSmall);
    latch();
}

module latch(){
    intersection(){
translate([-earMaxDiameter/2,-earLapMaxWidth/2,-earLapLength])cube([earLapThickness,earLapMaxWidth,earLapLength]);
    translate([0,0,-earLapLength])cylinder(d=earMaxDiameter,h=earLapLength);
}
}


translate([0,0,wallThickness+longPartLength+smallPartLength-3-(longPartLength+ smallPartLength-spaceToFirst-spaceToSecond-earLengthWide-wallThickness-1)])difference(){
    cylinder(d=earMidDiameter,h=longPartLength+ smallPartLength-spaceToFirst-spaceToSecond-earLengthWide-wallThickness-1);
cylinder(d2=0,d1=earMidDiameter, h=longPartLength+ smallPartLength-spaceToFirst-spaceToSecond-earLengthWide-wallThickness-1);
    cylinder(d=2,h=longPartLength+ smallPartLength-spaceToFirst-spaceToSecond-earLengthWide-wallThickness-1);
}