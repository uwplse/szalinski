// Upper (smaller) knob diameter [mm]
upperDiameter = 12;

// Lower (larger) knob diameter [mm]
lowerDiameter = 15;

// Knob height [mm]
height = 15;

// Internal knob space diameter [mm]
innerDiameter = 10;

// Shaft diameter [mm]
axisDiameter = 5.8;

// Shaft bracket diameter [mm]
axisCylinderDiameter = 7.5;

// Shaft bracket height [mm]
axisCylinderHeight = 8;

// Space between shaft brackets [mm]
axisCylinderCutWidth = 1;

cutRadius1 = upperDiameter/20;
cutRadius2 = lowerDiameter/20;

upperRadius = upperDiameter/2;
lowerRadius = lowerDiameter/2;

angle=90-atan2(height,(lowerRadius-upperRadius));
height2 = height/ cos(angle) /0.95;
echo("angle=", angle);

module cut() {
    translate([0,-(upperRadius+lowerRadius)/2-0.2])
    rotate(a=[angle,0,0]) {
        difference() {
            cylinder(r1=cutRadius1, r2=cutRadius2, h=height2,center=true, $fn=60);
            translate([-cutRadius2,-cutRadius2,-height2/2]) cube([2*cutRadius2,cutRadius2,height2]);
        }
    }
}

//cut();
union() {
    difference() {
        cylinder(r1=upperRadius, r2=lowerRadius, h=height, center=true, $fn=60);
        for (i=[0:18]) {
            rotate(a=[0,0,i*20]) cut();
        }
        translate([0,0,(height-axisCylinderHeight)/2])cylinder(r=innerDiameter/2, h=axisCylinderHeight*1.5, center=true, $fn=60);
    }
    translate([0,0,(height-axisCylinderHeight)/2]) {
        difference() {
            cylinder(r=axisCylinderDiameter/2,h=axisCylinderHeight,center=true, $fn=60);
            cylinder(r=axisDiameter/2,h=axisCylinderHeight *1.5,center=true, $fn=60);
            cube([axisCylinderDiameter,axisCylinderCutWidth,axisCylinderHeight*1.5],center=true);
        }
    }
}