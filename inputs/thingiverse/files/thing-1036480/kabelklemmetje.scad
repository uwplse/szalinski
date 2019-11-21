shelfThickness = 20; //Thickness of the shelf (mm)
wallThickness = 3; //Wall thickness of the cable holder (mm)
width = 16; //Width of the cable holder (mm)
length = 25; //Lengt of the cable holder over the shelf(mm)
cableThickness = 5; //The diameter of the cable to be held (mm)
seperation = 1.2*cableThickness;
$fn = 2*25;

translate([0,0,width]){
    rotate([-90,0,0]){
        cube([length,width,wallThickness]);
        
        translate([0,0,wallThickness]){
            cube([wallThickness,width,shelfThickness]);
        }
        translate([0,0,wallThickness+shelfThickness]){
            cube([length,width,wallThickness]);
        }
        
        depth = 4 * cableThickness;
        difference(){
            difference(){
                translate([-depth,0,0]){
                    cube([depth,width,wallThickness]);
                }
                translate([-1.5 * cableThickness, width / 2, -1]){
                      cylinder(wallThickness +2, 0.75*cableThickness, 0.75*cableThickness);
                }
            }
            translate([(-1.5 * cableThickness)-(0.55*cableThickness),-1,-1]){
                 cube([1.1*cableThickness,
                (((width)/2)+2),
                wallThickness +2]);
            }
        }
        if (1*seperation+2*wallThickness <= shelfThickness + 2*wallThickness){
            difference(){
                difference(){
                    translate([-depth,0,wallThickness+(seperation)]){
                        cube([depth,width,wallThickness]);
                    }
                    translate([-1.5 * cableThickness, width / 2,wallThickness+(seperation)-1]){
                          cylinder(wallThickness +2, 0.75*cableThickness, 0.75*cableThickness);
                    }
                }
                translate([(-1.5 * cableThickness)-(0.55*cableThickness),(width/2),wallThickness+(seperation)-1]){
                     cube([1.1*cableThickness,
                    (((width)/2)+1),
                    wallThickness +2]);
                }
            }
        }
        if (2*seperation+3*wallThickness <= shelfThickness + 2*wallThickness){
            difference(){
                difference(){
                    translate([-depth,0,2*(wallThickness+(seperation))]){
                        cube([depth,width,wallThickness]);
                    }
                    translate([-1.5 * cableThickness, width / 2, (2*(wallThickness+(seperation)))-1]){
                          cylinder(wallThickness +2, 0.75*cableThickness, 0.75*cableThickness);
                    }
                }
                translate([(-1.5 * cableThickness)-(0.55*cableThickness),-1,(2*(wallThickness+(seperation)))-1]){
                     cube([1.1*cableThickness,
                    ((width/2)+2),
                    wallThickness +2]);
                }
            }
        }
    }

}