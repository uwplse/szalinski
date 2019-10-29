/*
iphone 6 in speck case adapter for orion Sirius Plossl Lens
*/

lensReceiverDiameter = 34;
lensReceiverHeight = 10.5;
eyePieceRubberDiameter = 39;
eyePieceRubberHeight = 13;
clipThickness = 5;
clipInterference = .5;
armThickness = 8;
wallRightOffset=15.5;
wallTopOffset=9.3;
wallThickness=3;
lensHole=8;
wallHeight=12;

$fn=50;

//eyePieceModel();
rotate([0,0,90]) mountClip();
translate([0,0,lensReceiverHeight+eyePieceRubberHeight]) phoneGuide();

module phoneGuide(){
    phonePlaten();
    phoneWallTop();
    phoneWallSide();

    module phonePlaten(){
        difference(){
            translate([0,0,1]) cube([lensReceiverDiameter+clipThickness*2-clipInterference*2+armThickness,lensReceiverDiameter+clipThickness*2-clipInterference*2+armThickness,2],center=true);
            cylinder(d=lensHole,h=2);
        }
    }
    module phoneWallTop(){
        translate([0,wallThickness/2+wallTopOffset,2+wallHeight/2]) cube([lensReceiverDiameter+clipThickness*2-clipInterference*2+armThickness,wallThickness,wallHeight],center=true);
    }
    module phoneWallSide(){
        translate([wallThickness/2+wallRightOffset,0,2+wallHeight/2]) cube([wallThickness,lensReceiverDiameter+clipThickness*2-clipInterference*2+armThickness,wallHeight],center=true);
    }
    
}

module mountClip(){
    clipCircle();
    rotate([0,0,0]) clipArm();
    rotate([0,0,-90]) clipArm();
    rotate([0,0,90]) clipArm();
    
    module clipCircle(){
        difference(){
            translate([0,0,0]) rotate([0,0,0]) cylinder(d=lensReceiverDiameter+clipThickness*2 - clipInterference*2,h=lensReceiverHeight);
           translate([0,0,0]) rotate([0,0,0]) cylinder(d=lensReceiverDiameter - clipInterference*2,h=lensReceiverHeight);
            translate([-(lensReceiverDiameter+clipThickness*2)/4,0,lensReceiverHeight/2]) rotate([0,0,0]) cube([(lensReceiverDiameter+clipThickness*2)/2,8,lensReceiverHeight],center=true);
        }
    }
    
    module clipArm(){
        difference(){
            translate([lensReceiverDiameter/2+clipThickness-clipInterference,0,0]) rotate([0,0,0]) cylinder(d=armThickness,h=lensReceiverHeight+eyePieceRubberHeight);
            eyePieceModel();
        }
    }    
}

module eyePieceModel(){
    translate([0,0,0]) rotate([0,0,0]) cylinder(d=lensReceiverDiameter,h=lensReceiverHeight);
    translate([0,0,lensReceiverHeight]) rotate([0,0,0]) cylinder(d=eyePieceRubberDiameter,h=eyePieceRubberHeight);
}