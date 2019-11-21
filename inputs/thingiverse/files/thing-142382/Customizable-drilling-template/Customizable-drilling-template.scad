/*
 * Author:  Marcelo Costa Jr.
 * License: Creative Commons Attribution-ShareAlike 3.0 Unported License
 *          see http://creativecommons.org/licenses/by-sa/3.0/
 * URL:     http://www.thingiverse.com/thing:142382
 */

// MakerBot customizer settings:
// preview[view:south east, tilt:top diagonal]

/*
 * parameters
 */

/* [parameters] */
// spacing from edge of table on the X axes (mm)
	xEsp = 12.5; 
// spacing from edge of table on the Y axes (mm)
	yEsp = 12.5; 
// dimensions of leg on the X axes (mm)
	xLeg = 36;
// dimensions of leg on the Y axes (mm)	
	yLeg = 50;
// diameter of drilling hole (mm)
	hDia = 3;// [3:12]
	
/*[hidden]*/
	hRad = hDia/2;
// a little trigonometry
	alpha = atan2(yLeg,xLeg);
	dY = (hRad+5)/cos(alpha);
	dX = (hRad+5)/sin(alpha);

// quality of the circles
$fn=60;

// edge spacer
module spacer() {
	difference() {
		// full volume
		cube([xEsp+xLeg+2,yEsp+yLeg+2,8]);
		// subtration (leg)
		translate([5,5,-1])
			cube([xLeg-5,yLeg-5,10]);
	}
}

// transversal support of drill guide
module transversal() {
	difference (){
		translate([0,0,0])
			linear_extrude(height = 8, center = false, convexity = 10, twist = 0)
				polygon(points = [[0,0],[0,yLeg],[xLeg,0]]);
	}
}
// drill guide
module drill() {
	translate([xLeg/2,yLeg/2,0])
		cylinder(h=8, r=hDia);
}

//	cuts 
module cutUpDow(){
	// subtration (downer cut)
	translate([-1,-1,-1])
		cube([xEsp+xLeg+1,yEsp+yLeg+1,4]);
	// 2nd subtration (upper cut)
	translate([-1,-1,3+2])
		cube([xEsp+xLeg+1,yEsp+yLeg+1,4]); 

}
module cutSlant() {
	translate([0,0,0])
		linear_extrude(height = 10, center = false, convexity = 10, twist = 0)
			polygon(points = [[-1,-1],[0,yLeg-dY],[xLeg-dX,0]]);
}
module cutHole() {
	translate([xLeg/2,yLeg/2,-1])
		cylinder(h=10, r=hDia/2);
}

// The actual sequence of actions
translate([-(xLeg+xEsp)/2,-(yLeg+yEsp)/2,0])
	difference(){
		union(){
			spacer();
			transversal();
			drill();
		}
		cutHole();
		cutUpDow();
		cutSlant();
	}
