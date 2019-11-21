//Multirotor plate customizer V0.1.3 by eriqjo
//
//v0.2.1 6/4/2014	Major bug fix for standoffs and holes not rendering correctly
//v0.2.0 5/26/2014	Added more clearance between slots and mounting holes
//					Added KK2 Mounting feature
//					Shortened radio supports to minimize plug interference
//					Added custom plate features
//v0.1.2 5/25/2014	Improved resolution for holes
//					Added option for control board mount
//v0.1.1 5/24/2014	Initial release of project
//

//CUSTOMIZER VARIABLES

/* [Plate Dimensions] */

//Choose predefined platform, or custom
Multirotor_Platform = 3; // [1:Arducopter, 3:Custom]

//Choose type of plate to create
Plate_Type = 2; // [1:Radio,2:Control Board,3:Slotted,4:Custom Plate]

//Choose how thick to make the plate, mm
Plate_Thickness = 3; // [1:6]

Mounting_Bolt_Size = 3.2; // [2.2:M2,3.2:M3,4.2:M4,5.2:M5,6.2:M6]

//Center-to-center distance of adjacent mounting holes (custom only), mm
X_and_Y_Distance = 75; //

//Add a hole in the middle?
Additional_Hole = "Yes"; // [Yes,No] 

/* [Radio Plate] */

//How wide (y) is your radio RX, mm?
Radio_Width = 34.5;

//How long (x) is your radio RX, mm?
Radio_Length = 52;

//How many cable-ties to hold the radio down?
Cable_Tie_Ct = 2; // [0:3]

//How wide are your cable-ties, mm?
Cable_Tie_Width = 4;

//How tall do you want the supports, mm?
Support_Height = 5;

/* [Control plate] */

Control_Board = 2; // [1:KK2,2:Custom]

//Center-to-center distance in X-direction (custom only), mm
Control_Board_X = 33;

//Center-to-center distance in Y-direction (custom only), mm
Control_Board_Y = 33;

//How tall to make standoffs
Standoff_Height = 6;

//What size bolt to attach board (custom only)
Control_Board_Bolt = 2.5; // [1.6:M2,2.05:M2.5,2.5:M3,3.5:M4,4.5:M5]

/* [Slotted Plate] */

//How wide do you want the slots, mm?
Slot_Width = 3; // [1:5]

//Note: Too many wide slots will intersect.
Number_of_Slots = 11;

Profile = 1; // [1:Rounded,2:Square]

/* [Custom Plate] */

//Size of holes, mm 
Hole_Diameter = 3;

//Matrix of hole coordinates, ex: [[1,2], [2,3]]
Hole_Matrix = [[-22, -22], [-22, 22], [22, -22], [22, 22]];

//Hole diameter inside standoffs, mm
Standoff_Hole_D = 2.5;

//How tall to make the standoffs, mm
Custom_Standoff_Height = 6;

//Matrix of standoff coordinates, ex: [[1,2], [2,3]]
Standoff_Matrix = [[-15, -15], [-15, 15], [15, -15], [15, 15]];

//CUSTOMIZER VARIABLES END

/* [Hidden] */

Support_Width = 4; // How wide the radio structure will be

Support_Length = 4; // How long the corners are

Radio_Dim_Margin = 0.3; // Makes the holder a little bit bigger than measured so there is no interference

AntiCoPlanar = 0.2; // Make things bigger by this much so there are not ambiguous faces

Safety_Perimeter = 3; // Distance between the bolt hole and the edge of the plate

//***************************************************

module makeBase(){

	q = X_and_Y_Distance;

	if (Multirotor_Platform == 1){
		difference(){
			baseExtrude(68.25);
			baseHoles(68.25);
		}
	}

	if (Multirotor_Platform == 2){
		difference(){
			baseExtrude(q);
			baseHoles(q);
		}
	}

	if (Multirotor_Platform == 3){
		difference(){
			baseExtrude(q);
			baseHoles(q);
		}
	}

}

//***************************************************

module makeCustomPlate(){

	difference(){
		union(){
			addStandOffs(Standoff_Matrix, Standoff_Hole_D, Custom_Standoff_Height);
			makeBase();
		}	
		addHoles(Hole_Matrix, Hole_Diameter);
	}
}

//***************************************************

module makeSlots(dist){

	availableXY = dist - 2*Safety_Perimeter - Mounting_Bolt_Size;
	supportX = (availableXY - (Number_of_Slots * Slot_Width))/(Number_of_Slots - 1);
	echo(supportX);
	offset = supportX + Slot_Width;

	translate([-availableXY/2 + Slot_Width/2, 0, 0])
	for (i = [0:Number_of_Slots-1]){
		if (Profile == 1){
			translate([i * offset, 0, 0]){
				union(){
					cube([Slot_Width, availableXY - Slot_Width, 2*Plate_Thickness], center = true);
					translate([0, (availableXY - Slot_Width)/2, 0])	{
						cylinder(h = 2*Plate_Thickness, r = Slot_Width/2, center = true);
					}
					translate([0, -(availableXY - Slot_Width)/2, 0]){
						cylinder(h = 2*Plate_Thickness, r = Slot_Width/2, center = true);
					}
				}
			}
		}
		if (Profile == 2){
			translate([i * offset, 0, 0]){
				cube([Slot_Width, availableXY, 2*Plate_Thickness], center = true);
			}
		}
	}

}

