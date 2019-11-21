/*
Add-on Duct for multirotor.
This will mount between motors and frame arms with the props below the motors like a pusher motor in a plane.

Proportions and parameters based on the work of Jason L. Pereira [1].
First introduced to me by capolight [2].


[1] https://drive.google.com/file/d/0BzZ213vBQVkTOHFnbUxkRVRZOGc/view
[2] https://capolight.wordpress.com/2015/01/14/quadcopter-rotor-duct/

*/


// set up for 5 inch propellers
propDiameter=127;
propHeight=8;

// duct sizing based on articles referenced above
ductInsideDiameter=propDiameter*1.002; // 0.1% of ID gap around prop
ductLipRadius=ductInsideDiameter*0.13; // 13% of ID
ductTailRadius=3;
ductDiffuserLength=ductInsideDiameter*0.55;
ductDiffuserFlareAngle=5;

// motor set up for Emax 2205 motors
motorDiameter=28;
motorHeight=17;
motorShaftClearanceDiameter=8;
motorScrewMinRadius=8;
motorScrewMaxRadius=9.5;
motorScrewClearanceHoleDiameter=3.15;
motorScrewCounterBoreDiameter=6.5;

motorMountThickness=5;
motorMountSpokeThickness=4;
motorMountSpokeCount=8;


module capsule(r, h) {
    hull() {
        translate([0,0,h/2])
        sphere(r=r);
        translate([0,0,-h/2])
        sphere(r=r);
    }
}


module duct_profile_solid() {
    translate([-ductInsideDiameter/2-ductLipRadius,0,0])
    hull() {
        translate([0,propHeight/2]) circle(r=ductLipRadius);
        translate([ductLipRadius/2,-propHeight/2]) circle(r=ductLipRadius/2);
        translate([
            (-ductDiffuserLength-propHeight/2)*tan(ductDiffuserFlareAngle)+ductLipRadius-ductTailRadius,
            -ductDiffuserLength-propHeight/2
        ])
        circle(r=ductTailRadius);
    }
}

module duct_profile_candy_cane() {
    translate([-ductInsideDiameter/2-ductLipRadius,0,0])
    union() {
        difference() {
            translate([0,propHeight/2]) circle(r=ductLipRadius);
            translate([0,propHeight/2]) circle(r=ductLipRadius-ductTailRadius*2);
            
            translate([0,propHeight/2-ductLipRadius])
            square(ductLipRadius*2,center=true);
        }
        
        translate([-ductLipRadius+ductTailRadius,propHeight/2])
        circle(r=ductTailRadius);
        
        hull() {
            translate([ductLipRadius-ductTailRadius,propHeight/2])
            circle(r=ductTailRadius);
            translate([ductLipRadius-ductTailRadius,-propHeight/2])
            circle(r=ductTailRadius);
        }
        
        hull() {
            translate([ductLipRadius-ductTailRadius,-propHeight/2])
            circle(r=ductTailRadius);
            
            translate([
                (-ductDiffuserLength-propHeight/2)*tan(ductDiffuserFlareAngle)+ductLipRadius-ductTailRadius,
                -ductDiffuserLength-propHeight/2
            ])
            circle(r=ductTailRadius);
        }
    }
}


module duct_profile() {
    duct_profile_solid();
    //duct_profile_candy_cane();
}


module motor_mount_screw_hole() {
    $fn=40;
    union() {
        translate([0,0,-motorMountThickness])
        linear_extrude(motorMountThickness*2)
        hull() {
            translate([motorScrewMinRadius,0]) circle(d=motorScrewClearanceHoleDiameter);
            translate([motorScrewMaxRadius,0]) circle(d=motorScrewClearanceHoleDiameter);
        }
    }
}


module motor_mount_spoke() {
    $fn=40;
    hull() {
        translate([motorDiameter/2,0,motorHeight+motorMountThickness/2+propHeight/2])
        capsule(r=motorMountSpokeThickness/2, h=motorMountThickness-motorMountSpokeThickness);
        
        translate([ductInsideDiameter/2+ductLipRadius,0,ductLipRadius-motorMountThickness/2+propHeight/2])
        capsule(r=motorMountSpokeThickness/2, h=motorMountThickness-motorMountSpokeThickness);
    }
}


module motor_mount() {
    $fn=120;
    translate([0,0,motorMountThickness/2+motorHeight+propHeight/2])
    difference() {
        cylinder(d=motorDiameter, h=motorMountThickness, center=true);
        cylinder(d=motorShaftClearanceDiameter, h=motorMountThickness*2,center=true);
        for (i=[1:1:8]) {
            rotate([0,0,45*i]) motor_mount_screw_hole();
        }
    }
    for (i=[1:1:motorMountSpokeCount]) {
        rotate([0,0,360/motorMountSpokeCount*i+360/motorMountSpokeCount/2]) motor_mount_spoke();
    }
}


module duct() {
    union() {
        rotate_extrude($fn=260) duct_profile();
        motor_mount();
    }
}


duct();
