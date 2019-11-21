use <write/Write.scad>

// preview[view:south east, tilt:top diagonal]

//Type of model
moldType = 0; //[0:Two Radius Cylinder, 1:Cylinder, 2:Cube, 3:Sphere, 4:Dodecahedron]

//Print mold insert, the "Sphere" & "Dodecahedron" models do not have an insert, but you can always print an insert separately.
reqInsert = 1; //[0:Don't want insert, 1:Display insert]

//Show a cutout version of your model, good for perspective, switch to "Print Entire Model" or "Print Insert Only" to print working parts of a mold.  If you try to Print Insert Only with non-insert models the default display will be the entire model.
displayCutout = 1; //[1:Display Cutout, 0:Print Entire Model, 2:Print Insert Only]

//Height of your model in mm's, if choosing a sphere, height is calculated based on the sphere's width.
materialHeight = 65; 

//Width of your finished material in mm's (Final Product)
materialWidth = 50;

//Bottom Cylinder thickness in mm's, only used with "Two Radius Cylinder" model.
bottomMaterialWidth = 30;

//Desired thickness of media (Cement, Plaster, Wax...) in mm's. Changes the size of the insert.
cementThickness = 5;

//Desired thickness of model (How thick do you want it) in mm's.
moldThickness = 5;

//Resolution of build
resolution = 25;

//Show text below. Still working on getting letters on the "Two Radius Cylinder" model.  Not available on the "Dodecahedron" model.
showText = 0; //[0:No, 1:Yes]

//Something to say? 
writeSomething = "Howdy From TX";

//Letter spacing, default = 1.1
mySpace = 1.1;

//Letter height, default = 4
myHeight = 4;

//Font Choice
myFont = "write/Letters.dxf"; //["write/Letters.dxf":Letters, "write/BlackRose.dxf":Black Rose, "write/orbitron.dxf":Orbitron, "write/knewave.dxf":Knewave, "write/braille.dxf":Braille]

//Invert Text in mold (Embed)
invertText = 0; //[0:No, 1:Yes]

//Lots of variables... more for my sanity and to keep everything clean

function radius(diameter) = diameter / 2;

//Outer cube measurements
cubeMoldThickness = materialWidth + (moldThickness * 2);
cubeHeight = materialHeight + moldThickness;

//Outer Insert measurements
insertHeight = materialHeight - cementThickness + 1;
insertBotRad = radius(bottomMaterialWidth) - cementThickness;
insertTopRad = radius(materialWidth) - cementThickness;

//Insert cutout measurements
insertCutThickness = insertTopRad / 4;
insertCutHeight = insertHeight - insertCutThickness + 1;
insertCutBotRad = insertBotRad - insertCutThickness;
insertCutTopRad = insertTopRad - insertCutThickness;

//moving the insert away from the model
moveInsertXY = insertTopRad / 2;
moveInsertCutXY = insertCutTopRad / 2;
moveInsertCutZ = insertCutThickness;

/*
//Not in use: working on text for two radius cylinder
function findC(a,b) = sqrt((pow(a,2) + pow(b,2)));  //a^2 + b^2 = c^2... findC
function findDeg(a,o) = atan(a/o);  //find the arc tangent (for degrees) of an angle
textAngleDoubleRad = findDeg(materialWidth - bottomMaterialWidth, materialHeight);
textHeightFromTop = materialHeight / 2;
*/

//This is the cube that cuts the model in half
cutSize = cubeMoldThickness * 2;
cutMove = cutSize / 2;

//Movement of model cutouts to fit in the middle of the mold
moveCubeXY = cubeMoldThickness / 2;
moveCubeZ = cubeHeight / 2;
movePolyZ = moldThickness;
moveCubePolyZ = (materialHeight / 2) + moldThickness;

//Insert plier lip
plierLip = insertHeight / 2;
plierRad = insertTopRad / 4;

module drawMold(){
	difference(){
		if(moldType == 0){
			difference(){
				translate([0,0,moveCubeZ])
					cube(size = [cubeMoldThickness, cubeMoldThickness, cubeHeight], center = true);
				translate([0,0,movePolyZ])
						cylinder(h = materialHeight + 1, r1 = radius(bottomMaterialWidth), r2 = radius(materialWidth), $fn = resolution, center = false);
			}
		}else if(moldType == 1){
			difference(){
				translate([0,0,moveCubeZ])
					cube(size = [cubeMoldThickness, cubeMoldThickness, cubeHeight], center = true);
				translate([0,0,movePolyZ])
					cylinder(h = materialHeight + 1, r = radius(materialWidth), $fn = resolution, center = false);
			}
		}else if(moldType == 2){
			difference(){
				translate([0,0,moveCubeZ])
					cube(size = [cubeMoldThickness, cubeMoldThickness, cubeHeight], center = true);
				translate([0,0,moveCubePolyZ])
					cube(size = [materialWidth, materialWidth, materialHeight + 1], center = true);
			}
		}else if(moldType == 3){
			difference(){
				translate([0,0,moveCubeXY])
					cube(size = [cubeMoldThickness, cubeMoldThickness, cubeMoldThickness], center = true);
				union(){
					translate([0,0,moveCubeXY])
						sphere(r = radius(materialWidth), $fn = resolution);
					translate([0,0,moveCubeXY])
						cylinder(h = materialWidth, r1 = radius(materialWidth) / 4, r2 = radius(materialWidth) / 2, $fn = resolution, center = false);
				}
			}
		}else if(moldType == 4){
			difference(){
				translate([0,0,moveCubeZ])
					cube(size = [cubeMoldThickness, cubeMoldThickness, materialWidth], center = true);
				translate([0,0,moveCubeZ + 2.5])
					scale([materialWidth - moldThickness,materialWidth - moldThickness,materialWidth - moldThickness + 1]){
						intersection(){
							cube([2,2,1], center = true); 
						intersection_for(i=[0:4]){ 
							rotate([0,0,72*i]) rotate([116.565,0,0])
								cube([2,2,1], center = true); 
						}
					}
				}
			}
		}
		translate([-cutMove,0,cutMove/2])	
			cube(size = cutSize, center = true);
	}
}

