height = 70;
spindlePortionHeight = 15;
coletteHolderClearance = 2;//6;
spindleShaftDiameter = 25.4;//14.5;
holeSpacing = 19;
insetDepth = 2;
insetHeight = 3;
insetOffsetFromHoles = 4;
separation = 1;
m3 = 3.3;
m3NutWidth = 5.7;
m3nutHeight = 2;
wallThickness = 5;
sideCutoff = 3;

m5 = 5.6;
m5NutWidth = 8.2;
m5NutHeight = 2.7;

probeOffset = 5;

sides = 6;
lipHeight = 2;
lipMinDiameter = 25.4/4 +0.1;

length = 2*wallThickness+max(holeSpacing,spindleShaftDiameter);
rotate([0,-90,0])
difference() {
    union() {
        cube([wallThickness+coletteHolderClearance+spindleShaftDiameter+wallThickness+m5, length,spindlePortionHeight+lipHeight]);
        cube([wallThickness, length,height]);
    }
    hull() {
        translate([wallThickness+coletteHolderClearance+spindleShaftDiameter/2,length/2,0])
            cylinder(r=spindleShaftDiameter/2, h=spindlePortionHeight, $fn=sides);
        translate([wallThickness+coletteHolderClearance+spindleShaftDiameter+wallThickness+m5,length/2,0])
            cylinder(r=spindleShaftDiameter/2, h=spindlePortionHeight, $fn=sides);
    }
    hull() {
        translate([wallThickness+coletteHolderClearance+spindleShaftDiameter/2,length/2,0])
            cylinder(r=lipMinDiameter/2, h=spindlePortionHeight+lipHeight, $fn=50);
        translate([wallThickness+coletteHolderClearance+spindleShaftDiameter+wallThickness+m5,length/2,0])
            cylinder(r=lipMinDiameter/2, h=spindlePortionHeight+lipHeight, $fn=sides);
    }
    translate([wallThickness+coletteHolderClearance+spindleShaftDiameter+m5/2,0,spindlePortionHeight/2]) rotate([-90,0,0]) {
        cylinder(r=m5/2,h=length,$fn=50);
    }
    translate([wallThickness+coletteHolderClearance+spindleShaftDiameter+m5/2-m5NutWidth/2,(length-spindleShaftDiameter)/4-m5NutHeight/4,0])
        cube([m5NutWidth,m5NutHeight,spindlePortionHeight]);
    hull() {
        translate([0,wallThickness,height-probeOffset]) rotate([0,90,0])
            cylinder(r=m3/2,h=length,$fn=50);
        translate([0,length-wallThickness,height-probeOffset]) rotate([0,90,0])
            cylinder(r=m3/2,h=length,$fn=50);
    }
    hull() {
        translate([wallThickness-insetDepth,wallThickness+m3/2,height-probeOffset-insetOffsetFromHoles-m3/2]) rotate([0,90,0])
            cylinder(r=insetHeight/2,h=insetDepth,$fn=50);
        translate([wallThickness-insetDepth,length-wallThickness-m3/2,height-probeOffset-insetOffsetFromHoles-m3/2]) rotate([0,90,0])
            cylinder(r=insetHeight/2,h=insetDepth,$fn=50);
    }
    
    translate([wallThickness-insetDepth,0,spindlePortionHeight]) {
        cube([insetDepth, wallThickness-sideCutoff,height]);
        translate([0,length-wallThickness+sideCutoff,0])
            cube([insetDepth, wallThickness-sideCutoff,height]);
    }
}