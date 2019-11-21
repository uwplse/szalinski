//riders name
riderName = "JIMMY";
//font and style here
textFontAndStyle = "Phosphate:style=Inline"; 
//text scale x
textScaleX = 0.8;
//text scale y
textScaleY = 0.8;

module scooter(){
		rotate([0, 0, 90])
translate([0, 0, wheelRadius + wallThickness])
    union(){
        wheel();
        axle();
    }
}

//---Some more vars you can tweak
$fa = 1.2;
$fs = 1.2;
// how big to make the stand
standSize = .09; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]
// pre-drilled screw holes
numberOfScrewHoles = 4; // [0:12]
// the diameter of the scooter wheel
wheelDiameter = 111; // [90:130]
wheelRadius = wheelDiameter/ 2.0; 
// how wide the wheel is
wheelWidth = 24;  // [20:40]
// how curved the tyre tread is
wheelTreadCurvature = 1.0; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]
// the smaller the number the snugger the tyre fits
wheelSupportCurvature = 1.0; // [1.0,1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,1.9,2.0]
// the diameter of the axle ( or the width of the fork if its fatter)
axleDiameter = 50; // [30:60]
axleRadius = axleDiameter/ 2.0;
axleWidth = 60 + 0; 
//minimum thickness
wallThickness = 3; // [1:10]
tolerance = 0;
screwDistanceFromCenter= 0.50 * wheelRadius;

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
    translate([0, 0, 5])
      cylinder(d = 9, h= axleWidth * 10);
    translate([0, 0, -tolerance])
      cylinder(d = 3, h= axleWidth * 10);
    }
}

module screws(){
    if(numberOfScrewHoles > 0){
        for(i = [1 : 360 / numberOfScrewHoles : 360]) {
            rotate([0, 0, i - 90]) 
                translate([screwDistanceFromCenter, 0, 0])
                    screwHole();
        }
    }
}
module fancyStand(){
    color("cyan")
			scale([1.0, 1.5, 1.0])    
            hull(){
				
			for(i = [1 : 360 / 4 : 360]) {
            rotate([0, 0, i - 90]) 
                translate([40, 0, 0])
                    sphere(r = wheelRadius * standSize);
        }
        scale([4.0, 1.0, 1.0])   
                translate([0, 0, 60])
                    sphere(r = wheelRadius * standSize);
            }
}

module someText(){
    linear_extrude(height = 200)
	scale([textScaleX, textScaleY,1.0])
        text(riderName, font = textFontAndStyle, valign = "center", halign = "center");
}
module myText(){
	someText();
    translate([0, 40, 0])
	someText();
    translate([0, -40, 0])
	someText();
}

module flatBottom(){
    translate([0, 0, wheelDiameter * 3 / -2])
    cube(wheelDiameter * 3, wheelDiameter * 3, wheelDiameter * 3, center=true);
}

module scooterStand(){
    difference(){
        fancyStand();
        scooter();
        flatBottom();
    }
}

module niceEdges(){
	difference(){
		myText();
		translate([0,0,-2])
			scooterStand();
	}
}

module cocoonArea(){
    edgeBuffer = 2 * 15;
    completeArea = [120 - edgeBuffer, 135 - edgeBuffer, 100 - edgeBuffer];
    translate([0, 0, (100 - edgeBuffer)/2])
        cube(completeArea, center=true);
    
}

    intersection(){
        cocoonArea();
		difference(){
			scooterStand();
			niceEdges();
			screws();
		}
    }


//    Written in 2019 by Grrrenn
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
