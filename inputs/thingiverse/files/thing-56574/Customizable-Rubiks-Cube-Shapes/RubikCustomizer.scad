//OpenScad script for creating custom Rubik cube shapes
//Created By Steve Nicholls March 2013
//Released under a Attribution-NonCommercial 3.0 Unported (CC BY-NC 3.0) license

//It is recommended that a Rubik's donor core be used, eventually the script may be updated to include a printable core.
//It assumes the cube has end caps

//entry point for script
displayPuzzle();

/***********************************************
Settings that impact upon the end result of the custom shape
***********************************************/

//Select the part(s) to show
part=0;//[0:Fully Assembled Puzzle,1:1 Right Center,2:2 Bottom Center,3:3 Top Center,4:4 Back Center,5:5 Front Center,6:6 Left Center,7:7 Top Back Right Corner,8:8 Top Front Right Corner,9:9 Bottom Front Right Corner,10:10 Bottom Back Right Corner,11:11 Bottom Front Left Corner,12:12 Top Front Left Corner,13:13 Top Back Left Corner,14:14 Bottom Back Left Corner,15:15 Back Right Edge,16:16 Top Right Edge,17:17 Front Right Edge,18:18 Bottom Right Edge,19:19 Bottom Back Edge,20:20 Top Back Edge,21:21 Bottom Front Edge,22:22 Top Front Edge,23:23 Back Left Edge,24:24  Bottom Left Edge,25:25 Front Left Edge,26:26 Top Left Edge]
//Filter the pieces shown in the full assembly
Full_Assembly_Filter=0;// [0:All, 1:Corners only, 2:Edges only,3:Centers only,4:Layer 1];
//Distance to explode pieces in assembled rendering
Explode_Distance=1;//[0:30]

//Warning rounding the edges seriously slows down customizer. Only do this when you are ready to create STL files
Round_Edges_See_Warning=0;//[0:No,1:Yes]

//Select the base shape for the target puzzle. The resolution settings for the sphere and cylinder allow lots of other shapes to be created. (download the OpenSCAD file to set target shape to 5 and import STL's or add your own shapes). Current custom shape is a cube skewed through 15 degrees.
Target_shape=3;//[0:Cube,1:Sphere,2: Cylinder,3:Octahedron,4:Custom shape]
//Resolution (only applies to sphere and cylinder shapes)
Target_Shape_Resolution=6;//[3:60]
//Radius of target shape (only applies to sphere and cylinder shapes)
Target_Shape_Radius_1=40;//[30:60]
//Second Radius of target shape (only applies to cylinder base shape)
Target_Shape_Radius_2=40;//[30:60]
//Height of cylinder
Cylinder_Height=60;//[45:200]
//Angle to rotate target shape around X-Axis
Target_X_Angle=0;//[0:90]
//Angle to rotate target shape around Y-Axis (applied after X rotation)
Target_Y_Angle=0;//[0:90]
//Angle to rotate target shape around Z-Axis (applied after X and Y rotations)
Target_Z_Angle=0;//[0:90]
//Angle to rotate top layer before applying target shape.
Top_Layer_Offset=0;//[-45:45]
//Angle to rotate bottom layer before applying target shape
Bottom_Layer_Offset=0;//[-45:45]
//Amount to offset target shape along y-axis
Target_X_Offset=0;//[-100:100]
//Amount to offset target shape along y-axis
Target_Y_Offset=0;//[-100:100]
//Amount to offset target shape along z-axis
Target_Z_Offset=0;//[-100:100]
//Scaling factor for target shape. Increase if target shape does not fully cover donor mechanism.
Target_Scale=1;
//Factor cubies are extended out by. Increase this if target shape covers mechanism but some parts of final shape are being truncated.
Extend_Donor_Cube_Factor=2;

/***********************************************
//Settings dependent on attributes of the "donor" cube
//Following settings work for official Rubik's/Rubik's promotion cubes with caps
***********************************************/
//Edge length of donor cube. This and the following settings only need to be changed if pieces printed are too tight/loose
CUBESIZE=57*1;
//tolerance between pieces
Tolerance=0.2*1;
//width of edge piece core insert
EDGEWEDGEWIDTH=9*1;
//radius of inner core (principally affects how much corner core piece intersects with corner cubies)
CORERADIUS=18*1;
//radius of (one of the six) "spokes" that extend from core piece 
SPOKERADIUS=4.5*1;
//Height of cap on center pieces (excluding protruding ridges)
CAPHEIGHT=2*1;
//Height of cap ridges
CAPRIDGEHEIGHT=4*1;
//Width (outer) of cap ridge.
CAPRIDGESIZE=12.7*1;


//to create other target shapes insert the appropriate code here (ideally shape will be centered)
module customShape() {

	//code for custom shapes here, at present a cube skewed 15 degrees through the x-axis is used
	multmatrix(m = [ [1, tan(15), 0, 0],
                 [0, 1,0, 0],
                 [0, 0, 1, 0],
                 [0, 0, 0,  1]
               ]) cube(60,center=true);


}

