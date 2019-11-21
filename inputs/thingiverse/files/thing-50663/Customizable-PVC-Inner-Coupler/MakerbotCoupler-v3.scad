use <utils/build_plate.scad>

// preview[view:south]

//PVC Diameter Schedule 40 pipe
pvcDiameter = 20.93; //[6.33:1/8",8.74:1/4",12.02:3/8",15.8:1/2",20.93:3/4",26.64:1",35.05:1 1/4",40.89:1 1/2",52.5:2",62.71:2 1/2"]

//The Number of Couplers
couplerConst = 3; //[0:Two Couplers,1:Four Couplers,2:Five Couplers,3:Six Couplers]

//Length of the Coupler in mm's
couplerLength = 25.4; //[0:100]

//Second Coupler Rotation Angle
doubleRotate = 90; //[0:180]

//Third and Fourth Coupler x-axis Rotation Angle
xFourRotate = 180; //[90:270]

//Third and Fourth Coupler y-axis Rotation Angle
yFourRotate = 0; //[-90:90]

//Fith Coupler Rotation Angle
fiveRotate = 270;	//[180:360]

//Sixth Coupler Rotation Angle
sixRotate = 180; //[180:360]

//Build Warping Help?
isWarp = 0; //[1:My Build is Warping, 0:No Help Needed]

//Hollow Couplers?
isHollow = 0; //[0:Filled,1:Hollow]

//Display only, does not contribute to final object
buildPlateType = 1; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//When build plate type = manual this controls the build plate x-dimension
buildPlateX = 200; //[100:400]

//When build plate type = manual this controls the build plate y-dimension
buildPlateY = 200; //[100:400]

pvcWall = 4/1;  // thickness of the sphere
flangeWidth = 5/1;  // width of warping flange
flangeThick = 0.2/1;  // thickness of warping flange (inclusive.  It includes the build)
gapConstant = 1.25/1; // clearance between pvc and coupler

diameter = pvcDiameter - gapConstant;  // get the proper diameter for the couplers (small gap for glue)

couplerRadius = diameter/2;

module warping(){
	translate(v = [0,0,-flangeThick/2]){
		cylinder(r = (couplerRadius + pvcWall + flangeWidth), h = flangeThick, center=true);
	}

	translate(v = [0,-((couplerLength/2) + (flangeWidth/2)),-flangeThick/2]){
		cube(size = [(diameter + (flangeWidth*2)), (couplerLength + flangeWidth), flangeThick], center=true);
	}

	rotate(doubleRotate,[0,0,1]){
		translate(v = [0,-((couplerLength/2) + (flangeWidth/2)),-flangeThick/2]){
			cube(size = [(diameter + (flangeWidth*2)), (couplerLength + flangeWidth), flangeThick], center=true);
		}
	}
	if(couplerConst >= 2){
		rotate(fiveRotate,[0,0,1]){
			translate(v = [0,-((couplerLength/2) + (flangeWidth/2)),-flangeThick/2]){
				cube(size = [(diameter + (flangeWidth*2)), (couplerLength + flangeWidth), flangeThick], center=true);
			}
		}
	}
	if(couplerConst == 3){
		rotate(sixRotate,[0,0,1]){
			translate(v = [0,-((couplerLength/2) + (flangeWidth/2)),-flangeThick/2]){
				cube(size = [(diameter + (flangeWidth*2)), (couplerLength + flangeWidth), flangeThick], center=true);
			}
		}
	}
}

module pvcCoupler(){

	module rotateCylinder(deg, r, h){
		rotate(90, [1,0,0]) rotate(deg, [0,1,0]) 
			cylinder(r = r, h = h, center = false);
	}
	module rotateThirdCylinder(degCO, degCT, r, h){
		rotate(degCO, [1,0,0]) rotate(degCT, [0,1,0])
			cylinder(r = r, h = h, center = false);
	}
	
	// moves everything right side up
	rotate(a=[0,180,0]){
		difference(){
			union(){
				// creates the non-movable coupler and the first coupler
				rotateCylinder(0, couplerRadius, couplerLength);
				rotateCylinder(doubleRotate, couplerRadius, couplerLength);
				
				if(couplerConst >= 1){	
					// my crazy coupler that moves both in x and y... can also function as a 3rd flat coupler
					rotateThirdCylinder(xFourRotate, yFourRotate, couplerRadius, couplerLength);  
				}
				if(couplerConst >= 2){
					// creates coupler five or four depending on above
					rotateCylinder(fiveRotate, couplerRadius, couplerLength);
				}
				if(couplerConst >= 3){
					// creates coupler six or five depending on above
					rotateCylinder(sixRotate, couplerRadius, couplerLength);
				}

				// inner design sphere.  Personal prefrence and or structual.
				sphere(r = (couplerRadius + pvcWall));

				if(isWarp == 1){
					warping();
				}
			}

			// cuts the couplers in half ignoring inner sphere or ocupler size
			cylinder(r = (couplerLength * 2), h = (couplerRadius + pvcWall * 2), center = false);
				
			// creates coupler cutouts so they can hollow out the existing structure.  Stupid coding.. REVISIT.
			if(isHollow == 1){
				difference(){
					union(){	
						rotateCylinder(0, couplerRadius - 1, couplerLength + 1);
						rotateCylinder(doubleRotate, couplerRadius - 1, couplerLength + 1);
			
						if(couplerConst >= 1){	
							rotateThirdCylinder(xFourRotate, yFourRotate, couplerRadius - 1, couplerLength + 1);  
						}
						if(couplerConst >= 2){
							rotateCylinder(fiveRotate, couplerRadius - 1, couplerLength + 1);
						}
						if(couplerConst >= 3){
							rotateCylinder(sixRotate, couplerRadius - 1, couplerLength + 1);
						}
					}
				}
			}
		}
	}
}

// if the pvcDiameter gets too big the couplers run up against each other.  this prevents that by puting them at arms length creates a mirror image and moves it over a bit to center on the build platform.
if(couplerConst >= 1 || pvcDiameter > 26.64){
	translate(v = [-(couplerLength + (flangeWidth*4)),0,0]){
		pvcCoupler();
	}
	translate(v = [(couplerLength + (flangeWidth*4)),0,0]){
		mirror([1,0,0]) {
			pvcCoupler();
		}
	}
}else{
	translate(v = [-(pvcWall + (flangeWidth*4)),0,0]){
		pvcCoupler();
	}
	translate(v = [(pvcWall + (flangeWidth*4)),0,0]){
		mirror([1,0,0]) {
			pvcCoupler();
		}
	}
}

build_plate(buildPlateType, buildPlateX, buildPlateY);