//Customizable VESA mount
//by eriqjo February 21, 2015

//TODO  redundant top plate support (rectangle between the semi-circles)

//CUSTOMIZER VARIABLES

/* [Global] */

//Which parts do you want to make?
Make_Part = 3; // [1:Back Bracket, 2:Top Plate, 3:Both]

/* [Back Bracket] */

//Choose the VESA mount size, mm
VESA_Size = 100; // [75:75x75, 100:100x100, 200:200x200]

//What are you mounting to?
Mount_To = 2; // [1:Direct to monitor/TV, 2:Wall mounting bracket]

//Mounting bolt diameter, mm:
Bolt_Dia = 4; // [3:8]

//Bracket width, mm:
Bracket_Width = 15; // [9:30]

//Bracket thickness, mm:
Bracket_Thickness = 4; // [4:20]

//Distance from top bracket hole to top of monitor/TV
Height_To_Top = 45;

/* [Top Plate] */

//Top plate style
Top_Style = 2; // [1:Solid(square), 2:Lite(x)]

//Top plate thickness, mm: 
Plate_Thickness = 5; // [3:8]

//The width of the box you are mounting, mm
Plate_Width = 170;

//The depth of the box you are mounting, mm
Plate_Depth = 140;

//How far back should the top plate be shifted, mm
Shift_Top_Back = 0;

//CUSTOMIZER VARIABLES END

slop = 0.2 * 1;

module buildBack(ydim = 25){

	topLength = Height_To_Top + ydim;

	difference(){
		union(){
			for(i = [-1, 1]){			//creating the two legs of the bracket
				translate([ i * VESA_Size/2, 0, 0])
					difference(){
						union(){
							cylinder(h = Bracket_Thickness, r = Bracket_Width/2, $fn = 20);		//bottom of leg
							translate([-Bracket_Width/2, 0, 0])									//leg
								cube([Bracket_Width, topLength, Bracket_Thickness]);			
						} // union
						translate([0, 0, -0.1])
							cylinder(h = Bracket_Thickness + slop, r = (Bolt_Dia + slop)/2, $fn = 10);	// bottom hole
						translate([0, ydim, -0.1])
							cylinder(h = Bracket_Thickness + slop, r = (Bolt_Dia + slop)/2, $fn = 10);  //bottom of slot
						translate([0, ydim + Bolt_Dia, -0.1])
							cylinder(h = Bracket_Thickness + slop, r = (Bolt_Dia + slop)/2 , $fn = 10); //top of slot
						translate([-(Bolt_Dia + slop)/2, ydim, -0.1])
							cube([Bolt_Dia + slop, Bolt_Dia, Bracket_Thickness + 0.2]);					//between the slot
					} // difference
			} // for
			translate([-Bracket_Width/2 - VESA_Size/2, topLength, 0])					//top portion of the bracket
				cube([VESA_Size + Bracket_Width, Bracket_Width, Bracket_Thickness]);
			for(i = [-1, 1]){
				translate([ i * (Bracket_Width/2 - Bracket_Thickness/2 + VESA_Size/2 ), topLength + Bracket_Width/2, Bracket_Thickness + (Bolt_Dia/2) + 2]){ // start of the semi-circle mounts
					rotate([0, 90, 0]){
						difference(){
							union(){
								cylinder( h = Bracket_Thickness, r = Bracket_Width/2, center = true, $fn = 20);
								translate([Bracket_Width/4, 0, 0,])
									cube([Bracket_Width/2, Bracket_Width, Bracket_Thickness], center = true);
							} // union
							cylinder(h = Bracket_Thickness + slop, r = (Bolt_Dia + slop)/2, center = true, $fn = 10);
						}//difference
					}//rotate	
				}//translate
			}//for	
		} // union
		translate([0, 0, -20]) {
			cube([300, 300, 40], center = true);
		}//translate
	}//difference
}//module buildBack

module buildTop(ydim = 25){	

	topLength = Height_To_Top + ydim;
	unit = min(Plate_Depth, Plate_Width)/2;
	
	union(){
		if(Top_Style == 1){		//solid square top plate
			translate([0, Plate_Thickness/2  + topLength + 1.9 + Bracket_Width, Plate_Depth/2 - Shift_Top_Back])  //original

				cube([Plate_Width, Plate_Thickness, Plate_Depth], center = true);
		}//if
		
		if(Top_Style == 2){		//Lite X-style top plate
			translate([0, Plate_Thickness/2  + topLength + 1.9 + Bracket_Width, Plate_Depth/2 - Shift_Top_Back])
				difference(){
					cube([Plate_Width, Plate_Thickness, Plate_Depth], center = true);								//plate itself
					for(i = [[Plate_Width/2, 0, 0], [0, 0, Plate_Depth/2], [-Plate_Width/2, 0, 0]]){
						translate(i)	
							rotate([0, 45, 0]){
								cube([unit, Plate_Thickness+1, unit], center = true);
							}//rotate
					}//for
				}//difference	
		}//if
		for(i = [-1,1]){
			translate([i * (Bracket_Thickness/2 + VESA_Size/2 + Bracket_Width/2 + slop), topLength + Bracket_Width/2, Bracket_Thickness + (Bolt_Dia/2) + 2]){
				rotate([0, 90, 0]){
					difference(){
						union(){
							cylinder( h = Bracket_Thickness, r = Bracket_Width/2, center = true, $fn = 20);			//swivel attachment semi-circle
							translate([0,Bracket_Width/4 + 1,0])
								cube([Bracket_Width, Bracket_Width/2 + 2, Bracket_Thickness], center = true);		//swivel attachment point
						}//union
						cylinder( h = Bracket_Thickness + slop, r = (Bolt_Dia + slop)/2, center = true, $fn = 12);  //swivel hole
					}//difference
				}//rotate	
			}//translate
		}//for
		translate([0, Plate_Thickness/2  + topLength + 1.9 + Bracket_Width, Bracket_Thickness + (Bolt_Dia/2) + 2])
			cube([2*Bracket_Thickness + VESA_Size + Bracket_Width +slop, Plate_Thickness, Bracket_Width], center = true);
	}//union		
}//module buildTop

if (Mount_To == 1){
	if(Make_Part == 1) {buildBack(ydim = VESA_Size);}
	if(Make_Part == 2) {buildTop(ydim = VESA_Size);}
	if(Make_Part == 3) {buildTop(ydim = VESA_Size); buildBack(ydim = VESA_Size);}
}// if

if (Mount_To == 2){
	if(Make_Part == 1) {buildBack(ydim = 25);}
	if(Make_Part == 2) {buildTop(ydim = 25);}
	if(Make_Part == 3) {buildTop(ydim = 25); buildBack(ydim = 25);}
}// if

