include <write.scad>
/*[Active Views]*/
printerFriendlyView=false;//[true false]
assembledUnitView=true;//[true false]
assembledUnitDepressedButtonView=true;//[true false]

/*[Button]*/
buttonCharictor="X";
//In some use cases the button may need to be rotate for user recognition
buttonCharictorRotation=90;
buttonCharictorDepth=.5;
//This is the amount that the user must depress the button to get full actuation
buttonThrow=5;
//this determines the pad volume of the button
buttonDiameter=20;
//
buttonExtraZHeight=1;
buttonEdgeBevelRadius=3;
buttonEdgeBevelSmoothingFactor=5;
//This is a variable for adding strength/reducing volume
leverThickness=2;
fulcrumDiameter=2;
fulcrumLatchDepth=1;

/*[Case]*/
topThickness=1;
wallThickness=1;
minimumSpacerThickness=.3;
wireEscapeHoleDiameter=7;
//a fudge factor to prevent the button lever from binding against the wall
gap=.4;
printGap=10;

/* [Switch parameters]*/
//This is the diameter mounting treads for the switch
switchTrheadDiameter=10.2;//defaults values are for digikey part # 561PB-ND  I chose it due to its cost and easy to assemble
//this defines the enclosed volume of the switch. Note the wire exit is build into the X Dimention
switchXdim=30;
switchYdim=15;
switchZdim=8;
switchThreadLength=10.5;
switchMaxThrowDistance=5;
switchButtonDiameter=5.5;
switchNutZHeight=4;
switchNutDiameter=13;
switchXCenter=6;
switchYCetner=7.5;
/*[Lever Parameters]*/
//When I think about how best to handle these they will be automatically calculated, but for now i am leaving these user defined.
leverLength=40;
leverButtonOffset=30;
leverSwitchOffset=30;

/*Calculation Block*/
maxAngleOfRotation=atan(switchMaxThrowDistance/leverSwitchOffset);
expationDueToSkewing=(leverSwitchOffset+buttonDiameter)/cos(maxAngleOfRotation)-(leverSwitchOffset+buttonDiameter);
fulcrumCenterHeight=(switchThreadLength+switchZdim+switchMaxThrowDistance+fulcrumDiameter/2);
innerWallZ=switchThreadLength+switchZdim-switchNutZHeight;
innerWallX=leverLength+fulcrumDiameter/2+wallThickness*2;
innerWallY=buttonDiameter+fulcrumLatchDepth*2;
leverX=buttonDiameter;
fulcrumLength=2*fulcrumLatchDepth+buttonDiameter;
spacerThickness=innerWallZ-topThickness-switchZdim;
numberOfSpacers=((spacerThickness-spacerThickness%minimumSpacerThickness)/minimumSpacerThickness);
outerCaseZ=fulcrumCenterHeight+fulcrumDiameter/2+topThickness;
outerCaseX=innerWallX+2*wallThickness;
outerCaseY=innerWallY+2*wallThickness;

/* Parts Modules block*/
module switch(){
union(){
cylinder(r=switchButtonDiameter/2,h=(switchThreadLength+switchZdim+switchMaxThrowDistance));
cylinder(r=switchTrheadDiameter/2,h=(switchThreadLength+switchZdim));
translate([-switchXCenter,-switchYCetner,0])cube([switchXdim,switchYdim,switchZdim]);
translate([0,0,innerWallZ])cylinder(r=switchNutDiameter/2,h=switchNutZHeight);
}
}

