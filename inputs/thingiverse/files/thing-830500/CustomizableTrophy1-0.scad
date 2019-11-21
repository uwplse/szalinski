//Trophies
//because everyone's a weiner
//by eriqjo May 2015

/* [Select Parts] */

Include_Base = 1; // [1:Yes, 2:No]

Include_Pillars = 1; // [1:All, 2:Standalone Pillar, 3:None]

Include_Top_Plate = 1; // [1:Yes, 2:No]

/**********************************************************************/

/* [Core Dimensions] */

//Style
Base_Style = 1; // [1:1-Classic, 2:2-Tapered Pedastal, 3:3-Octagonal, 4:4-Squared Semi-Circle]

dimA = 150;
dimB = 150;
dimC = 15;
dimD = 5;
dimE = 100;
dimF = 40;

//Hole depth, mm:
Hole_Depth = 5;

//Hole diameter, mm:
Hole_Dia = 6;

//Peg height, mm:
Peg_Height = 4;

//Peg diameter, mm:
Peg_Dia = 5.5;

/**********************************************************************/

/* [Pillars] */

//Round or square pillar
Pillar_Shape = 2; // [1:Square, 2:Circle]

//Number of pillars
Number_of_Pillars = 4; // [0:0, 2:2, 4:4]

//Center-to-center distance of the pillars in the x-direction, mm: 
X_Between = 95;

//Center-to-center distance of the pillars in the y-direction (if 4 pillars), mm: 
Y_Between = 55;

//Height, mm:
Pillar_Height = 100;

//Diameter of circle/width of square, mm:
Outer_Dia = 20; // [5:50]

//# of depressions (if square, # per side limit 3):
Number_of_Depressions = 10; // [0:20]

//Number of pillar twists (90 degrees each):
Twists = 1; // [0:5]

//Slide to move pillars fore-aft as desired:
Y_Adjustment = 0; // [-50:50]

//Slide to move pillars side-to-side as desired:
X_Adjustment = 0; // [-50:50]

/******************************************************************/

/* [Top Plate] */

//Thickness to make the top plate, mm:
Plate_Thickness = 10;

//# of pegs in the x-direction
X_Pegs = 2; // [0:4]

//Distance between each peg in x-direction, mm:
X_Peg_Offset = 50;

//# of pegs in the y-direction:
Y_Pegs = 2; // [0:4]

//Distance between each peg in y-direction, mm:
Y_Peg_Offset = 50;

//Height of the top-plate pegs, mm:
Top_Peg_Height = 9;

//Diameter of the top-plate pegs
Top_Peg_Diameter = 5.5;

/******** END CUSTOMIZER VARIABLES **********/

depression_limiter = (3 < Number_of_Depressions) ? 3 : Number_of_Depressions; //don't want to make more than 3 for squares
square_depression_dia = (Outer_Dia)/(2 * depression_limiter);
circle_depression_dia = (3.14 * Outer_Dia)/(2 * Number_of_Depressions);

module array(y_correction = 0){

	n_x = (Number_of_Pillars > 0) ? 2 : 0;
	x_dist = X_Between;
	n_y = (Number_of_Pillars > 0) ? Number_of_Pillars/2 : 0;
	y_dist = Y_Between;

	translate([X_Adjustment, Y_Adjustment, 0]){	//manually moving the pillars with the slider control
		translate([-1*(n_x-1)*x_dist/2, -(n_y-1)*y_dist/2 + y_correction, 0]){
			for (j = [0:n_y-1]){
				for (i = [0:n_x-1]){
					translate([i*x_dist, j*y_dist, 0])
						children(0);
				}//for i
			}//for j
		}//translate
	}//translate
}//module array

module topPegArray(y_correction = 0){
	if(X_Pegs > 0 && Y_Pegs > 0){
		n_x = X_Pegs;
		x_dist = X_Peg_Offset;
		n_y = Y_Pegs;
		y_dist = Y_Peg_Offset;

		translate([0, 0, 0]){	//manually moving the pillars with the slider control
			translate([-1*(n_x-1)*x_dist/2, -(n_y-1)*y_dist/2 + y_correction, 0]){
				for (j = [0:n_y-1]){
					for (i = [0:n_x-1]){
						translate([i*x_dist, j*y_dist, 0])
							children(0);
					}//for i
				}//for j
			}//translate
		}//translate
	}//if
}//module topPegArray

module pegs(z_move = 0){
	translate([0,0,z_move])
		cylinder(h = Peg_Height, r = Peg_Dia/2, $fn = 12, center = false);
}//module add pegs to

module holes(z_move = 0){
	translate([0, 0, z_move - 0.1])
		cylinder(h = Hole_Depth + 0.1, r = Hole_Dia/2, $fn = 12, center = false);
}//module holes

