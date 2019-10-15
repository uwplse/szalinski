use <utils/build_plate.scad>


/////////////////////////////////
// VARIABLES FOR CUSTOMIZER
/////////////////////////////////
// dimension in X direction
width = 50; // [30:1:100]

// dimension in Y direction
height = 60; // [30:1:100]

// dimension in Z direction
depth = 30; // [30:1:100]

// angle of inclination
angle = 75; // [70:1:90]

thickness = 4; // [3:0.5:8]

phoneWidth = 11; // [5:0.1:15]
// Nexus 5 = 12 mm


/////////////////////////////////
// VARIABLES USED BY THE SCRIPT
/////////////////////////////////
$fa=6*1;
$fs=0.5*1;
gap=0.1*1; 
topWidth = 0.5*width;


/////////////////////////////////
// DISPLAY THE BUILD PLATE 
// (It doesn't contribute to final object)
/////////////////////////////////

build_plate_selector = 3*1;
build_plate_manual_x = 200*1;
build_plate_manual_y = 200*1;
build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y);
//preview[view:south east, tilt:top diagonal]

/////////////////////////////////
// AUXILIARY MODULES
/////////////////////////////////
module basicFormA() {	
	cylinder(r=thickness/2, h=depth-thickness, center=true);
	for (k=[-1:1]) {	
		translate([0,0,k*(depth/2-thickness/2)])
		sphere(r=thickness/2);
	}		
}

module basicFormB() {	
	cylinder(r=thickness*0.75/2, h=depth-thickness, center=true);
	for (k=[-1:1]) {	
		translate([0,0,k*(depth/2-thickness/2)])
		sphere(r=thickness*0.75/2);
	}
}		
// module basicFormA2() {
// 	translate([0,0,0])
// 	cylinder(r=thickness*3, h=depth-thickness, center=true);
// 	for (n = [0:5:90],k=[-1:1]) {	
// 		rotate([0,0,n])
// 			translate([thickness*3-thickness/2,0,k*(depth/2-thickness/2)])
// 				sphere(r=thickness/2);
// 	}
// }

/////////////////////////////////
// MAIN MODULES
/////////////////////////////////
module mainShape() {
  hull() {
		translate([width,-height/2,0])
			basicFormA();
		translate([0,-height/2,0])
			basicFormA();		
	}
	hull() {
		translate([0,-height/2,0])
			basicFormA();
		translate([0,height/2,0])
			basicFormA();	
	}
	hull() {
		translate([0,height/2,0])
			basicFormA();
		translate([topWidth,height/2,0])
			basicFormA();		
	}
	hull() {
		translate([topWidth,height/2,0])
			basicFormA();
		translate([topWidth+height/tan(angle),-height/2+thickness*1.25,0])
			basicFormA();	
	}
}

module hook() {
	hookWidth=phoneWidth+thickness*1.25;
  
	translate([topWidth+height/tan(angle), -height/2+thickness*1.25,0 ])
		rotate([0, 0, 90-angle]) {
			hull() {
				basicFormA();
				translate([hookWidth,0 ,0 ])
					basicFormA();
			}
			hull() {
				translate([hookWidth,0,0 ])
					basicFormA();
				translate([hookWidth-thickness/2,13,0])
					basicFormA();	
			}
		}				
}

/////////////////////////////////
// RENDERS
/////////////////////////////////
module stand() {
	union() {
		mainShape();
		hook();
	}
}

translate([-width/2,0,depth/2])
	stand();