//!Openscad
//Simple Customizer SCAD Script
//Size of main cube:
mainCube = 10; // [10:200]
//Color of main cube:
mainCubeColor = "Blue"; //

    difference() {
		union() {
			color(mainCubeColor,1) cube([mainCube, mainCube, mainCube], center = true);
			color("Red",1) cube([mainCube*1.25, mainCube/2, mainCube/2], center = true);
			color("Green",1) cube([mainCube/2, mainCube*1.25, mainCube/2], center = true);
			color("Purple",1) cube([mainCube/2, mainCube/2, mainCube*1.25], center = true);
  
		}
		union() {
			color("Orange",1) cube([mainCube*1.5, mainCube/3, mainCube/3], center = true);
			color("Cyan",1) cube([mainCube/3, mainCube*1.5, mainCube/3], center = true);
			color("DeepPink",1)cube([mainCube/3, mainCube/3, mainCube*1.5], center = true);
		}
	}