module button(){
	translate([leverButtonOffset,0,-fulcrumDiameter/2]) difference(){
		union(){
			difference(){
				hull(){
					for( i=[1:buttonEdgeBevelSmoothingFactor]){
						cylinder(r=buttonDiameter/2-buttonEdgeBevelRadius+buttonEdgeBevelRadius*2*sin(i*90/buttonEdgeBevelSmoothingFactor)/2,h=(leverThickness+topThickness+buttonThrow+buttonExtraZHeight-buttonEdgeBevelRadius+buttonEdgeBevelRadius*cos(i*90/buttonEdgeBevelSmoothingFactor)));
					}
				}
		translate([0,0,leverThickness+topThickness+buttonThrow+buttonExtraZHeight-buttonCharictorDepth/2])rotate([0,0,buttonCharictorRotation])write(buttonCharictor,t=buttonCharictorDepth,h=buttonDiameter/2,center=true);
			}
			translate([-leverButtonOffset,-buttonDiameter/2,0])cube([leverLength,buttonDiameter,leverThickness]);
			translate([-leverButtonOffset,-buttonDiameter/2-fulcrumLatchDepth,leverThickness/2])rotate([-90,0,0])cylinder(r=fulcrumDiameter/2,h=fulcrumLength);
		}
	translate([leverSwitchOffset-leverButtonOffset,0,-switchNutZHeight])rotate([0,-maxAngleOfRotation,0])cylinder(r=1.1*switchNutDiameter/2,h=switchNutZHeight);
	}
}
module outerCase(){
	difference(){
		translate([-2*wallThickness,-outerCaseY/2,0])cube([outerCaseX,outerCaseY,outerCaseZ]);
		translate([-wallThickness,-innerWallY/2,0])cube([innerWallX,innerWallY,outerCaseZ-topThickness]);
		translate([-innerWallX/2,0])rotate([90,0,90])cylinder(r=wireEscapeHoleDiameter/2,innerWallX+innerWallY);
		translate([leverButtonOffset,0,outerCaseZ-topThickness-gap])cylinder(r=2*expationDueToSkewing+buttonDiameter/2,h=(topThickness*4));
	}
}
module casemiddle(){
	difference(){
		union(){
			difference(){
				hull(){
					translate([0,-fulcrumLength/2,fulcrumCenterHeight])rotate([-90,0,0])cylinder(r=fulcrumDiameter/2,h=fulcrumLength);
					translate([0,-fulcrumLength/2,fulcrumDiameter/2])rotate([-90,0,0])cylinder(r=fulcrumDiameter/2,h=fulcrumLength);
					translate([leverSwitchOffset,-(fulcrumLength)/2,fulcrumDiameter/2])rotate([-90,0,0])cylinder(r=fulcrumDiameter/2,h=fulcrumLength);
					translate([-fulcrumDiameter/2,-innerWallY/2,0]) cube([fulcrumDiameter,innerWallY,innerWallZ]);
				}
				translate([0,-(fulcrumLength),fulcrumCenterHeight])rotate([-90,0,0])cylinder(r=1.10*fulcrumDiameter/2,h=2*fulcrumLength);
				rotate([0,maxAngleOfRotation,0])translate([-leverLength,-buttonDiameter/2,fulcrumCenterHeight-1*leverThickness])cube([2*leverLength,buttonDiameter,4*leverThickness]);
			}
			translate([-fulcrumDiameter/2,-innerWallY/2,0]) cube([innerWallX,,innerWallY,innerWallZ]);
		}
	translate([-fulcrumDiameter/2+wallThickness,-innerWallY,0])cube([innerWallX-2*wallThickness,2*innerWallY,innerWallZ-topThickness]);
	translate([leverSwitchOffset,0,0])cylinder(r=switchTrheadDiameter/2,h=(gap+innerWallZ*2));
	translate([-innerWallX/2,0])rotate([90,0,90])cylinder(r=wireEscapeHoleDiameter/2,innerWallX+innerWallY);
	}
}
module spacerStackForAssemblyCheck()
{
	translate([leverSwitchOffset,0,innerWallZ-spacerThickness-topThickness])cylinder(r=switchNutDiameter/2,h=(spacerThickness));
}
module spacersForPrint(){
//I need to think about how to do this whithout a while loop...
	difference() {
		cylinder(r=switchNutDiameter/2,h=(spacerThickness));
	translate([0,0,-spacerThickness])cylinder(r=gap/2+switchTrheadDiameter/2,h=(spacerThickness*3));
	}
}
/*Assembly/ print orentation block*/
module printerFriendly(){
translate([0,0,outerCaseZ])rotate([180,0,0])outerCase();
translate([0,leverX /2+outerCaseY/2+printGap,fulcrumDiameter/2])button();
translate([0, -outerCaseY/2-printGap,innerWallY/2])rotate([90,0,0])casemiddle();
//spacers need to be added
translate([(-switchNutDiameter/2-printGap),0,0])spacersForPrint();
}
module assembledUnit()
{
casemiddle();
translate([0,0,-(-fulcrumDiameter/2-(switchThreadLength+switchZdim+switchMaxThrowDistance)-fulcrumDiameter/2)-fulcrumDiameter/2])button();
translate([leverSwitchOffset,0,0])rotate([0,0,180])switch();
spacerStackForAssemblyCheck();
outerCase();
}
module assembledUnitDepressedButton()
{
casemiddle();
translate([leverSwitchOffset,0,0])rotate([0,0,180])switch();
translate([0,0,-(-fulcrumDiameter/2-(switchThreadLength+switchZdim+switchMaxThrowDistance)-fulcrumDiameter/2)-fulcrumDiameter/2])rotate([0,maxAngleOfRotation,0])button();
spacerStackForAssemblyCheck();
outerCase();
}

/*Scratch block/ display block*/

;
if( printerFriendlyView){
printerFriendly();
}
if( assembledUnitView){
translate([-outerCaseX-printGap,-outerCaseY,0])assembledUnit();
}
if( assembledUnitDepressedButtonView){
translate([-outerCaseX-printGap,outerCaseY,0])assembledUnitDepressedButton();
}