//***************************************************

module radioSupport(){

	translate([0, 0, Support_Height/2 + Plate_Thickness/2]){
		difference(){
			cube([Radio_Length + Support_Width, Radio_Width + Support_Width, Support_Height + AntiCoPlanar], center = true);
			cube([Radio_Length + Radio_Dim_Margin, Radio_Width + Radio_Dim_Margin, Support_Height + 2*AntiCoPlanar], center = true);
			cube([Radio_Length + 2*Support_Width + AntiCoPlanar, Radio_Width - 2*Support_Length, Support_Height + 2*AntiCoPlanar], center = true);
			cube([Radio_Length - 2*Support_Length, Radio_Width + 2*Support_Width + AntiCoPlanar, Support_Height + 2*AntiCoPlanar], center = true);
		}		
	}
}

//***************************************************

module makeControlBoardPlate(){

	customX = Control_Board_X/2;
	customY = Control_Board_Y/2;

	if (Control_Board == 1){
		union(){
			makeBase();
			addStandOffs([[-22,-22],[-22,22],[22,-22],[22,22]], 2.5, Standoff_Height);			
		}
	}

	if (Control_Board == 2){
		union(){
			makeBase();
			addStandOffs([[-customX,-customY],[-customX,customY],[customX,-customY],[customX,customY]], Control_Board_Bolt, Standoff_Height);
		}
	}

}

//***************************************************

module makeRadioPlate(){

	union(){
		difference(){
			makeBase();
			cableTieHoles();
		}
		radioSupport();
	}

}

//***************************************************

module makeSlotPlate(s){

	difference(){
		makeBase();
		makeSlots(s);
	}

}

//***************************************************

module baseExtrude(Hole_Spacing){

	Square_Dims = Hole_Spacing + Mounting_Bolt_Size + Safety_Perimeter;
	cube([Square_Dims, Square_Dims, Plate_Thickness], center = true);
	
}

//****************************************************

module addStandOffs(location, diameter, height){

	for (i = location){
		translate([i[0], i[1], Plate_Thickness/2 + height/2])
		difference(){
			cylinder(h = height + AntiCoPlanar, r = (diameter + 3)/2, center = true, $fn = 20);
			cylinder(h = height + 2*AntiCoPlanar, r = diameter/2, center = true, $fn = 20);
		}
	}

}

//****************************************************

module cableTieHoles(){

	Hole_Y_Top = Radio_Width/2 + Support_Width + Cable_Tie_Width/2;
	Hole_Y_Bottom = -Hole_Y_Top; 

	if (Cable_Tie_Ct == 0) {  }  //Do nothing

	if (Cable_Tie_Ct == 1) {
		addHoles([[0,Hole_Y_Top],[0, Hole_Y_Bottom]], Cable_Tie_Width);
	}

	if (Cable_Tie_Ct == 2) {
		addHoles([[-0.25*Radio_Length, Hole_Y_Top], [0.25*Radio_Length, Hole_Y_Top],
			[-0.25*Radio_Length, Hole_Y_Bottom], [0.25*Radio_Length, Hole_Y_Bottom]], Cable_Tie_Width);
	}

	if (Cable_Tie_Ct == 3) {
		addHoles([[-0.4*Radio_Length, Hole_Y_Top], [0.4*Radio_Length, Hole_Y_Top],
			[0, Hole_Y_Top], [0, Hole_Y_Bottom],
			[-0.4*Radio_Length, Hole_Y_Bottom], [0.4*Radio_Length, Hole_Y_Bottom]], Cable_Tie_Width);
	}

}

//****************************************************

module baseHoles(xyDim){

	if (Additional_Hole == "Yes"){
		addHoles([[0, xyDim/2], [0, -xyDim/2],
			[-xyDim/2, 0], [xyDim/2, 0]], Mounting_Bolt_Size);
	}

	addHoles([[-xyDim/2, -xyDim/2], [-xyDim/2, xyDim/2],
		[xyDim/2, -xyDim/2], [xyDim/2, xyDim/2]], Mounting_Bolt_Size);

}

//****************************************************

module addHoles(pos, dia){		//Add hole at [x, y, d]

	for (i = pos){
		translate([i[0], i[1], 0]) cylinder(h = 2*(Plate_Thickness + Support_Height), r = dia/2, center = true, $fn = 10);
	}

}

//*****************************************************

//Here is the runtime stuff

if (Plate_Type == 1) {
	translate([0, 0, Plate_Thickness/2]) makeRadioPlate();
}

if (Plate_Type == 2) {
	translate([0, 0, Plate_Thickness/2]) makeControlBoardPlate();
}

if (Plate_Type == 3) {
	translate([0, 0, Plate_Thickness/2])
	if (Multirotor_Platform == 1){
		makeSlotPlate(68.25);
	}

	translate([0, 0, Plate_Thickness/2])
	if (Multirotor_Platform == 3){
		makeSlotPlate(X_and_Y_Distance);
	}

}

if (Plate_Type == 4){
	translate([0, 0, Plate_Thickness/2]){
		makeCustomPlate();
	}
}





