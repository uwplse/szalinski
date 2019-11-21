// CC-BY-SA Olivier Boyaval
// Swith plate for shutter
//
//    TOP part :
//           width
//    +-----------------+
//    !                 !
//    !        O        ! screw hole (if vertical)
//    !                 !
//    !    +-------+    !
//    !    !       !    !
//    !    ! switch!    !
//    !    ! hole  !    !  height
//    !    !       !    !
//    !    !       !    !
//    !    +-------+    !
//    !                 !
//    !        O        ! screw hole (if vertical)
//    !                 !
//    +-----------------+
//
//    BOTTOM part :
//    +-----------------+
//    ++               ++
//     !       O       !
//     !               !
//     !   +-------+   !
//     !   !       !   !
//     !   !       !   !
//     !   !       !   !
//     !   !       !   !
//     !   !       !   !
//     !   +-------+   !
//     !               !
//     !       O       !
//    ++               ++
//    +-----------------+
//
//Parameters for switch plate in 2 parts (top and bottom parts)
//measurements in mm

/* [Plate size] */
// Width (mm)
plateWidth              = 36;
// Height (mm)
plateHeight             = 74;

/* [Plate Thickness] */
// Top part (mm)
thicknessTop            = 3;
// Bottom part
thicknessBottom         = 4;

/* [Screw holes) */
// spacing beetwen center screw holes (mm)
screwSpacing            = 58;
//hole size (mm)
screwDiameter           = 3.5;
// Axe for screw holes
screwHoleAxe            = "Vertical"; //[Vertical,Horizontal]

/* [Switch hole size] */
// switch width (mm)
switchWidth             = 21;
// switch height (mm)
switchHeight            = 37;

/* [Output] */
// What object do you want in STL format
printedObject           = "Demo"; //[Demo,Top,Bottom]

// screw hole size and chamfer
module screwHole(diameter,depth) {
    union () {
        translate([0,0,-0.25]) cylinder(h=depth+0.5, d=diameter, $fn=20);
        translate([0,0,depth/2+0.25]) cylinder(h=depth/2, d1=diameter, d2=2*diameter, $fn=20);
    }
}

