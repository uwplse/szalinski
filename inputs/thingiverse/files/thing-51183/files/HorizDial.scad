//
// Horizontal Sundial
//	2/8/13 Initial Creation       -jkl
//  3/17/16 Revised slightly to not depend on "Customizer".    -jkl
// Reference: "Sundials: Their Theory and Construction"
//	by Andrew E. Waugh
// 	Publisher: Dover, 1973
//

include <Write.scad>


//CUSTOMIZER VARIABLES
// preview[view:south east, tilt:top]
// Custom String - Your Home or ?? - Max 21 Characters
myHome = "Portland, Oregon";

//Find your Latitude and Longitude at http://universimmedia.pagesperso-orange.fr/geo/loc.htm. Select your latitude range based on your latitude.
latitudeRange = 8; 	//["1 to 29 degrees North":7,"30 to 48 North":8,"49 to 57 North":9,"58 to 62 North":10,"63 to 66 North":11]

//Latitude in degrees and fraction of a degree
latitude = 45.55;
//Longitude in degrees and fraction of a degree. Mind the sign if it's negative!
// Omit trailing zeros.
longitude = -122.61;

//Find your time zone at http://www.timeanddate.com/library/abbreviations/timezones/. Mind the sign!
// This is the value in hours relative to GMT. For example, Portland is 8 hours later 
//    than GMT, so the value is -8. (That's for standard time; daylight saving is
//    an hour earlier, or -7 if I was making this for use in the summer.
timeZone = -8;
//////////////////////////////////////// Change nothing below this line!!! //////////////////////////////

endIndex = latitudeRange * 1;		// dummy
timeCorr = -longitude + (timeZone*15.0);

amChars = [" ","11", "10", "9", "8","7","6","5","4","3","2","1"];
pmChars = [" ","1", "2", "3","4","5","6","7","8","9","10","11"];
charOffset = [0,0,2,7,10,19,24,26,29,30,30,30,30];


module horizDial()
{
union(){
  difference()
  {
	union() {

		difference() {
			translate([0,20,0.01])cylinder(r=50, h=4, $fn=100);
		}
		translate([0,0,4]) rotate([90,0,90]) gnomon();
		for ( i = [0 : 6] )
		{
			translate([0,0,4]) rotate([0,0,atan(tan((i*15)+timeCorr)*sin(latitude))])
			if(i==0){
				aLine(gap=0);
			}
			else {
				aLine(gap=(45-charOffset[i]-1));
			}
			writecylinder(amChars[i],[0,0,0],radius=(65-charOffset[i]),height=4,h=5,t=2,face="top",middle=1,west=atan(tan((i*15)+timeCorr)*sin(latitude)));
			if(i<6){
				translate([1,1,4]) rotate([0,0,-atan(tan((i*15)-timeCorr)*sin(latitude))])
				if(i==0){
					aLine(gap=0);
				}
				else {
					aLine(gap=(45-charOffset[i]-3));
				}
				writecylinder(pmChars[i],[0,0,0],radius=(65-charOffset[i]),height=4,h=5,t=2,face="top",middle=1,west=-atan(tan((i*15)-timeCorr)*sin(latitude)));
			}
		}

		for ( i = [6 : endIndex] )
		{
			if(i>6){
				translate([0,0,4]) rotate([0,0,180+atan(tan((i*15)+timeCorr)*sin(latitude))])
				aLine(gap=(40-charOffset[i]-1));
				writecylinder(amChars[i],[0,0,0],radius=(60-charOffset[i]),height=4,h=5,t=2,face="top",middle=1,west=180+atan(tan((i*15)+timeCorr)*sin(latitude)));
			}
			translate([1,1,4]) rotate([0,0,180-atan(tan((i*15)-timeCorr)*sin(latitude))])
			aLine(gap=(40-charOffset[i]-1));
			writecylinder(pmChars[i],[0,0,0],radius=(60-charOffset[i]),height=4,h=5,t=2,face="top",middle=1,west=180-atan(tan((i*15)-timeCorr)*sin(latitude)));
		}
		//translate([125,20,4]) rotate([0,0,90]) aLine(len = 200); // for checking
	}
	difference()
	{
		translate([0,20,0])cylinder(r=150, h=6, $fn=100);
		translate([0,20,-1])cylinder(r=50, h=8, $fn=100);
	}
	
  }
	difference()
	{
		translate([0,20,0])cylinder(r=60, h=4, $fn=100);
		translate([0,20,-1])cylinder(r=50, h=8, $fn=100);
		translate([-40,60,-1])rotate([0,0,-45])cube([120,120,8]);
		translate([-48,-30,-1])rotate([0,0,45])cube([120,120,8]);
	}
	writecylinder(myHome,[-10,17,0],radius=60,height=4,h=5,t=2,face="top",middle=1,west=0,ccw=true);
  }
}

module gnomon()
{
	difference() {
		translate([0,0,0])cube([70,70,2]);
// does this work over the full range?
		rotate([0,0,latitude]) translate([0,0,-1]) cube([100,70,6]);
// what parameters?
		rotate([0,0,0]) translate([120,-20,-1])cylinder(r=80, h=4, $fn=100);
	
	}

}

module aLine(len = 60,gap=25)
{
	if (gap==0){
		translate([0,10,0])cube([1,len,1]);
	}
	else {
		translate([0,10,0])cube([1,gap,1]);
		translate([0,gap+20,0])cube([1,len,1]);
	}
}
// Print Stuff

horizDial();
//gnomon();
