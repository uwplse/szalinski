/*[Standard 1836 style West Coast Drive Rail]*/

// Number of wheels:
Wheels = 4;// [4:2:10]
// Diameter of wheels in inches:
WheelSize = 4;
// Overall length of robot:
Robotlength = 36; // [0:0.5:100]
//Center to center distance between each wheel
Centertocenter = 14;

/*[Advanced]*/

//Diameter of bearing/shaft hole:
Bearingsize = 1.25;
//Vertical distance between wheels (Z axis):
wheeldrop = .375;
//Hole Spacing on the top face (Perpendicular to shafts):
TopHolePattern = 1;
//Hole Spacing on side face (Same face as shafts):
SideHolePattern = 1.5;
//Tube thickness:
TubeThickness = .125;
//Chain size:
Pitch = .25;
//Number of teeth on the sprocket:
Teeth = 16;
//Bearing block mount hole spacing (from hole to hole):
BBmounthole = 1.25;
//Hole size for the bearing block mount:
BBmountholesize = .201;

/*[hidden]*/
tubex = 1;
tubey = Robotlength;
tubez = 2;
wps = Wheels/2;
wdps = wheeldrop/2;
holes = 0;
PD = Pitch/sin (180/Teeth);
OD = Pitch*(0.6 + 1/tan((180/Teeth)));

//Figure out chain calculation and put it here


module tube() {
    difference() {
        scale([25.4, 25.4, 25.4]) cube([tubex, tubey, tubez ], center = true);
        scale([25.4, 25.4, 25.4]) cube([tubex-TubeThickness, tubey, tubez-TubeThickness], center = true);
    }
}

module wheelholes() {
    difference() {
        tube();
        if (wps == 2) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, Centertocenter/2 , 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, -Centertocenter/2, 0])
               cylinder(d = Bearingsize, h = 200, center = true);
        if (BBmounthole > 0) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([+BBmounthole/2, BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, -BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([+BBmounthole/2, -BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([+BBmounthole/2, BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, -BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([+BBmounthole/2, -BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true); 
            }
            }
        else if (wps == 3) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, 0 , 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, sqrt((Centertocenter*Centertocenter)-(wdps*wdps)), 0])
                cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, -(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
                cylinder(d = Bearingsize, h = 200, center = true);
            
        if (BBmounthole > 0) {//holes for bearing block
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2,-BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2,BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2,-BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2,BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
                
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps - BBmounthole/2, -sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) - BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps + BBmounthole/2, -sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) - BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps + BBmounthole/2, -sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) + BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps + BBmounthole/2, sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) - BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps + BBmounthole/2, sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) + BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps - BBmounthole/2, sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) + BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps - BBmounthole/2, sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) - BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps - BBmounthole/2, -sqrt((Centertocenter*Centertocenter)-(wdps*wdps)) + BBmounthole/2, 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
        }
    }
 
        else if (wps == 4) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps, Centertocenter/2, 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps, -Centertocenter/2, 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, -Centertocenter/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);

            if (BBmounthole > 0) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps-BBmounthole/2, BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps+BBmounthole/2, BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps-BBmounthole/2, -BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps+BBmounthole/2, -BBmounthole/2+Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps-BBmounthole/2, BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps+BBmounthole/2, BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps-BBmounthole/2, -BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps+BBmounthole/2, -BBmounthole/2-Centertocenter/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);                

            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, BBmounthole/2+Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, BBmounthole/2+Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, -BBmounthole/2+Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, -BBmounthole/2+Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, BBmounthole/2-Centertocenter/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, BBmounthole/2-Centertocenter/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, -BBmounthole/2-Centertocenter/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
             rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, -BBmounthole/2-Centertocenter/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = BBmountholesize, h = 200, center = true);                     
            }
        }
        else if (wps == 5) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps, 0, 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, (sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0, -(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, (sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps, -(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))), 0])
               cylinder(d = Bearingsize, h = 200, center = true);
            
      if (BBmounthole > 0) {
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps - BBmounthole/2, -BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps + BBmounthole/2, -BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps - BBmounthole/2, BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([wdps + BBmounthole/2, BBmounthole/2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);

            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2, BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, -BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2, -BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, -BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2, -BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-BBmounthole/2, BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([BBmounthole/2, BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps))) , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
          
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps + BBmounthole/2, BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, -BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, -BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, -BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, -BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps-BBmounthole/2, BBmounthole/2-(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
            rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-wdps+BBmounthole/2, BBmounthole/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2 , 0])
               cylinder(d = BBmountholesize, h = 200, center = true);
          
                }
            }       
        }
    }



module topholes() {
    if (TopHolePattern > 0) {
        difference() {
            wheelholes();
            for (holes =[0:TopHolePattern:Robotlength/2-TopHolePattern]) {
            scale([25.4, 25.4, 25.4]) translate([0, holes, 0])
               cylinder(d = .201, h = 5, center = true);
            scale([25.4, 25.4, 25.4]) translate([0, -holes, 0])
               cylinder(d = .201, h = 5, center = true);
            }   
        }
    }   
 }
 module holes() {
     if (SideHolePattern > 0) {
         difference() {   
            topholes(); 
             if (wps == 2) {
                 for (holes =[0:SideHolePattern:Centertocenter/2-SideHolePattern]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
             }
                              for (holes =[Centertocenter/2+SideHolePattern:SideHolePattern:Robotlength/2-SideHolePattern/2]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                              }
         }
             else if (wps == 3) {
                for (holes =[SideHolePattern:SideHolePattern:sqrt((Centertocenter*Centertocenter)-(wdps*wdps))-SideHolePattern]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                }
               for (holes =[sqrt((Centertocenter*Centertocenter)-(wdps*wdps))+SideHolePattern:SideHolePattern:Robotlength/2-SideHolePattern/2]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
               cylinder(d = .201, h = 5, center = true);
               }
            }
            else if (wps == 5) {
              for (holes =[SideHolePattern:SideHolePattern:sqrt((Centertocenter*Centertocenter)-(wdps*wdps))-SideHolePattern]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
             }
              for (holes =[sqrt((Centertocenter*Centertocenter)-(wdps*wdps))+SideHolePattern:SideHolePattern:(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))*2-SideHolePattern]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
             }
              for (holes =[(2*(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))+SideHolePattern):SideHolePattern:Robotlength/2-SideHolePattern/2]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
             }
         }
            else if (wps == 4) {
              for (holes =[Centertocenter/2+SideHolePattern:SideHolePattern:Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))-SideHolePattern/2]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                
              }
             for (holes =[0:SideHolePattern:Centertocenter/2-SideHolePattern]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
            }
            for (holes =[Centertocenter/2+(sqrt((Centertocenter*Centertocenter)-(wdps*wdps)))+SideHolePattern:SideHolePattern:Robotlength/2-SideHolePattern/2]) {
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([0.5, -holes, 0])
                        cylinder(d = .201, h = 5, center = true);
                    rotate([0, 90, 0]) scale([25.4, 25.4, 25.4]) translate([-0.5, holes, 0])
                        cylinder(d = .201, h = 5, center = true);
           }
        }
    }
  }

}

holes();

if (tubez/2+wdps<OD/2) {
    echo("Your sprocket is too large to fit on this drive rail");
}
if (Robotlength <= wps*WheelSize + wps) {
    echo ("This drivetrain is impossible");
}

//chain info outputs
echo ("The pitch diameter of your sprocket is", PD, "inches, the outer diameter of your sprocket is", OD, "inches");