//Following settings are parametric but can not be changed in customiser
//Can only be used outside customizer on Thingiverse
STLFILENAME="heart.stl";
ENDSHAPEROTATION=[Target_X_Angle,Target_Y_Angle,Target_Z_Angle];
ENDSHAPEOFFSET=[Target_X_Offset,Target_Y_Offset,Target_Z_Offset];


//following settings are derived from changeable parametric settings and shouldn't be changed
cubieoutersize=CUBESIZE/3;//size of cubies
cubieinnersize=cubieoutersize-Round_Edges_See_Warning*2-Tolerance/2;//size of cubies allowing for tolerances and minkowski rounding

module targetShape() {
	
	translate(ENDSHAPEOFFSET) rotate (ENDSHAPEROTATION) scale(Target_Scale) {

		if (Target_shape==0)	cube(CUBESIZE,true);
		if (Target_shape==1)	sphere(r=Target_Shape_Radius_1,$fn=Target_Shape_Resolution);
		if (Target_shape==2)	cylinder(h= Cylinder_Height,r1=Target_Shape_Radius_1,r2=Target_Shape_Radius_2,$fn=Target_Shape_Resolution,center=true);
		if (Target_shape==3)	rotate([0,0,45])  polyhedron(
  points=[ [33,33,0],[33,-33,0],[-33,-33,0],[-33,33,0], 
           [0,0,sqrt(2*33*33)],[0,0,-sqrt(2*33*33)] ],                                
  triangles=[ [0,1,4],[1,2,4],[2,3,4],[3,0,4],          
              [2,1,5],[1,0,5],[0,3,5],[3,2,5] ]                        
 );
		if (Target_shape==4)	customShape();
		if (Target_shape==5)	import(STLFILENAME);
	}
}

module displayPuzzle() {

	if (part==0) {
		layer1();
		layer2();
		layer3();
	} else {
		showPiece(part);
	}
}

module showPiece(piecenumber=1) {

	//Layer 1 pieces
	if (piecenumber==15) edge();
	if (piecenumber==16) edge(x=90,z=Top_Layer_Offset);
	if (piecenumber==17) edge(x=180);
	if (piecenumber==18) edge(x=270,z=Bottom_Layer_Offset);
	if (piecenumber==7) corner(z=Top_Layer_Offset);
	if (piecenumber==8) corner(x=90,z=Top_Layer_Offset);
	if (piecenumber==9) corner(x=180,z=Bottom_Layer_Offset);
	if (piecenumber==10) corner(x=270,z=Bottom_Layer_Offset);
	if (piecenumber==1) centercap();

	//Layer 2 pieces
	if (piecenumber==2) centercap(y=90,z=Bottom_Layer_Offset);
	if (piecenumber==3) centercap(y=-90,z=Top_Layer_Offset);
	if (piecenumber==4) centercap(z=90);
	if (piecenumber==5) centercap(z=-90);
	if (piecenumber==19) edge(y=90,z=Bottom_Layer_Offset);
	if (piecenumber==20) edge(y=-90,z=Top_Layer_Offset);
	if (piecenumber==21) edge(x=180,y=90,z=Bottom_Layer_Offset);
	if (piecenumber==22) edge(x=180,y=-90,z=Top_Layer_Offset);

	//Layer 3 pieces
	if (piecenumber==23) edge(y=180);
	if (piecenumber==24) edge(x=90,y=180,z=Bottom_Layer_Offset);
	if (piecenumber==25) edge(x=180,y=180);
	if (piecenumber==26) edge(x=270,y=180,z=Top_Layer_Offset);
	if (piecenumber==14) corner(y=180,z=Bottom_Layer_Offset);
	if (piecenumber==11) corner(x=90,y=180,z=Bottom_Layer_Offset);
	if (piecenumber==12) corner(x=180,y=180,z=Top_Layer_Offset);
	if (piecenumber==13) corner(x=270,y=180,z=Top_Layer_Offset);
	if (piecenumber==6) centercap(y=180);

};

module layer1() {
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2)  rotate([0,0,0]) showPiece(15);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([90,0,Top_Layer_Offset]) showPiece(16);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([180,0,0]) showPiece(17);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([270,0,Bottom_Layer_Offset]) showPiece(18);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([0,0,Top_Layer_Offset]) showPiece(7);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([90,0,Top_Layer_Offset]) showPiece(8);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([180,0,Bottom_Layer_Offset]) showPiece(9);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([270,0,Bottom_Layer_Offset]) showPiece(10);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,0,0]) showPiece(1);
}

module layer2() {
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,90,Bottom_Layer_Offset]) showPiece(2);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,-90,Top_Layer_Offset])	showPiece(3); 
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,0,90])	centercap(z=90) showPiece(4);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,0,-90])	centercap(z=-90) showPiece(5);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([0,90,Bottom_Layer_Offset]) showPiece(19);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([0,-90,Top_Layer_Offset]) showPiece(20);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([180,90,Bottom_Layer_Offset]) showPiece(21);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([180,-90,Top_Layer_Offset]) showPiece(22); 
}

