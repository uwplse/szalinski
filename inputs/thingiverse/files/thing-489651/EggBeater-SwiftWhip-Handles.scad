//Handles for Swift Whip egg beater
//
// These are  split so they can be retrofitted to the riveted rods
// enable the parts you want to make files for with the "if (1==0)" lines at the end.....
// a little sanding of the inside split line should adjust the part line to be flush.
// Before glueing the halves together, run for a while to run in the rod in the hole.
// glue together with epoxy or abs solvent glue.
// I printed the crank at 0.25mm and Handle at 0.3mm, on Up Mini. 

/* [Main] */
//note that I have two types of SwiftWhip. The type with wooden handles has different dimensions to the one with plastic handles.
part="All";//[All:All assembled, TopHandle: Top Handle split open, Crank: Crank split open]
 //Different for my two different beaters
CrankLength=41; //[35:Plastic Type 35mm, 41:Wooden Type 41mm] 

//----------- Dimensions
//Naming: T for Top handle , C for Crank handle

/* [Split Fitting] */

//Adjust these for flush fit across the split, (actually sand to size is faster).  radius of the inside split corners
SplitR=1; // radius of the inside split corners
//allow for a little oversize on the split line, total will be 2x this
SplitOffset=0.25; 
/* [Other] */
//-------------------------    Top Handle dims
IR=(4.8+0.3)/2; //rod / hole

TDFrame=2.5; //depth of end slot in frame
TL=82+2*TDFrame; //length of main handle
TR1=28/2; //width at centre
TR2=24/2; //at end
TWFrame=15.5; //width of steel frame

TSplitStep=2; 

// ------------------------------ Crank dimensions
CR1=20/2; //ball radius
CR2=15/2; //waist
CR3=19/2; //inner end


CL=CrankLength+2.5; 
CL2=14; //length from ball to waist
CSinkL=3; //countersink flange at the end
CSinkR=10/2; 
CSplitStep=1.5;
CInnerBevel=1; //width of the steps making up the inner bevel
CR4=11/2; //flat against crank arm
//---------------------------------------------------------------

module Crank() {
    $fn=50;
    difference() {
        translate([0,0,CR1]) 
            union() {
                sphere(CR1);
                cylinder(r1=CR1, r2=CR2, h=CL2);
                translate([0,0,CL2]) cylinder(r1=CR2, r2=CR3, h=CL-CL2-CR1-3*CInnerBevel);
                translate([0,0,CL-CR1-CInnerBevel*3]) cylinder(r=CR3, h=CInnerBevel);
                translate([0,0,CL-CR1-CInnerBevel*2]) cylinder(r1=CR3, r2=CR3*0.9, h=CInnerBevel);
                translate([0,0,CL-CR1-CInnerBevel]) cylinder(r1=CR3*0.9, r2=CR4, h=CInnerBevel);

            }//union
        cylinder(r=IR,h=CL+.01, $fn=20);
	//rivet cone shape hole at end
        translate([0,0,0]) cylinder(r=CSinkR, h=2, $fn=20);    
	translate([0,0,2]) cylinder(r1=CSinkR, r2=IR, h=CSinkL, $fn=20);
}//diff

}//mod
module SphericalCylinder(r1,r2,L) {
	scale([r2,r2,0.5*L/sqrt(1-(r1/r2)) ]) {
		intersection() {
			cube([2,2,2*sqrt(1-(r1/r2))],center=true);
			sphere(1,$fn=50);
		}
	}
  //cube([2*r1,r1/2,L*1.01],center=true); //recatngle that should just show at the end if it all works properly
} //mod

module Handle() {
	   difference() {
		SphericalCylinder(r1=TR2, r2=TR1, L=TL);	
		for(A=[0,180]) rotate([A,0,0]) 
			translate([0,0,TL/2 - TDFrame +0.01]) 
				union() {
					translate([0,-TWFrame/2,0]) 	cube([TR1*3,TWFrame,TDFrame]);
					cylinder(r=TWFrame/2,h=TDFrame);
				}//union
		cylinder(r=IR,h=TL, center=true, $fn=20);
	}//diff

}//mod



module Split(Gap=1.5,Offset=0) { //make the split slice, with rounded inside edge so printers corner rounding won't have an effect
    hull() 
    translate([Offset,0,0])
    for (dy=[-1,1]) 
        translate([SplitR,-dy*(IR+Gap-SplitR),0]) cylinder(r=SplitR,h=TL,center=true, $fn=20);
  translate([SplitR+TR1+0.5,0,0]) cube([2*(TR1+0.5),2*(IR+Gap),TL],center=true);
}//mod

//Handle();

//Split(Offset=0.2);

//------------Show complete parts
if (part=="All") {
   color("blue") translate([0,0,CL]) rotate([0,180,0])  translate([10,0,0]) Crank();
    color("red") translate([-40,0,0]) Handle();
}

//------------- Make Split Crank
translate([0,0,CL]) rotate([0,180,0]) 
if (part=="Crank"){
translate([10,0,0]) intersection() {
	Crank();
	Split(CSplitStep,SplitOffset);
};
translate([-10,0,0]) difference() {
	Crank();
	Split(CSplitStep,-SplitOffset);
};
}

//------------- Make Split Handle 
translate([0,0,TL/2])
if (part=="TopHandle"){
translate([0,30,-TDFrame]) intersection() {
	Handle();
	Split(TSplitStep,SplitOffset);
};
translate([-20,30,0]) difference() {
	Handle();
	Split(TSplitStep,-SplitOffset);
};
}