module pillars(holeZ = 0, pegZ = Pillar_Height, translateZ = 0){

	translate([0, 0, translateZ]){
		if (Pillar_Shape == 1){	//square pillar
			union(){
				difference(){		//subtracts the depressions and bottom holes
					linear_extrude(height = Pillar_Height, center = false, convexity = 20, twist = 90 * Twists)	//main square body for pillar
						square([Outer_Dia, Outer_Dia], center = true);
					translate([0, 0, -0.5]){
						for (i = [0:3]){	//for each of the 4 sides of the square
							for (j = [0:depression_limiter - 1]){	//for the number of depressions per side
								rotate([0, 0, i * 90])
									linear_extrude(height = Pillar_Height + 1, center = false, convexity = 20, twist = 90 * Twists)
										translate([Outer_Dia/2, Outer_Dia * ((j + 1)/(depression_limiter + 1)) - Outer_Dia/2, -0.1])
											circle(r = square_depression_dia/2, center = true);		//subtracting this cylinder from the square
							}//for j
						}//for i
					}//translate	
					holes();
				}//difference
				pegs(pegZ);
			}//union
		}//if
			
		if (Pillar_Shape == 2){  //round pillar
			union(){
				difference(){
					cylinder(h = Pillar_Height, r = Outer_Dia/2, $fn = 20, center = false);	//the solid cylinder
					translate([0, 0, -0.5]){
						for (i = [0:Number_of_Depressions-1]){		//creating all of the subtraction cylinders
							rotate(a = [0, 0, i * 360/Number_of_Depressions])
								linear_extrude(height = Pillar_Height + 1, center = false, convexity = 20, twist = 90 * Twists)	
									translate([Outer_Dia/2, 0, -0.1])
										circle(r = circle_depression_dia/2, center = true);
						}//for
					}//translate
					//TODO create new holes function
					holes();
				}//difference
				//TODO correct peg function
				pegs(pegZ);
			}//union
		}//if
	}//translate
		
}//module

module pillarHelper(y, z){

		if (Include_Pillars == 1){	//include all pillars
			array(y_correction = y)
				pillars(translateZ = z);
		}//if include pillars == 1
		
		if (Include_Pillars == 2){
			pillars();
		}
}


//********************************BASE 1********************************

if (Base_Style == 1){

	y_center = dimB/2 - dimE/2 - dimD;
	z_base_peg = dimC + dimF;
	z_pillar_hole = z_base_peg;		//the hole in the pillar is the same height as the peg in the base
	z_pillar_peg = z_pillar_hole + Pillar_Height;
	z_top_plate_hole = z_pillar_peg;
	z_top_plate_peg = z_top_plate_hole + Plate_Thickness;
			
	if (Include_Base == 1){	//build base		
		union(){
			translate([0, 0, dimC/2])
				cube([dimA, dimB, dimC], center = true);
			hull(){
				translate([0, 0, dimC/2])	//base of the wedge
					cube([dimA - 2*dimD, dimB - 2*dimD, dimC], center = true);
				translate([0, ((dimB - 2*dimD) - dimE)/2, (dimC + dimF)/2])		//top platform of the wedge
					cube([dimA - 2*dimD, dimE, dimC + dimF], center = true);
			}//hull
			if (Number_of_Pillars > 0){		//doesn't add pegs if there are 0 pillars
				array(y_center)
					pegs(z_base_peg);
			}//if
		}//union
	}//if include base
	
	pillarHelper(y_center, z_base_peg);	//build pillars if included
	
	if (Include_Top_Plate == 1){
		difference(){
			translate( [0, ((dimB - 2*dimD) - dimE)/2, z_top_plate_hole + Plate_Thickness/2]){
				union(){
					cube([dimA - 2*dimD, dimE, Plate_Thickness], center = true);
					topPegArray(0)
						pegs(Plate_Thickness/2);
				}//union
			}//translate
			array(y_center)
				holes(z_top_plate_hole);
		}//difference
	}//if include top plate
	
}//base1

//********************************BASE 2********************************

if (Base_Style == 2){

	y_center = 0;
	z_base_peg = dimC;
	z_pillar_hole = z_base_peg;		//the hole in the pillar is the same height as the peg in the base
	z_pillar_peg = z_pillar_hole + Pillar_Height;
	z_top_plate_hole = z_pillar_peg;
	z_top_plate_peg = z_top_plate_hole + Plate_Thickness;
	
	if (Include_Base ==1){	//build base
		union(){
			hull(){
				cube([dimA, dimB, 0.01], center = true);
				translate([0, 0, dimC/2])
					cube([dimE, dimE, dimC], center = true);
			}//hull
			if (Number_of_Pillars > 0){
				array(y_center)
					pegs(z_base_peg);
			}//if
		}//union
	}//if include base
	
	pillarHelper(y_center, z_base_peg);
	
	if (Include_Top_Plate == 1){
		difference(){
			translate( [0, 0, z_top_plate_hole + Plate_Thickness/2]){
				union(){
					cube([dimE, dimE, Plate_Thickness], center = true);
					topPegArray(0)
						pegs(Plate_Thickness/2);
				}//union
			}//translate
			array(y_center)
				holes(z_top_plate_hole);
		}//difference
	}//module include top plate
	
}//base2

