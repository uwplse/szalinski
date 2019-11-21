// ************* Credits part *************
// "Parametric Table Leg fixing" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//
//********************** License ******************
//**        "Parametric Table Leg fixing"        **
//**                  by rr2s                    **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
//
// ************* Declaration part *************
/* [Dimensions] */
// if cylindre = true (cylindre) - if cylindre = false (square or rectangle)
cylindre = "true";// [true,false]
// (Dimension of your leg in width, or diameter if it's a cylinder.WidthLeg and ideally keep proportional with WidthSupport)
WidthLeg        = 30;       
// (Dimension in length of your leg, or put the same diameter that  "width" if it's a cylinder.LengthLeg and ideally keep proportional with LengthSupport)
LengthLeg       = 30;
// (Dimension of your Support in width. Warning ! Dimension should be more than WidthLeg+screw(or head screw) . WidthSupport and ideally keep proportional with WidthLeg)
WidthSupport    = 80;       
// (Dimension of your Support in length. Warning ! Dimension should be more than LengthLeg+screw(or head screw). LengthSupport and ideally keep proportional with LengthLeg)
LengthSupport   = 80;
// (Dimensions of your object in Height "total size" )
HeightObject    = 60;

/* [screws] */
// Diameter of the screws
ScrewDiametre= 3;
// Diameter of the screws head
ScrewHeadDiametre= 0;
// Height of the head screws. Warning ! ThicknessWal must be  supperior to ScrewHeadHeight. If you want that screw is flush chose 0.
ScrewHeadHeight= 3;
// Number of screws Height
NumberOfScrewHeight  = 2;
// Number of screws in Width support. Warning ! Not be to put too screws if WidthSupport is small or using small screws.
NumberOfScrewWidth  = 2;
// Number of screws in Length support. Warning ! Not be to put too screws if LengthSupport is small or using small screws.
NumberOfScrewLength  = 2;
// Resolution for screws
ResolutionScrew=100; //[20:Draft,50:Medium,100:Fine, 200:Very fine]
// Hex or Resolution for screw head. Only for support.
ResolutionHeadScrew=100; //[6:Hex,20:Draft,50:Medium,100:Fine, 200:Very fine]

/* [Settings] */
//(Thickness Wall the dimention is in mm)
ThicknessWall = 5;
// Support or cutting support. If false =cutting support
SupportWithoutHoles = "true";// [false,true]
// Resolution of the internal cylinder if the cylinder = true
ResolutionCylindreInterieur=100; //[20:Draft,50:Medium,100:Fine, 200:Very fine]
// Resolution of the external cylinder if the cylinder = true
ResolutionCylindrExtrieure=100; //[6:Hex,7:heptagon,8:octagon,9:enneagon,10:decagon,20:Draft,50:Medium,100:Fine, 200:Very fine]
//if the cylinder = true and if SupportWithoutHoles = true -- the angle is calculate with WidthLeg, HeightObject and ThicknessWall. Warning ! You must enter these parameter (WidthLeg/2) must be egal at (HeightObject -ThicknessWall)  : The angle will be 45°.  If the "WidthLeg/2" is not egal (HeightObject -ThicknessWall). Use OpenScad and the "Echo" you give the max angle.This function should be further worked to select multiple angles.
cylinderAngleOfcut45="false";//[false,true]


// ************* private variable *************
WL  = WidthLeg;            // simplification of WidthLeg 
LL  = LengthLeg;           // simplification of LengthLeg 
WS  = WidthSupport;        // simplification of WidthSupport
LS  = LengthSupport;       // simplification of LengthSupport
HO  = HeightObject;        // simplification of HeightObject
SD  = ScrewDiametre;       // simplification of ScrewDiametre
SHD = ScrewHeadDiametre;   // simplification of ScrewHeadDiametre
SHH = ScrewHeadHeight;     // simplification of ScrewHeadHeight
RS  = ResolutionScrew;     // simplification of ResolutionScrew
RHS = ResolutionHeadScrew; // simplification of ResolutionHeadScrew
TH  = ThicknessWall;       // simplification of ThicknessWall


//calculating the hypotenuse of the support
	HR = sqrt(WS*WS+LS*LS);
// calculating the hypotenuse for cut support length
	HRW = sqrt(((HO-TH)*(HO-TH))+(WS/2-WL/2)*(WS/2-WL/2));
