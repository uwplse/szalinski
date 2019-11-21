/*[1836 Standard Plate]*/
//The angle between the two parts of the plate:
Angle = 90; //[0:180]
//The thickness of the plate:
PlateThickness = .125;
//The width of the plate:
PlateWidth = 1;
//The plate's length in one direction:
PlateLengthY = 3;
//The plate's length in the other direction:
PlateLengthX = 3;
/*[Hole Pattern]*/
//The plate's hole pattern spacing in one direction:
HolePatternY = .5;
//The plate's hole pattern spacing in the other direction (may not work if angle is not 90):
HolePatternX = .5;
//The size of the holes:
HoleSize = .201;
/*[Crossmember]*/
//Toggle between crossmember on or off (may not work if angle is not 90):
Crossmember = "On"; //[On, Off]
//Fillet radius of crossmember:
Radius = 0.125;
/*[hidden]*/
holes = 0;

module Plate() {
    union() {
        scale(25.4, 25.4, 25.4) translate([-PlateWidth/2, -PlateWidth/2, 0])
            cube([PlateWidth, PlateLengthY, PlateThickness]);
        scale(25.4, 25.4, 25.4) translate([-PlateWidth/2, -PlateWidth/2, 0])rotate(a = Angle)
            cube([PlateWidth, PlateLengthX, PlateThickness]);
    }
}
module PlateWithHolePattern() {
    difference() {
        Plate();
        if(HolePatternX+HolePatternY>0) {
            for (holes =[0:HolePatternY:PlateLengthY-HolePatternY-PlateWidth/2]) {
           scale([25.4, 25.4, 25.4]) rotate(a = -90) translate ([-holes, 0, 0])
               cylinder(d = HoleSize, h = PlateThickness);
            }
            for (holes =[HolePatternX:HolePatternX:PlateLengthX+HolePatternX-PlateWidth/2]) {
           translate([0, 0, 0]) {
               if (holes > HolePatternX) {
               scale([25.4, 25.4, 25.4]) rotate(a = Angle+270) translate ([-holes, 0, 0]) 
               cylinder(d = HoleSize, h = PlateThickness);
                   } 
               else {scale([25.4, 25.4, 25.4]) translate([-holes, 0, 0]) 
               cylinder(d = HoleSize, h = PlateThickness);
            }
            }
    } }
}
}

module PlateWithCrossmember() {
    union() {
        PlateWithHolePattern();
        if(Crossmember == "On") {
                hull() {
                    scale([25.4, 25.4, 25.4]) translate([-PlateWidth/2, PlateWidth/2, 0])
                        cylinder(h = PlateThickness, d = Radius);
                    scale([25.4, 25.4, 25.4]) translate([-PlateWidth/2-PlateLengthX+Radius/2, PlateWidth/2, 0])
                        cylinder(h = PlateThickness, d = Radius);
                    scale([25.4, 25.4, 25.4]) translate([-PlateWidth/2, -PlateWidth/2+PlateLengthY-Radius/2, 0])
                        cylinder(h = PlateThickness, d = Radius);
                    
                }
            }
        }
    }

PlateWithCrossmember();



        
        
        
        
        
        