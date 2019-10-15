// BioCube Corner by Urban Reininger twitter: UrbanAtWork Thingiverse: UrbanAtWork
// Working with the Ross School Innovation lab www.ross.org

	//include <utils/build_plate.scad>

//CUSTOMIZER VARIABLES

// Hole Radius (mm)
cyl_rsize = 4;// [1:20]

// Wall padding "thickness" (mm halved)
wallThickness = 3; //[1:20]

//CUSTOMIZER VARIABLES END

cubesize = cyl_rsize*2+wallThickness;

cyl_hsize = 200;

helperDisc = cubesize*1.6;
helperDiscZloc = -(cyl_rsize + 1.4);

module bioCubeCorner()
{
	module rotcy(rot, cyl_rsize, cyl_hsize) {
		rotate(90, rot)
			cylinder(r = cyl_rsize, h = cyl_hsize, center = true);
	}

union(){

	difference() {
		union(){
	translate([ 0, 0, cubesize ])
		cube([cubesize, cubesize, cubesize], center = true);
	translate([ cubesize, 0, 0 ])
		cube([cubesize, cubesize, cubesize], center = true);
	translate([ 0, cubesize, 0 ])
		cube([cubesize, cubesize, cubesize], center = true);
		}
		rotcy([0, 0, 0], cyl_rsize, cyl_hsize);
		rotcy([1, 0, 0], cyl_rsize, cyl_hsize);
		rotcy([0, 1, 0], cyl_rsize, cyl_hsize);
	}
// This is the corner base cube
		cube([cubesize, cubesize, cubesize], center = true);

// This is a .2mm disk to help it stick to the build plate
translate([ 5, 5, helperDiscZloc ])
	cylinder(r = helperDisc, h = 0.2, center = true);
}

}
bioCubeCorner();