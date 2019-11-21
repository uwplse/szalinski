/* [total] */
//Total height of the entire knob
height = 20; //[5:200]

//Quality/level of details
quality = 144; //[9:preview,144:stl export]

/* [handle] */
//The (big) radius of the knob's handle
radius = 22; //[0:200]

//Thicknes (of height) of the knob's handle
thickness = 6; //[1:100]

/* [info] */
info = "readme"; //[readme:...,licensed under,Creative Commons - Attribution - Share Alike,_,created by,Th.Buchmakowsky aka Bummi,_,Version 1.1,2018-03-22]
/* [Hidden] */

$fn=quality;

zAxisKnob(radius=radius,height=max(height,5),thick=min(thickness,height-4));

module zAxisKnob(radius=25,height=20,thick=6) {
	difference() {
		union() {
			linear_extrude(height=thick)handle2D(r1=radius/0.968,n=13);
			translate([0,0,thick-.0001])linear_extrude(height=4.0001,scale=8.228/radius)handle2D(r1=radius/0.968,n=13);
			translate([0,0,thick+3.9999])cylinder(r1=7.5+1,r2=7.5,h=height-thick-4);
		}
		translate([0,0,thick+4])threadEnder2ZAchse(h=height-thick-3);
		translate([0,0,height-0.9999])cylinder(r1=3.4,r=4.5,h=1);
	}
	module threadEnder2ZAchse(h=4.5) {
		linear_extrude(height=h,twist=-h*40,slices=h*20/4.5,convexity=10) intersection() {
			union() {
				circle(r=3.4,$fn=72);
				scale([1.7,6,1])circle(r=1,$fn=72);
				rotate(90,v=[0,0,1])scale([1.7,6,1])circle(r=1,$fn=72);
			}
			circle(r=4.5,$fn=72);
		}
	}
	module handle2D(r1=100,n=9,r2,b1,b2) {
		r2=r2?r2:r1*.8;
		b1=b1?b1:(r1-r2)/n*4;
		b2=b2?b2:(r1-r2)/n*20;
		offset(r=b1) offset(delta=-b1,chamfer=false) offset(r=-b2) offset(delta=b2,chamfer=true)
			polygon([ for(a=[0:2*n-1]) [cos(a*180/n)*(a%2==0?r1:r2),sin(a*180/n)*(a%2==0?r1:r2)]  ]);
	}
}