// calculating the hypotenuse for cut support Width
	HRL = sqrt(((HO-TH)*(HO-TH))+(LS/2-LL/2)*(LS/2-LL/2));


NbSH= NumberOfScrewHeight-1; // simplification of NumberOfScrewHeight
ScrewHeight= HO/(NumberOfScrewHeight+1);// NumberOfScrewHeight position for cutting
SH = ScrewHeight; // simplification of NumberOfScrewHeight
NbSW  = NumberOfScrewWidth-1;// simplification of NumberOfScrewWidth
ScrewWidth = WS/(NumberOfScrewWidth+1);// NumberOfScrewWidth position for cutting
NbSL=NumberOfScrewLength-1;// simplification of NumberOfScrewLength
ScrewLength = LS/(NumberOfScrewLength+1);// NumberOfScrewLength position for cutting

// ************* Executable part *************
difference(){ Base(); Cut();}

// ************* Module part Base *************

// Module of construction
module BaseVolumeCube(){
translate([0,0,HO/2-TH/2]) cube([WL+TH,LL+TH,HO-TH],center=true);
}

module BaseVolumeCylindre(){
cylinder(HO-TH, WL/2+TH, WL/2+TH,$fn=ResolutionCylindrExtrieure); 
}

module BaseVolumeSupport(){ 
translate([0,0,-TH/2]) cube([WS,LS,TH],center=true);
}

module BaseVolumeReinforcement(){
// digonal de renfort 1
	rotate([atan(WS/LS),-90,0]) translate([0,-HR/2,-TH/2]) cube([HO-TH,HR,TH]);
// digonal de renfort 2
	rotate([atan(LS/WS),-90,90]) translate([0,-HR/2,-TH/2]) cube([HO-TH,HR,TH]);
}

// ************* Module part Cut *************

module BaseCutCubeCenter(){
	if (SupportWithoutHoles == "false"){ translate([0,0,0]) cube([WL,LL,HO*2],center=true); 
}
	else{ translate([0,0,HO/2+TH/2]) cube([WL,LL,HO],center=true);
	echo("else");
 }
}

// cut cube length
module BaseCutCubeReinforcementHeight(){
	// cube 1 de cut
	translate([-WS/2,-LS/2-5,0]) rotate([0,-90+atan ((((WS-WL)/2)-(TH/2))/(HO-TH)),0]) cube([HRW,LS+10,TH*10]);
	// cube 1 de netoyage cut
	translate([-WS/2,-LS/2-5,-HRW/2]) rotate([0,-90,0]) cube([HRW,LS+10,TH]);
//mirroire des cubes cut
	mirror( [1,0,0] ) {
	//cube 2 de cut mirroir du cube de cute 1
	translate([-WS/2,-LS/2-5,0]) rotate([0,-90+atan ((((WS-WL)/2)-(TH/2))/(HO-TH)),0]) cube([HRW,LS+10,TH*10]);
	// cube 2 de netoyage cut mirroir du cube 1 de netoyage 1
	translate([-WS/2,-LS/2-5,-HRW/2]) rotate([0,-90,0]) cube([HRW,LS+10,TH*10]);
}}



module BaseCutCubeReinforcementWidth(){
	// cube 3 de cut
	translate([-WS/2-10,LS/2,0]) rotate([atan ((((LS-LL)/2)-(TH/2))/(HO-TH)),0,0]) cube([WS+20,TH*10,HRL]);
	// cube 4 de netoyage cut
	translate([-WS/2-10,LS/2,-HRL/2]) cube([WS+20,TH,HRL*2]);
//mirroire des cubes cut
	mirror( [0,1,0] ) {
		// cube 5 de cut
		translate([-WS/2-10,LS/2,0]) rotate([atan ((((LS-LL)/2)-(TH/2))/(HO-TH)),0,0]) cube([WS+20,TH*10,HRL]);
		// cube 6 de netoyage cut mirroir du cube 4 de netoyage cut
		translate([-WS/2-10,LS/2,-HRL/2]) cube([WS+20,TH,HRL*2]);
}}


module BaseCutCylindre(){
	if (SupportWithoutHoles == "false"){
	translate([0,0,-TH-1]) cylinder(HO+2, WL/2, WL/2,$fn=ResolutionCylindreInterieur);
	echo("if");
	}
	else{
		if (cylinderAngleOfcut45 == "false"){
			cylinder(HO-TH+1, WL/2, WL/2,$fn=ResolutionCylindreInterieur);
		}
		else{
			cylinder(HO-TH+1, 0, WL/2,$fn=ResolutionCylindreInterieur);
	}
}}



