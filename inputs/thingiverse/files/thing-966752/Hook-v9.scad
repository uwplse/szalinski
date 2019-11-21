// all measurements in mm
deskTopWidth = 25;

hookLength = 30;
hookHeight = 15;

topGrab = 40;
bottomGrab = 70;

grabAngle = 88;

hookWidth = 25;
hookThickness = 4;

// tolerance for desktopWidth based on printer experience
tolerance=0.4;

module Hook() {
    // build and move primitives
    
    cube([hookThickness, hookWidth, hookHeight]);
    cube([hookLength+hookThickness,hookWidth,hookThickness]);
    // add twice the hook thickness to the the height of the gap
    translate ([hookLength+hookThickness,0,-hookThickness])
        cube([hookThickness,hookWidth,deskTopWidth+tolerance+2*hookThickness]);
    translate ([hookThickness*2+hookLength,0,deskTopWidth-hookThickness*2+tolerance+2*hookThickness])
        cube([topGrab,hookWidth,hookThickness]);
    
    // rotate for additional grab about the y axis
    // need to rotate prior to translation otherwise the element will become quite disjointed
    
    // failed to properly account for the grab angle
    translate ([hookThickness*2+hookLength,0,-hookThickness])
        rotate([0,-90+grabAngle,0])
        cube([bottomGrab,hookWidth,hookThickness]);
    
    // round the inside corners
    translate ([hookThickness,0,hookThickness])
        RoundedCorner();
    translate([hookLength+hookThickness,0,hookThickness])
        rotate([0,-90,0])
        RoundedCorner();
}

module RoundedCorner() {
    // modularise the corner and translate back to origin
    translate([hookThickness/2,hookWidth/2,hookThickness/2])
    difference() {
        cube ([hookThickness,hookWidth,hookThickness],center=true);
        translate([hookThickness/2,-hookWidth/4,hookThickness/2])
        rotate([90,0,0])
        cylinder(r=hookThickness,h=hookWidth*2,center=true);
    }
}
// make transparent during rounded corner creation
//rotate([0,0,45])
//rotate([90,0,0])
Hook();
