	
/* [Thumb] */

//Include Thumb? 0=No, 1=Yes
	Thumb=1; //[0,1]

//diameter of DIP joint (40mm max)
	tDIPd= 24 ;

//Distal ring length
	tDRL= 12 ; //[8:Small_8mm,10:Medium_10mm,12:Large_12mm]

//------------------------------------------------------------


/* [Index Finger] */

//Include Index Finger? 0=No, 1=Yes
	Index=1; //[0,1]

//diameter of PIP joint (35mm max)
	iPIPd= 20 ;

//diameter of DIP joint (25mm max)
	iDIPd= 17 ;

//Proximal ring length
	iPRL= 10 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm,12:XLarge_12mm]

//Distal ring length
	iDRL=8; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm]

//------------------------------------------------------------

/* [Middle Finger] */

//Include Middle Finger? 0=No, 1=Yes
	Middle=1; //[0,1]

//diameter of PIP joint (35mm max)
	mPIPd= 21 ;

//diameter of DIP joint (25mm max)
	mDIPd= 17 ;

//Proximal ring length
	mPRL= 10 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm,12:XLarge_12mm]

//Distal ring length
	mDRL= 8 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm]

//------------------------------------------------------------

/* [Ring Finger] */

//Include Ring Finger? 0=No, 1=Yes
	Ring=1; //[0,1]

//diameter of PIP joint (35mm max)
	rPIPd= 20 ; 

//diameter of DIP joint (25mm max)
	rDIPd= 17 ; 

//Proximal ring length
	rPRL= 10 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm,12:XLarge_12mm]

//Distal ring length
	rDRL= 8 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm]

//------------------------------------------------------------

/* [Pinky Finger] */

//Include Pinky Finger? 0=No, 1=Yes
	Pinky=1; //[0,1]

//diameter of PIP joint (35mm max)
	pPIPd= 18 ;

//diameter of DIP joint (25mm max)
	pDIPd= 16 ; 

//Proximal ring length
	pPRL= 8 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm]

//Distal ring length
	pDRL= 6 ; //[6:Small_6mm,8:Medium_8mm,10:Large_10mm]

//------------------------------------------------------------



/* [Hidden] */

//--------------------------------------//

module ring(InnerRad,Height){

	difference(){	

		union(){

		translate([0,0,Height/2])
		difference(){

				//outer portion of ring
			union(){
				translate([0,0,Height/4])
				cylinder(r1=InnerRad+1.5,r2=InnerRad+3.5,h=Height/2,center=true);

				cylinder(r=InnerRad+2.5,h=Height/2,center=true);
	
				translate([0,0,-Height/4])
				cylinder(r1=InnerRad+3.5,r2=InnerRad+1.5,h=Height/2,center=true);
			}

				//inner portion of ring
			union(){
				translate([0,0,Height/4+0.5])
				cylinder(r1=InnerRad,r2=InnerRad+2,h=Height/2,center=true);

				cylinder(r=InnerRad+1,h=Height/2+1,center=true);
	
				translate([0,0,-Height/4-0.5])
				cylinder(r1=InnerRad+2,r2=InnerRad,h=Height/2,center=true);
			}

				//taking the sharp edge off of the outside
			difference(){
				cylinder(r=InnerRad+6.5,h=Height+2,center=true);
				cylinder(r=InnerRad+3,h=Height+4,center=true);
			}

		}

		//outer cylinders for cable guides
		rotate([0,0,25])
		translate([InnerRad+3.35,0,1])scale([1,1.35,1])cylinder(r=1.5,h=2,center=true,$fn=20);
	
		rotate([0,0,-25])
		translate([-InnerRad-3.35,0,1])scale([1,1.35,1])cylinder(r=1.5,h=2,center=true,$fn=20);

		//translate([0,-InnerRad-3.75,1.5])scale([1.35,1,1])cylinder(r=2,h=3,center=true,$fn=20);

		}

		//holes in cable guides
		rotate([0,0,25])
		translate([InnerRad+3.35,0,1])scale([1,1.35,1])cylinder(r=0.75,h=2.5,center=true,$fn=20);

		rotate([0,0,-25])
		translate([-InnerRad-3.35,0,1])scale([1,1.35,1])cylinder(r=0.75,h=2.5,center=true,$fn=20);

		//translate([0,-InnerRad-3.75,1.5])scale([1.35,1,1])cylinder(r=1.25,h=3.5,center=true,$fn=20);	
	}

}