///Screw 
module BaseCutScrewHeight(){
	for ( i = [0 : NbSH] ){
		// Width screw cut
		translate([0,(WL+LL)/2,SH*(i+1)]) rotate([90,0,0]) cylinder(WL+LL, SD/2, SD/2,$fn=RS);
		// Length screw cut
		translate([(-WL+-LL)/2,0,SH*(i+1)]) rotate([0,90,0])cylinder(WL+LL, SD/2, SD/2,$fn=RS); 
}}


module BaseCutScrewLength(){
	for ( i = [0 : NbSL] ){
		// Length screw cut
		translate([WL/2+((WS-WL)/4),LS/2-ScrewLength*(i+1),(-WL+-LL)/2]) cylinder(WL+LL, SD/2, SD/2,$fn=RS);
	}
	mirror( [1,0,0] ) {
		for ( i = [0 : NbSL] ){
			// Length screw cut
			translate([WL/2+((WS-WL)/4),LS/2-ScrewLength*(i+1),(-WL+-LL)/2]) cylinder(WL+LL, SD/2, SD/2,$fn=RS);
}}}


module BaseCutScrewWidth(){
	for ( i = [0 : NbSW] ){
		// Width screw cut
		translate([WS/2-ScrewWidth*(i+1),LL/2+((LS-LL)/4),(-WL+-LL)/2]) cylinder(WL+LL, SD/2, SD/2,$fn=RS);
	}
	mirror( [0,1,0] ) {
		for ( i = [0 : NbSW] ){
			// Width screw cut
			translate([WS/2-ScrewWidth*(i+1),LL/2+((LS-LL)/4),(-WL+-LL)/2]) cylinder(WL+LL, SD/2, SD/2,$fn=RS);
}}}

///////////// head Screw   ///////////

module BaseCutHeadScrewLength(){
	for ( i = [0 : NbSL] ){
		// Length screw cut
		translate([WL/2+((WS-WL)/4),LS/2-ScrewLength*(i+1),-SHH]) cylinder(WL+LL, SHD/2, SHD/2,$fn=RHS);
	}
	mirror( [1,0,0] ) {
		for ( i = [0 : NbSL] ){
			// Length screw cut
			translate([WL/2+((WS-WL)/4),LS/2-ScrewLength*(i+1),-SHH]) cylinder(WL+LL, SHD/2, SHD/2,$fn=RHS);
}}}


module BaseCutHeadScrewWidth(){
	for ( i = [0 : NbSW] ){
		// Width screw cut
		translate([WS/2-ScrewWidth*(i+1),LL/2+((LS-LL)/4),-SHH]) cylinder(WL+LL, SHD/2, SHD/2,$fn=RHS);
	}
	mirror( [0,1,0] ) {
		for ( i = [0 : NbSW] ){
			// Width screw cut
			translate([WS/2-ScrewWidth*(i+1),LL/2+((LS-LL)/4),-SHH]) cylinder(WL+LL, SHD/2, SHD/2,$fn=RHS);
}}}


echo("--------------------------");
echo("Angle Max (cylinder cut)");
echo(90-atan((HeightObject-ThicknessWall)/(WidthLeg/2)));
echo("--------------------------");


// ************* Module grouping : base and cut  *************

module RenfortSupport(){
	union() {
		BaseVolumeSupport();
		BaseVolumeReinforcement();
	}
}

module RenfortSupportCutting(){
	difference(){ 
		RenfortSupport(); 	
		BaseCutCubeReinforcementHeight(); 
		BaseCutCubeReinforcementWidth();
	}
}


module Base(){   
	union() {
	if(cylindre == "true"){BaseVolumeCylindre(); }
	else{  BaseVolumeCube();   }    
	RenfortSupportCutting();
	}    
}

module Cut(){ 
	if(cylindre == "true"){ BaseCutCylindre();}
	else{  BaseCutCubeCenter();   }
	BaseCutScrewHeight();
	BaseCutScrewWidth();
 	BaseCutScrewLength();
	BaseCutHeadScrewWidth();
	BaseCutHeadScrewLength();

  }