module drawInnerMold(){
		union(){
			if(moldType == 0){
				difference(){
					cylinder(h = insertHeight, r1 = insertBotRad, r2 = insertTopRad, $fn = resolution, center = false);
					translate([0,0,insertCutThickness])
						cylinder(h = insertCutHeight, r1 = insertCutBotRad, r2 = insertCutTopRad, center = false);
				}
			}else if(moldType == 1){
				difference(){
					cylinder(h = insertHeight, r = insertTopRad, $fn = resolution, center = false);
					translate([0,0,insertCutThickness])
						cylinder(h = insertCutHeight, r = insertCutTopRad, center = false);
				}
			}else if(moldType == 2){
				difference(){
					translate([-moveInsertXY,-moveInsertXY, 0])
						cube(size = [insertTopRad, insertTopRad, insertHeight], center = false);
					translate([-moveInsertCutXY,-moveInsertCutXY, moveInsertCutZ])
						cube(size = [insertCutTopRad, insertCutTopRad, insertCutHeight], center = false);
				}
			}
			if(moldType < 3){
				translate([0,0,moveInsertCutZ])
					cylinder(h = plierLip, r = plierRad, center = false);
			}else	if(displayCutout == 2){
				if(moldType == 4){
					//Default Display
					translate([5,0,0]) drawDodecahedron();  
					translate([-5,0,0]) mirror([1,0,0]) drawDodecahedron();
				}else{
					//Default Display
					translate([5,0,0]) drawMold();
					translate([-5,0,0]) mirror([1,0,0]) drawMold();
				}
			}
		}
}

module drawDodecahedron(){
	difference(){
		difference(){
			translate([0,0,moveCubeZ])
				cube(size = [cubeMoldThickness, cubeMoldThickness, materialWidth], center = true);
			translate([0,0,moveCubeZ + 2.5])
				scale([materialWidth - moldThickness,materialWidth - moldThickness,materialWidth - moldThickness + 1]){
					intersection(){
						cube([2,2,1], center = true); 
						intersection_for(i=[0:4]){ 
							rotate([0,0,72*i]) rotate([116.565,0,0])
								cube([2,2,1], center = true); 
						}
					}
				}
		}
		translate([-cutMove,0,cutMove/2])	
			cube(size = cutSize, center = true);		
	}
}

module writeMe(){
	if(moldType == 1){
		translate([-5,0,0]) rotate([0,0,270])
				writecylinder(writeSomething,[0,0,materialHeight / 2],radius(materialWidth),materialHeight,font=myFont,h=myHeight,space=mySpace,t=2,center=true);	
	}else if(moldType == 2){
		translate([-5,0,0])
			writecube(writeSomething,[0,0,materialHeight / 2],[materialWidth,materialWidth,materialHeight],font=myFont,h=myHeight,space=mySpace,t=2,face="left");
	}else if(moldType == 3){
		translate([-5,0,materialWidth]) rotate([0,0,270]) rotate([0,180,0])
			writesphere(writeSomething,[0,0,materialWidth / 2],radius(materialWidth),font=myFont,h=myHeight,space=mySpace,t=4);
	}
}

//Final Display
if(displayCutout == 0){
	if(showText == 1){
		if(invertText == 1){
			difference(){
				translate([-5,0,0]) mirror([1,0,0])	drawMold();
				writeMe();
			}
			translate([5,0,0]) drawMold();
		}else{
			writeMe();
			translate([5,0,0]) drawMold();
			translate([-5,0,0]) mirror([1,0,0])	drawMold();
		}
	}else{
		translate([5,0,0]) drawMold();
		translate([-5,0,0]) mirror([1,0,0])	drawMold();
	}
	if(reqInsert == 1){
		translate([(cubeMoldThickness / 2) + insertTopRad + 10,0,0]) drawInnerMold();
	}
}else if(displayCutout == 1){
	if(showText == 1){
		if(invertText == 1){
			difference(){
				translate([-5,0,0]) mirror([1,0,0])	drawMold();
				writeMe();
			}
		}else{
			writeMe();
			translate([-5,0,0]) mirror([1,0,0])	drawMold();
		}
	}else{
		translate([-5,0,0]) mirror([1,0,0])	drawMold();
	}
	if(reqInsert == 1){
		translate([(cubeMoldThickness / 2) + insertTopRad + 10,0,0]) drawInnerMold();
	}
}else if(displayCutout == 2){
	drawInnerMold();
}