//-----------------------------------------//

module distalring(InnerRad,Height){

	difference(){	

		union(){

		translate([0,0,Height/2])
		difference(){

				//outer portion of ring
			union(){			

				translate([0,0,Height/4])
				cylinder(r1=InnerRad+1.5,r2=InnerRad+3.5,h=Height/2,center=true);

				cylinder(r=InnerRad+2.5,h=Height/2,center=true);
	
				translate([0,0,-Height/4])
				cylinder(r1=InnerRad+3.5,r2=InnerRad+1.5,h=Height/2,center=true);
			}

				//inner portion of ring
			union(){

				translate([0,0,Height/4+0.5])
				cylinder(r1=InnerRad,r2=InnerRad+2,h=Height/2,center=true);

				cylinder(r=InnerRad+1,h=Height/2+1,center=true);
	
				translate([0,0,-Height/4-0.5])
				cylinder(r1=InnerRad+2,r2=InnerRad,h=Height/2,center=true);
			}

				//taking the sharp edge off of the outside
			difference(){
				cylinder(r=InnerRad+6.5,h=Height+2,center=true);
				cylinder(r=InnerRad+3,h=Height+4,center=true);
			}

		}
		
		//back of finger extension
	//	difference(){
//
//				translate([0,0,Height*2])
//				cylinder(r=InnerRad+3,h=Height*2,center=true);	
//
//				translate([0,0,Height*2])
//				cylinder(r=InnerRad+1.7,h=Height*2+2,center=true);
//		
//				translate([0,InnerRad,0])cube([InnerRad*4,InnerRad*3.5,Height*10],center=true);
//
//				difference(){
//					translate([0,0,Height-4])scale([1,1,2])rotate([90,0,0])
//					cylinder(r=InnerRad+10,h=Height*10,center=true);
//
//					translate([0,0,Height-4])scale([1,1,2])rotate([90,0,0])
//					cylinder(r=Height*1.25,h=Height*10+2,center=true);
//				}
//				
//				translate([0,0,Height-7+(Height*1.6)*1.5])rotate([90,0,0])cylinder(r=1.5,h=Height*10,center=true,$fn=10);
//			
//		}

			//cable guides
		//rotate([0,0,25])
		//translate([InnerRad+3.35,0,1])scale([1,1.35,1])cylinder(r=1.5,h=2,center=true,$fn=20);
	
		rotate([0,0,90])
		translate([-InnerRad-3.35,0,1])scale([1,1.35,1])cylinder(r=1.5,h=2,center=true,$fn=20);


		}

			//holes in cable guides
		//rotate([0,0,25])
		//translate([InnerRad+3.35,0,1])scale([1,1.35,1])cylinder(r=0.75,h=2.5,center=true,$fn=20);

		rotate([0,0,90])
		translate([-InnerRad-3.35,0,1])scale([1,1.35,1])cylinder(r=0.75,h=2.5,center=true,$fn=20);

	}


}

//----------------------------------------//


//calling the ring functions to make separate finger rings

//thumb
if (Thumb==1){
	//Thumb Distal ring
	translate([0,-70,0])
	distalring(tDIPd/2,tDRL);
}

//index finger
if (Index==1){
	//Index Proximal ring
	translate([-(iPIPd+iDIPd)/2,-35,0])
	ring(iPIPd/2,iPRL);

	//Index Distal ring
	translate([(iPIPd+iDIPd)/2,-35,0])
	distalring(iDIPd/2,iDRL);
}

//middle finger
if (Middle==1){
	//Middle Proximal ring
	translate([-(mPIPd+mDIPd)/2,0,0])
	ring(mPIPd/2,mPRL);

	//Middle Distal ring
	translate([(mPIPd+mDIPd)/2,0,0])
	distalring(mDIPd/2,mDRL);
}

//Ring finger
if (Ring==1){
	//Ring Proximal ring
	translate([-(rPIPd+rDIPd)/2,35,0])
	ring(rPIPd/2,rPRL);

	//Ring Distal ring
	translate([(rPIPd+rDIPd)/2,35,0])
	distalring(rDIPd/2,rDRL);
}

//Pinky finger
if (Pinky==1){
	//Pinky Proximal ring
	translate([-(pPIPd+pDIPd)/2,70,0])
	ring(pPIPd/2,pPRL);

	//Pinky Distal ring
	translate([(pPIPd+pDIPd)/2,70,0])
	distalring(pDIPd/2,pDRL);
}

