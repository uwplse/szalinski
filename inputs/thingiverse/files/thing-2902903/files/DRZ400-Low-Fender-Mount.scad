/*
TODO:
Radius Tab1 to cbody
*/

include <openscad-library/geometry.scad>;
include <MCAD/nuts_and_bolts.scad>

$fa=2; 
$fs=.1;

//body
id=57;
od=64.2;
t=(od-id)/2;
h=39;
bottomR=t;
bootOd=63.5;
bootH=10;
barbOd=66;
chamferW=3;
chamferH=4;

//tab1
tab1W1=19.6;
tab1W2=12;
tab1H1=22.7;
tab1H2=19.7;
tab1D1=7.5;
tab1D2=7;
tab1H3=5.5;
tab1D=tab1D1+tab1D2;
tab1ScrewId=6;
tab1NotW=10;
tab1ScrewY=tab1H1-9;

forksIW=135;
fenderOW=115;
mntW=(forksIW-fenderOW)/2;
mntL=60;
mntH=20;

difference(){
	union(){
		body();
		tab1();
		//fillet of tab1 to body: TODO needs a little work
		*translate([0,0,bottomR])
			linear_extrude(height=tab1W1)
				offset(r=-2) offset(r=2)
					projection(cut=true)
						translate([0,0,-bottomR]){
							body();
							tab1();
						}
		translate([id/2,0,bottomR])
			cube([mntW,mntL,mntH]);
		translate([mntW-t,0,bottomR])
			cylinder(d=od,h=mntH);
	};
	cylinder(d=id,h=h);
}

module body(){
	rotate_extrude()
		difference(){
			polygon([
				[0,0],
				[0,h],
				[barbOd/2-chamferW,h],
				[barbOd/2,h-chamferH],
				[bootOd/2,h-chamferH],
				[bootOd/2,h-chamferH-bootH],
				[od/2,h-chamferH-bootH],
				[od/2,0]
			]);
			translate([od/2,0])
				fillet(r=bottomR,a=90);
		}
}

module tab1(){
	rotate([0,-90,0])
		translate([bottomR,od/2,-tab1D]){
			difference(){
				union(){
					cube([tab1W1,tab1H1,tab1D1]);
					translate([(tab1W1-tab1W2)/2,0,tab1D1])
						cube([tab1W2,tab1H2,tab1D2]);
					translate([0,0,tab1D1])
						cube([tab1W1,tab1H3,tab1D2]);
					translate([0,-od/2,0])
						cube([tab1W1,od/2,tab1D]);
				}
				union(){
					translate([tab1W1/2,tab1ScrewY,0]){
						boltHole(size=6, length=30, tolerence=.1, proj=-1);
						nutHole(size=6, tolerence=.1, proj=-1);
					}
				}
			}
		}
}

