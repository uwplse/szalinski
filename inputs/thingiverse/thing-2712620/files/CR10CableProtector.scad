/* [Cable Tip Measurements] */
// Max width of USB cable end 
CableTipWidth = 10.8; // [5:0.1:100]
// Max height of USB cable end 
CableTipHeight = 8; // [5:0.1:100]
//Adds slot for micro SD card if printer is a Creality CR-10
IsPrinterCrealityCR10 = 1;// [1:Yes,0:No]

/* [Protector Geometry] */
//How tight should the cable end fit?
clearance = 1; // [.5:Tight,1:Medium,2:Loose]
//Wall Thickness
wallThickness = 1.5; // [1.2:0.1:3.2]

/* [Hidden] */
//Angle to tilt the squeeze tabs inward
tabTiltInAngle = 10;// [0:0.1:20]
//Height of the squeeze tabs
tabHeight = 15;// [5:50]
//Size of the square that is glued to the side
glueSurfaceSideSize = 25; // [20:5:140]

tabThickness = wallThickness-clearance/2;

CableProtector();

module CableProtector(){
    difference(){
        union(){
            //Glue surface
            translate([0,0,-4.25])
                cube([glueSurfaceSideSize,glueSurfaceSideSize, 1.5], center=true);

            //Main body
            cube([CableTipWidth+2*(wallThickness+clearance),CableTipHeight+2*wallThickness+clearance,10], center=true);

            //Tabs for zip-ties or rubber band
            x = (CableTipWidth+clearance/2 + sin(tabTiltInAngle * tabHeight))/2;
            for(angle=[0,180])
                translate([angle==0?-x:x,0,12])
                    rotate([0,0,angle])
                        rotate([0,tabTiltInAngle,0]) 
                            cube([1,10, 15], center=true);
        }
        //Hole for tip
        cube([CableTipWidth+2*clearance,CableTipHeight+clearance,13], center=true);

        //Zip-Tie notches
        if (tabHeight>5)
            for(y=[-5.5,5])
                translate([0,y,tabHeight])
                    rotate([0,90,0])
                        cylinder(r=2.5, h=CableTipWidth+2*(wallThickness+clearance), center=true, fn=10);

        //Creality CR-10 Micro-SD card slot
        if (IsPrinterCrealityCR10>0)
            translate([CableTipWidth/2+clearance+wallThickness*1.5,-4,-4.25-wallThickness])
                cube([glueSurfaceSideSize/3, 8, 2*wallThickness]);
    }
}