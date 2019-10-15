/*
Customizable Kitchen Drip Tray
<<Dedalo>>


This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/




//Customizable Kitchen Drip Tray
include <MCAD/boxes.scad>
/* [Drainer Dimensions] */
//Width
Width = 150;

//Drainer
DrainerWidth=10;

//Quantity of Drainers
Qtty = 24;


/* [Water deposit] */
// Width of water deposit (0= no deposit, must be larger than 2*DrainerWidth)
WDSize=20;

/* [Hidden] */
//Width
Length=DrainerWidth*(Qtty+1);

//Height
Height=15;
//Floor thickness
minthickness=2;


radius = DrainerWidth;

dividerCount = Length/DrainerWidth;

drainerLength = WDSize?Width - 1.5*DrainerWidth - WDSize : Width - DrainerWidth;

angle = atan((Height-(minthickness*2))/(Width-DrainerWidth));
echo("Angle:",angle);

body();

//roundedStick([DrainerWidth,drainerLength,Height], radius/2, 1, $fn=36);
//deposit();

module roundedStick(size, r, sidesonly)
{
  if (sidesonly) {
	y = (r-size[1])/2;
	translate([0,r/2,0])union(){
		cube(size - [2*r,0,0], true);
		cube(size - [0,r,0], true);
		for (x = [r-size[0]/2, -r+size[0]/2]) {
		  translate([x,y,0]) cylinder(r=r, h=size[2], center=true);
		}
	}
  }
}


module deposit(){
	rotate([180,0,0])union(){
		depositSize=[Length-(DrainerWidth*2),WDSize,Height];
		roundedBox(depositSize,radius,1, $fn=36);
		translate([0,radius/2,0])cube(depositSize - [0,radius,0], true);
	}
}


module drainer(){
	rotate([-angle,0,0])translate([0,-drainerLength/2,(Height)/2])roundedStick([DrainerWidth,drainerLength,Height], radius/2, 1, $fn=36);
}

module body() {
	echo("Number of dividers:",dividerCount);
	difference() {
		// base
		roundedBox([Length,Width,Height], radius, 1, $fn=36);
		// drainers
		for (sep=[1:dividerCount/2]) {
			if(WDSize){
				translate([sep*DrainerWidth*2-Length/2-DrainerWidth/2,(drainerLength-DrainerWidth)/2,minthickness-Height/2])drainer();
			}else{
				translate([sep*DrainerWidth*2-Length/2-DrainerWidth/2,(drainerLength+DrainerWidth)/2,minthickness-Height/2])drainer();
			}
		}
		
		if(WDSize){
			translate([0,(Width-WDSize-DrainerWidth)/2,minthickness])deposit();
		}
	}
	
}


