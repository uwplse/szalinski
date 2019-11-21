// ************* Credits part *************
// "Fixing customize w" 
// Programmed by Rudy RUFFEL - Decembre 2014
// Optimized for Customizer makerbot
//
//
//********************** License ******************
//**         "Fixing customize" by rr2s          **
//**  is licensed under the Creative Commons     **
//** - Attribution - Non-Commercial license.     **
//*************************************************
//
//
// ************* Declaration part *************

/* [Dimensions] */ 
// (Width this number will be multiplied by the number of screws on height (in mm). Example : if you specify 15mm and there are two screws on height, the total height will be 30mm. The thickness of wall is proportional to the width if you indicates a width 15mm  the thickness will  5mm. But you can change if you wantt hickness in tab)
Width         = 15;       
// (Length of fixing this number will multipier by the number of screw on length (in mm). Example : if you specify 10 and there are two screws on length, the total length will be 20.)
Height        = 10;
// Angle is 60 °. It can not be over because the screws not spend mounting. You can choose an angle between 90 ° and 0 °.
angle = 10;


/* [screw] */
// (number of height screw, if you want one screw.)
NumberOfScrewHeight  = 1;
// (number of width screw)
NumberOfScrewWidth = 1  ; 
// (diameter of screw) 
DiametreScrew = 3;        
// (screw head diameter of generally 2 times the diameter of the screw. Attention ! Check that the width and height is supperior in diameter screws.)
DiametreHeadScrew = 6;
// (Height of the screw head, if you want that screw is flush chose 0. Attention ! Check that the width and height is supperior in diameter screws.)
HeightHeadScrew   = 3;
// (Resolution of screws)
ResolutionScrew=100; //[20:Draft,50:Medium,100:Fine, 200:Very fine]
	RS = ResolutionScrew;
// (Creates a hex or cylindrical head screws)
ResolutionHeadScrew=100; //[6:Bolt (hex),20:Draft,50:Medium,100:Fine, 200:Very fine]
	RH = ResolutionHeadScrew;


/* [Thickness] */
//(Thickness Wall is normaly proportional to the width (Width/3) if ThicknessWall = 0. But you can change if you want. Attention ! Check that the Thickness Wall is supperior at HeightHeadScrew.the dimention is in mm)
ThicknessWall = 0;



// ************* private variable *************
	//TH = Width/3;  //  ThicknessWall base if ThicknessWall = 0
	TH= ThicknessWall == 0  ? Width/3 : ThicknessWall;
	W = Width;     // Simplifying the Variable : Width 
	H = Height;    // Simplifying the Variable : Height
    NbScrew = NumberOfScrewHeight -1; // Simplifying the Variable : NumberOfScrewHeight
	rScrew = DiametreScrew/2;      // radius of the screw
	CWS = TH+((W-TH)/2); // centering the screw on width
	CHS = H/2; // centering the screw on Height
	rHScrew = DiametreHeadScrew/2;  //radius of the Head screw
	HHS = HeightHeadScrew; // Simplifying the Variable : HeightHeadScrew
	NbScrewWidth = NumberOfScrewWidth-1; // Simplifying the Variable :  NumberOfScrewWith


// ************* Executable part *************
union(){
    difference(){
        Base1();
        Cut();
    }

    rotate([0,angle-90,0])difference(){
        Base2();
        Cut();
    }
}



// ************* Module part simple screw *************

// Module de construction
module BaseVolume1(){
	for ( i = [0 : NbScrew] ){
		translate([0,(H*i)-H,0])  cube([W,H,TH]);
		}
}

// Module de construction
module BaseVolume2(){
	for ( i = [0 : NbScrew] ){
		translate([TH,(H*i)-H,0]) rotate([0,-90,0]) cube([W,H,TH]);
		}
}

module BaseScrew(){
	for ( i = [0 : NbScrew] ){
		translate([CWS,CHS+((i*H)-H),-W]) cylinder(W*2,rScrew,rScrew,$fn=RS);
		translate([W,CHS+((i*H)-H),CWS]) rotate([0,-90,0]) cylinder(W*2,rScrew,rScrew,$fn=RS);
	}
}

module BaseScrewHead(){
	for ( i = [0 : NbScrew] ){
		translate([CWS,CHS+((i*H)-H),TH-HHS]) cylinder(W*2,rHScrew,rHScrew,$fn=RH);
		translate([(W*2)+TH-HHS,CHS+((i*H)-H),CWS]) rotate([0,-90,0]) cylinder(W*2,rHScrew,rHScrew,$fn=RH);
	}
}

// ************* Module part multi-screw *************

 module BaseVolume1MultiScrew(){
	for ( e = [0 : NbScrewWidth] ){
		for ( i = [0 : NbScrew] ){
			union() {
			translate([(W-TH)*e+TH,(H*i)-H,0])cube([W-TH,H,TH]);
			}
		}
	}
}

 module BaseVolume2MultiScrew(){
	for ( e = [0 : NbScrewWidth] ){
		for ( i = [0 : NbScrew] ){
			union() {
			translate([TH,(H*i)-H,(W-TH)*e+TH]) rotate([0,-90,0]) cube([W-TH,H,TH]);
			}
		}
	}
}


module BaseScrewMulti(){
	for ( e = [0 : NbScrewWidth] ){
		for ( i = [0 : NbScrew] ){
			translate([CWS+((W-TH)*e),CHS+((i*H)-H),-W]) cylinder(W*2,rScrew,rScrew,$fn=RS);
			translate([W,CHS+((i*H)-H),CWS+(W-TH)*e]) rotate([0,-90,0]) cylinder(W*2,rScrew,rScrew,$fn=RS);
		}
	}
}


module BaseScrewHeadmulti(){
	for ( e = [0 : NbScrewWidth] ){
		for ( i = [0 : NbScrew] ){
			translate([CWS+((W-TH)*e),CHS+((i*H)-H),TH-HHS]) cylinder(W*2,rHScrew,rHScrew,$fn=RH);
			translate([(W*2)+TH-HHS,CHS+((i*H)-H),CWS+(W-TH)*e]) rotate([0,-90,0]) cylinder(W*2,rHScrew,rHScrew,$fn=RH);
		}
	}
}

// ************* Module grouping : base and cut  *************

// module of base
module Base1(){
        BaseVolume1();
		if (NbScrew > 0 || NbScrewWidth > 0) {
		BaseVolume1MultiScrew();
		}
}

// module of base
module Base2(){
		BaseVolume2();
		if (NbScrew > 0 || NbScrewWidth > 0) {
        BaseVolume2MultiScrew();   
		}
}



// module of cut
module Cut(){
	BaseScrew();
	BaseScrewHead();
 	if (NbScrew > 0 || NbScrewWidth > 0) {
	BaseScrewMulti();
	BaseScrewHeadmulti();
	}
}