module layer3() {
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([0,180,0]) showPiece(23);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([90,180,Bottom_Layer_Offset]) showPiece(24);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([180,180,0]) showPiece(25);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==2) rotate([270,180,Top_Layer_Offset]) showPiece(26);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([0,180,Bottom_Layer_Offset]) showPiece(14);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([90,180,Bottom_Layer_Offset]) showPiece(11);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([180,180,Top_Layer_Offset]) showPiece(12);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==1) rotate([270,180,Top_Layer_Offset]) showPiece(13);
	if (Full_Assembly_Filter==0 || Full_Assembly_Filter==3) rotate([0,180,0])  showPiece(6);
}

module edge(x=0,y=0,z=0) {
    translate([Explode_Distance,Explode_Distance,0]) union() {
        difference() {
		//if there is no rounding skip minkowski call to speed things up
		if (Round_Edges_See_Warning>0) {
			minkowski() {
				rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedEdge(x,y,z);
				sphere(r=Round_Edges_See_Warning, $fn=12);
				}
		} else {
			rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedEdge(x,y,z);
		}
          coreSpace(CORERADIUS+Tolerance/2,60);
      }
	intersection() {
	      translate([SPOKERADIUS+Tolerance/2,SPOKERADIUS+Tolerance/2,-EDGEWEDGEWIDTH/2]) cube([CORERADIUS-SPOKERADIUS-Tolerance,CORERADIUS-SPOKERADIUS-Tolerance,EDGEWEDGEWIDTH]);
//		coreSpace(CORERADIUS+Tolerance/2+.01,60);
		}
	}
}

module truncatedEdge(x=0,y=0,z=0) {
	intersection() {
		rotate([x,y,z]) translate([cubieoutersize/2+Round_Edges_See_Warning,cubieoutersize/2+Round_Edges_See_Warning,-cubieinnersize/2]) cube([cubieoutersize*Extend_Donor_Cube_Factor, cubieoutersize*Extend_Donor_Cube_Factor, cubieinnersize]);
		targetShape();
	}
}

module corner(x=0,y=0,z=0) {

    		translate([Explode_Distance,Explode_Distance,Explode_Distance]) union() {
			if (Round_Edges_See_Warning>0) {
				minkowski() {
					rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedCorner(x,y,z);	
					sphere(r=Round_Edges_See_Warning, $fn=12);
					}
		} else {
			rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedCorner(x,y,z);	
		}

		intersection() {
      		translate([(EDGEWEDGEWIDTH+Tolerance)/2,(EDGEWEDGEWIDTH+Tolerance)/2,(EDGEWEDGEWIDTH+Tolerance)/2]) cube(CUBESIZE) ;
	          	coreSpace();
		}
	}
}


module truncatedCorner(x=0,y=0,z=0) {
	intersection() {
		rotate([x,y,z]) translate([cubieoutersize/2+Round_Edges_See_Warning,cubieoutersize/2+Round_Edges_See_Warning,cubieoutersize/2+Round_Edges_See_Warning]) cube(cubieinnersize*Extend_Donor_Cube_Factor);
		targetShape();
	}
}

module centercap(x=0,y=0,z=0) {

	translate([Explode_Distance,0,0]) union() {
      	difference() {
			if (Round_Edges_See_Warning>0) {
				minkowski() {
					rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedcap(x,y,z);
					sphere(r=Round_Edges_See_Warning, $fn=12);
				}
			} else {
				rotate([-x,0,0]) rotate([0,-y,0]) rotate([0,0,-z]) truncatedcap(x,y,z);
			}
		
	            	  translate([cubieoutersize-CAPHEIGHT,0,0]) cube(cubieoutersize,true);
            }

		difference() {
			translate([cubieoutersize*1.5-CAPHEIGHT-CAPRIDGEHEIGHT/2,0,0]) cube([CAPRIDGEHEIGHT,CAPRIDGESIZE,CAPRIDGESIZE],true);
			translate([cubieoutersize*1.5-CAPHEIGHT-CAPRIDGEHEIGHT/2,0,0]) cube([CAPRIDGEHEIGHT,CAPRIDGESIZE-4,CAPRIDGESIZE-4],true);
		}
	}
}

module truncatedcap(x=0,y=0,z=0) {
	intersection() {
		rotate([x,y,z]) translate([((cubieoutersize+cubieinnersize*Extend_Donor_Cube_Factor)/2) + Round_Edges_See_Warning,0,0]) cube([cubieinnersize*Extend_Donor_Cube_Factor, cubieinnersize, cubieinnersize],true);
		targetShape();
	}
}

//space for core
module coreSpace(radius=CORERADIUS,facets=60) {

// 
//	sphere(radius,$fn=facets);

	intersection() {
		cylinder(CUBESIZE,r=radius,$fn=facets,center=true);
		rotate([90,0,0]) cylinder(CUBESIZE,r=radius,$fn=facets,center=true);
		rotate([0,90,0]) cylinder(CUBESIZE,r=radius,$fn=facets,center=true);
	}
}

