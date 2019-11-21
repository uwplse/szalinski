//$fa = 1.5;
//$fs = 1.5;


/* [Scooter Stand Details] */
// the base shape of the stand will be formed from this text!
standShape = " L";
// hown many sides on the stand
standFacets= 6; // [3:30]
// how big to make the stand
standSize = 1.3; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]
// pre-drilled screw holes
numberOfScrewHoles = 6; // [0:12]

/* [Scooter Details] */
// the diameter of the scooter wheel
wheelDiameter = 111; // [90:130]
wheelRadius = wheelDiameter/ 2.0; 
// how wide the wheel is
wheelWidth = 27;  // [20:40]
// how curved the tyre tread is
wheelTreadCurvature = 1.0; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]
// the smaller the number the snugger the tyre fits
wheelSupportCurvature = 1.2; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]

// the diameter of the axle ( or the width of the fork if its fatter)
axleDiameter = 40; // [30:60]
axleRadius = axleDiameter/ 2.0;
axleWidth = 60 + 0; 
//minimum thickness
wallThickness = 2; // [1:10]
tolerance = 2 + 0;
screwDistanceFromCenter= 0.9 * wheelRadius;


/* [Printable Max Dimensions] */
printableX = 90;
printableY = 105;
printableZ = 70;


module scooter(){
translate([0, 0, wheelRadius + wallThickness])
    union(){
        wheel();
        axle();
    }
}

module axle(){
    rotate([0, 270 , 0])
    hull(){
    cylinder(r=axleRadius, h= axleWidth * 10, center=true);
    translate([wheelDiameter * 10, 0, 0])
        cylinder(r=axleRadius + tolerance, h= axleWidth * 10, center=true);
    }
}

module wheel(){
    intersection(){
        scale([wheelTreadCurvature, wheelSupportCurvature, 1])    
            sphere(wheelRadius);
        cube([wheelWidth + tolerance,
        4 * wheelDiameter + tolerance,
        wheelDiameter + tolerance], 
        center= true);
    }
}

module screwHole(){
    union(){
    translate([0, 0, 2])
      cylinder(d = 9, h= axleWidth * 10);
    translate([0, 0, -tolerance])
      cylinder(d = 3, h= axleWidth * 10);
    }
}

module screws(){
    if(numberOfScrewHoles > 0){
        for(i = [0 : 360 / numberOfScrewHoles : 359]) {
            rotate([0, 0, i]) 
                translate([screwDistanceFromCenter, 0, 0])
                    screwHole();
        }
    }
}

module fancyStand(){
    color("cyan")
    rotate([0,0,90])
        rotate_extrude($fn= standFacets)
            text(standShape, size=wheelRadius * standSize);
}

module flatBottom(){
    translate([0, 0, wheelDiameter * 3 / -2])
    cube(wheelDiameter * 3, wheelDiameter * 3, wheelDiameter * 3, center=true);
}

module scooterStand(){
    difference(){
        fancyStand();
        #scooter();
        flatBottom();
        screws();
    }
}

module printableArea(){
    completeArea = [printableX, printableY, printableZ];
    translate([0, 0, printableZ/2])
        cube(completeArea, center=true);
    
}


intersection(){
    printableArea();
    scooterStand();
}


//    Written in 2017 by Grrrenn
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.
