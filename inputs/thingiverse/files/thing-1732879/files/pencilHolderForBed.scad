//BEGIN CUSTOMIZER VARIABLES
//All starting units are in in, since I'm an american and my
//dial caliper measures in inches.
/*[Bed Rail]*/

railWidth = 0.75;

slotHeight = 1;

innerFillet = 0.125;

outerFillet = 0.125;

/*[Desired Slot]*/

ledgeWidth = 0.25;
ledgeHeight = 0.875;
slotLength = 3;
/*[Advanced Stuffs]*/

//Basically are you using american units or real units
units_entered = 25.4;//[1:mm, 10:cm, 1000:meter, 25.4:inch, 304.8:foot]
//default is mm for most printers
desired_units_for_output = 1;//[1:mm, 0.1:cm, 0.001:meter, 0.0393701:inch, 0.00328084:foot]

//higher = smoother, but takes longer to render
resoultion = 42;

//thicker = more durable but longer to make.
clipThickness = 0.0625;

includeDefaultFillets = true;
//END CUSTOMIZER VARIABLES
//turns inches to metric
scale(units_entered/desired_units_for_output){
    difference(){
        union(){
            TraceOutline();
            roundCorners(center = [innerFillet+clipThickness,innerFillet+clipThickness], topRight = true, radi = innerFillet+0.0001);
            roundCorners(center = [railWidth+clipThickness-innerFillet,clipThickness+innerFillet], topLeft = true, radi = innerFillet+0.0001);
        }
        scale([1,1,1.0001]){
            translate([0,0,-0.00001]){
                roundCorners(center = [outerFillet,outerFillet], topRight = true, radi = outerFillet+0.0001);
                roundCorners(center = [railWidth+2*clipThickness-outerFillet,outerFillet], topLeft = true, radi = outerFillet+0.0001);
            }
        }
    }
}

module TraceOutline(){
    difference(){
        union(){
            linear_extrude(slotLength){
                square(size = [railWidth+2*clipThickness,clipThickness]);
                square(size = [clipThickness,slotHeight+2*clipThickness]);
                translate([railWidth+clipThickness, 0]){
                    square(size = [clipThickness,slotHeight+2*clipThickness]);
                }
                translate([railWidth+clipThickness, slotHeight+clipThickness]){
                    square(size = [ledgeWidth+2*clipThickness,clipThickness]);
                }
                translate([railWidth+ledgeWidth+clipThickness*2, slotHeight-ledgeHeight]){
                    square(size = [clipThickness,ledgeHeight+2*clipThickness]);
                }
            }
            if(includeDefaultFillets){
                addDefaultFillets();
            }
        }
        if(includeDefaultFillets){
            scale([1,1,1.0001]){
                translate([0,0,-0.00001]){
                    cutDefaultFillets();
                }
            }
        }
    }
}

module addDefaultFillets(){
    //4
    roundCorners(center = [1.5*clipThickness + railWidth + ledgeWidth, slotHeight + 0.5*clipThickness], bottomLeft = true, radi = clipThickness/2+0.0001);
    //5
    roundCorners(center = [2.5*clipThickness + railWidth, slotHeight + 0.5*clipThickness], bottomRight = true, radi = clipThickness/2+0.0001);
}

module cutDefaultFillets(){
    //1
    roundCorners(center = [2.5*clipThickness + railWidth + ledgeWidth, slotHeight - ledgeHeight + 0.5*clipThickness], topLeft = true, topRight = true, radi = clipThickness/2+0.0001);
    //2
    roundCorners(center = [2.5*clipThickness + railWidth + ledgeWidth, slotHeight + 1.5*clipThickness], bottomLeft = true, radi = clipThickness/2+0.0001);
    //3
    roundCorners(center = [1.5*clipThickness + railWidth, slotHeight + 1.5*clipThickness], bottomRight = true, radi = clipThickness/2+0.0001);
    //6
    roundCorners(center = [0.5*clipThickness, slotHeight + 1.5*clipThickness], bottomLeft = true, bottomRight = true, radi = clipThickness/2+0.0001);  
}

module roundCorners(center = [0,0], topLeft = false, topRight = false, bottomLeft = false, bottomRight = false, radi = 0.125){
    translate([center[0],center[1],0]){
        difference(){
            union(){
                if(topLeft){
                    rotate([0,0,270]){
                        cube([radi,radi,slotLength]);
                    }
                }
                if(topRight){
                    rotate([0,0,180]){
                        cube([radi,radi,slotLength]);
                    }
                }
                if(bottomLeft){
                    rotate([0,0,0]){
                        cube([radi,radi,slotLength]);
                    }
                }
                if(bottomRight){
                    rotate([0,0,90]){
                        cube([radi,radi,slotLength]);
                    }
                }
            }
            translate([0,0,-0.0001]){
                cylinder(r=radi, h = slotLength+0.001, $fn=resoultion);
            }
        }
    }
}