//********************************BASE 3********************************	

if (Base_Style == 3){

	y_center = 0;
	z_base_peg = dimC + dimF;
	z_pillar_hole = z_base_peg;		//the hole in the pillar is the same height as the peg in the base
	z_pillar_peg = z_pillar_hole + Pillar_Height;
	z_top_plate_hole = z_pillar_peg;
	z_top_plate_peg = z_top_plate_hole + Plate_Thickness;

	if (Include_Base ==1){	//build base
		union(){
			translate([0, 0, dimC/2])
				cube([dimA, dimA, dimC], center = true);
			translate([0, 0, dimC - 0.1])
				rotate([0, 0, 135/2])
					cylinder(h = dimF + 0.1, r = dimA/2, center = false, $fn = 8);
			if (Number_of_Pillars > 0){
				array(y_center)
					pegs(z_base_peg);
			}//if
		}//union
	}//if include base	
	
	pillarHelper(y_center, z_base_peg);
	
	if (Include_Top_Plate == 1){
		difference(){
			translate( [0, 0, z_top_plate_hole + Plate_Thickness/2]){
				union(){
					rotate([0, 0, 135/2])
						cylinder(h = Plate_Thickness, r = dimA/2, center = true, $fn = 8);
					topPegArray(0)
						pegs(Plate_Thickness/2);
				}//union
			}//translate
			array(y_center)
				holes(z_top_plate_hole);
		}//difference
	}// include top plate
	
}//base3

//********************************BASE 4********************************

if (Base_Style == 4){

	y_center = (dimA - dimB)/2;
	z_base_peg = dimC;
	z_pillar_hole = z_base_peg;		//the hole in the pillar is the same height as the peg in the base
	z_pillar_peg = z_pillar_hole + Pillar_Height;
	z_top_plate_hole = z_pillar_peg;
	z_top_plate_peg = z_top_plate_hole + Plate_Thickness;

	if (Include_Base ==1){	//build base
		if (dimB >= (dimA/2)){
			union(){
				difference(){	//creates the rear rounded part of the base
					cylinder(h = dimC, r = dimA/2, center = false);
					translate([0, -dimA, (dimC + 1)/2 - 0.5])
						cube([ dimA + 2, 2 * dimA, dimC + 1], center = true); //the cutting cube
				}//difference
				translate([0, -(dimB - (dimA/2))/2, dimC/2])		//creates the front rectangular section
					cube([dimA, dimB - (dimA/2) + 0.01, dimC], center = true);
				//TODO pegs here
				if (Number_of_Pillars > 0){
				array(y_center)
					pegs(z_base_peg);
				}//if
			}//union
		}//if
			
		if (dimB < (dimA/2)){	//error message for unacceptable dimensions
			text("DimB must be at least 1/2 of DimA", size = 5, valign = 0, halign = 0);
		}
	}//if include base	
	
	pillarHelper(y_center, z_base_peg);
	
	if (Include_Top_Plate == 1){
		difference(){
			translate( [0, 0, z_top_plate_hole ]){
				union(){
					if (dimB >= (dimA/2)){
						union(){
							difference(){	//creates the rear rounded part of the base
								cylinder(h = Plate_Thickness, r = dimA/2, center = false);		//the cylinder to be cut in half
								translate([0, -dimA, (Plate_Thickness + 1)/2 - 0.5])
									cube([ dimA + 2, 2 * dimA, Plate_Thickness + 1], center = true);	//the cutting cube
							}//difference
							translate([0, -(dimB - (dimA/2))/2, Plate_Thickness/2])		//creates the front rectangular section
								cube([dimA, dimB - (dimA/2) + 0.01, Plate_Thickness], center = true);
							//TODO pegs here
							if (Number_of_Pillars > 0){
								topPegArray(0)
									pegs(Plate_Thickness);
							}//if
						}//union
					}//if
			
					if (dimB < (dimA/2)){	//error message for unacceptable dimensions
						text("DimB must be at least 1/2 of DimA", size = 5, valign = 0, halign = 0);
					}//if 
					
				}//union
			}//translate
			array(y_center)
				holes(z_top_plate_hole);
		}//difference
	}// include top plate
	
}//base4

