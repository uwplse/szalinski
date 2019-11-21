// select set number between 0 and 6 
//	0=0|7,1|7,2|7,3|7,4|7,5|7,6|7,7|7 
//	1=0|6,1|6,2|6,3|6,4|6,5|6,6|6,0|0
//	2=0|5,1|5,2|5,3|5,4|5,5|5,0|1,1|1 
//	3=0|4,1|4,2|4,3|4,4|4,2|2,2|1,2|0 
//	4=0|3,1|3,2|3,3|3,8|8,8|9,9|9,m|m
//	5=0|8,1|8,2|8,3|8,4|8,5|8,6|8,7|8
//	6=0|9,1|9,2|9,3|9,4|9,5|9,6|9,7|9

setDotSize=2.5;
setDotSpace=6;
setThickness=4;
plateNumber=4; // [0:6]

set(plateNumber,setDotSize,setDotSpace,setThickness);


module makerLogo() {
	translate([0,-4,-0.99])union() {
		cylinder(1,1,1,$fn=36);
		translate([4,0,0])cylinder(1,1,1,$fn=36);
		translate([-4,0,0])cylinder(1,1,1,$fn=36);
		difference() {
			union() {
				translate([3,7,0])cylinder(1,2,2,$fn=36);
				translate([-3,7,0])cylinder(1,2,2,$fn=36);
			}
			translate([-3,5,-0.1])cube([6,2,1.2]);
		}
		translate([-1,0,0])cube([2,8,1]);
		translate([-5,0,0])cube([2,7,1]);
		translate([3,0,0])cube([2,7,1]);
		translate([-3,7,0])cube([6,2,1]);
	}
}
module drawDot(x,y,dotSize,dotSpace) {
	translate([x*dotSpace,y*dotSpace,0]) sphere(dotSize,$fn=20);
}
module dots(numbDots,dotSize,dotSpace) {
	if ((numbDots>=1)&&(numbDots<=9)) {
		if ((numbDots==1)||(numbDots==3)||(numbDots==5)||(numbDots==7)||(numbDots==9)) {
			drawDot(0,0,dotSize,dotSpace);
		}
		if (numbDots>1) {
			drawDot(1,1,dotSize,dotSpace);
			drawDot(-1,-1,dotSize,dotSpace);
		}
		if (numbDots>=4) {
			drawDot(-1,1,dotSize,dotSpace);
			drawDot(1,-1,dotSize,dotSpace);
		}
		if (numbDots>=6) {
			drawDot(1,0,dotSize,dotSpace);
			drawDot(-1,0,dotSize,dotSpace);
		}
		if (numbDots>=8) {
			drawDot(0,1,dotSize,dotSpace);
			drawDot(0,-1,dotSize,dotSpace);
		}
	}
	if (numbDots==-1) {
		makerLogo();
	}
}
module domino(numDots1,numDots2,dotSize,dotSpace,thickness) {
	difference() {
		roundedBox([dotSpace*3.5,dotSpace*8,thickness],dotSize/2,true);
		translate([0,dotSpace*2,thickness/2]) dots(numDots1,dotSize,dotSpace);
		translate([0,0-dotSpace*2,thickness/2])dots(numDots2,dotSize,dotSpace);
		translate([0,0,thickness/2])cube([dotSpace*3,dotSize/2,dotSize/2],center=true);
	}
}

module set(setIndex,dotSize,dotSpace,thickness) {
	if (setIndex<4) {
		translate([dotSpace*-6,dotSpace*-4.25,thickness/2])for(i=[0:7-setIndex]) {
			translate([(i%4)*dotSpace*4,floor(i/4)*dotSpace*8.5,0])domino(i,7-setIndex,dotSize,dotSpace,thickness);
		}
	}
	if ((setIndex>0)&&(setIndex<5)) {
		translate([dotSpace*-6,dotSpace*-4.25,thickness/2])for(i=[0:setIndex-1]) {
			translate([((7-i)%4)*dotSpace*4,floor((7-i)/4)*dotSpace*8.5,0])domino(i,setIndex-1,dotSize,dotSpace,thickness);
		}
	}
	if (setIndex==4) {
		translate([dotSpace*-6,dotSpace*-4.25,thickness/2])for(i=[0:7]) {
			translate([0			,0,0]) domino(8,8,dotSize,dotSpace,thickness);
			translate([dotSpace*4	,0,0])	domino(8,9,dotSize,dotSpace,thickness);
			translate([dotSpace*8	,0,0])	domino(9,9,dotSize,dotSpace,thickness);
			translate([dotSpace*12	,0,0])	domino(-1,-1,dotSize,dotSpace,thickness);
		}
	}
	if (setIndex>=5) {
		translate([dotSpace*-6,dotSpace*-4.25,thickness/2])for(i=[0:7]) {
			translate([((7-i)%4)*dotSpace*4,floor((7-i)/4)*dotSpace*8.5,0])domino(i,setIndex+3,dotSize,dotSpace,thickness);
		}
	}
}


// Library: boxes.scad
// Version: 1.0
// Author: Marius Kintel
// Copyright: 2010
// License: 2-clause BSD License (http://opensource.org/licenses/BSD-2-Clause)

// roundedBox([width, height, depth], float radius, bool sidesonly);

// EXAMPLE USAGE:
// roundedBox([20, 30, 40], 5, true);

// size is a vector [w, h, d]
module roundedBox(size, radius, sidesonly)
{
  rot = [ [0,0,0], [90,0,90], [90,90,0] ];
  if (sidesonly) {
    cube(size - [2*radius,0,0], true);
    cube(size - [0,2*radius,0], true);
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2]) {
      translate([x,y,0]) cylinder(r=radius, h=size[2], center=true,$fn=20);
    }
  }
  else {
    cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
    cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

    for (axis = [0:2]) {
      for (x = [radius-size[axis]/2, -radius+size[axis]/2],
             y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
        rotate(rot[axis])
          translate([x,y,0])
          cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true,$fn=20);
      }
    }
    for (x = [radius-size[0]/2, -radius+size[0]/2],
           y = [radius-size[1]/2, -radius+size[1]/2],
           z = [radius-size[2]/2, -radius+size[2]/2]) {
      translate([x,y,z]) sphere(radius,$fn=20);
    }
  }
}