// bottom part (basic shape)
module basicShapeBottomPart (width,height,thickness) {
    union () {
        translate([-width/2+2,-height/2+2,0]) cube([width-4,height-4,thickness]);
        translate([-width/2+2,-height/2+2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([-width/2+2,+height/2-2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([+width/2-2,-height/2+2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([+width/2-2,+height/2-2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([-width/2+2,-height/2,0]) cube([width-4,4,thickness]);
        translate([-width/2+2,+height/2-4,0]) cube([width-4,4,thickness]);
        *translate([-width/2,-height/2+2,0]) cube([4,height-4,thickness]);
        *translate([+width/2-4,-height/2+2,0]) cube([4,height-4,thickness]);
    }
}

// Top part (basic shape)
module old_basicShapeTopPart (width,height,thickness) {
    chamfer=thickness*4;
intersection () {
intersection () {
    union () {
        translate([-width/2+2,-height/2+2,0]) cube([width-4,height-4,thickness]);
        translate([-width/2+2,-height/2+2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([-width/2+2,+height/2-2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([+width/2-2,-height/2+2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([+width/2-2,+height/2-2,0]) cylinder(h=thickness, d=4, $fn=20);
        translate([-width/2+2,-height/2,0]) cube([width-4,4,thickness]);
        translate([-width/2+2,+height/2-4,0]) cube([width-4,4,thickness]);
        translate([-width/2,-height/2+2,0]) cube([4,height-4,thickness]);
        translate([+width/2-4,-height/2+2,0]) cube([4,height-4,thickness]);
    }
    union () {
        translate([-width/2-2,+height/2-chamfer,0]) rotate([0,+90,0]) scale([1,2,1]) cylinder(h=width+4, d=chamfer, $fn=20);
        translate([-width/2-2,-height/2+chamfer,0]) rotate([0,+90,0]) scale([1,2,1]) cylinder(h=width+4, d=chamfer, $fn=20);
        translate([-width/2,-height/2+2,0]) cube([width,height-chamfer/2,chamfer/2]);
    }
}
    union () {
        translate([+width/2-chamfer,-height/2-2,0]) rotate([-90,-90,0]) scale([1,2,1]) cylinder(h=height+4, d=chamfer, $fn=20);
        translate([-width/2+chamfer,-height/2-2,0]) rotate([-90,-90,0]) scale([1,2,1]) cylinder(h=height+4, d=chamfer, $fn=20);
        translate([-width/2+2,-height/2,0]) cube([width-chamfer/2,height,chamfer/2]);
    }
}
}

module basicShapeTopPart(width,height,thickness) {
    $fn=50;
    intersection() {
        translate([-width/2+thickness,-height/2+thickness,0])
        minkowski()
        {
            cube([width-2*thickness,height-2*thickness,thickness]);
            sphere(r=thickness);
        }
        translate([-width/2-thickness,-height/2-thickness,0])
        cube([width+thickness,height+thickness,2*thickness]);
    }
}

module bottomPlate(width,height,thicknessI,thicknessS,screwD,screwE,widthI,heightI) {
    difference () {
        basicShapeBottomPart(width,height,thicknessI);
        union () {
            if (screwHoleAxe=="Vertical") {
                translate ([0,-screwE/2,0]) screwHole(screwD, thicknessI+thicknessS);
                translate ([0,+screwE/2,0]) screwHole(screwD, thicknessI+thicknessS);
                translate([-width/2+5,-(screwE-2*screwD)/2,-thicknessI/2]) cube([width-10,screwE-2*screwD,thicknessI]);
                translate([-width/2+screwD,-height/2+5,-thicknessI/2]) cube([width/2-2*screwD,height-10,thicknessI]);
                translate([screwD,-height/2+5,-thicknessI/2]) cube([width/2-2*screwD,height-10,thicknessI]);
            } else {
                translate ([-screwE/2,0,0]) screwHole(screwD, thicknessI+thicknessS);
                translate ([+screwE/2,0,0]) screwHole(screwD, thicknessI+thicknessS);
                translate([-(screwE-2*screwD)/2,-height/2+5,-thicknessI/2]) cube([screwE-2*screwD,height-10,thicknessI]);
               translate([-width/2+5,-height/2+screwD,-thicknessI/2]) 
    cube([width-10,height/2-2*screwD,thicknessI]);
                translate([-width/2+5,screwD,-thicknessI/2]) cube([width-10,height/2-2*screwD,thicknessI]);
            }
            
            // switch hole
            translate([-widthI/2,-heightI/2,-10]) cube([widthI,heightI,20]);
        }
    }    
}

module topPlate(width,height,thicknessI,thicknessS,screwD,screwE,widthI,heightI) {
    difference () {
        basicShapeTopPart(width,height,thicknessS/2);
        union () {
            if (screwHoleAxe=="Vertical") {
                translate ([0,-screwE/2,-thicknessI]) screwHole(screwD, thicknessI+thicknessS);
                translate ([0,+screwE/2,-thicknessI]) screwHole(screwD, thicknessI+thicknessS);
            } else {
                translate ([-screwE/2,0,-thicknessI]) screwHole(screwD, thicknessI+thicknessS);
                translate ([+screwE/2,0,-thicknessI]) screwHole(screwD, thicknessI+thicknessS);
            }
            // switch hole
            translate([-widthI/2,-heightI/2,-10]) cube([widthI,heightI,20]);
        }
    }
}

//Main program
if (printedObject=="Demo") {
    color("Wheat") bottomPlate(plateWidth,plateHeight,thicknessBottom,thicknessTop,screwDiameter, screwSpacing,switchWidth,switchHeight);
    translate ([0,0,thicknessBottom+3]) color("Sienna") topPlate(plateWidth,plateHeight,thicknessBottom,thicknessTop,screwDiameter, screwSpacing,switchWidth,switchHeight);
}

if (printedObject=="Bottom") {
    // To render STL object of bottom plate part
    //translate ([0,0,thicknessBottom]) rotate([0,180,0]) 
    bottomPlate(plateWidth,plateHeight,thicknessBottom,thicknessTop,screwDiameter, screwSpacing,switchWidth,switchHeight);
}

if (printedObject=="Top") {
    // To render STL object of top plate part
    topPlate(plateWidth,plateHeight,thicknessBottom,thicknessTop,screwDiameter, screwSpacing,switchWidth,switchHeight);
}