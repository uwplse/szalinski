
/* [Left Arm]*/
// arm length
leftLength=8;
// arm width
leftWidth=8;
// from trunk to arm
leftGap=3;
// quadrant of quarter circle
leftQuad=2;
// up from the bottom
leftUp=10;

/*[Trunk]*/
// Trunk Length excluding Radius of the top
trunkL=40;
// Radius of the top
trunkW=10;
// thickness of cactus
trunkT=5;

/*[Right Arm]*/
// arm length
rightLength=8;
// arm width
rightWidth=7;
// from trunk to arm
rightGap=2;
// quadrant of quarter circle
rightQuad=1;
// up from the bottom
rightUp=15;

cactus();//like thing:1052477 but customizable

module cactus(){
	linear_extrude(height=trunkT){
		translate([-rightUp, trunkW/2,0])
		arm(l=rightLength, w=rightWidth, g=rightGap, q=rightQuad);
		translate([-leftUp, -trunkW/2,0])
		arm(l=leftLength, w=leftWidth, g=leftGap, q=leftQuad);
		
		translate([-trunkL, -trunkW/2]){
			square([trunkL, trunkW]);
			translate([0, trunkW/2])
			circle(d=trunkW);
		}
	}
}

module arm(l=12, w=5, g=2, q=1, t=8){
	q1= q==1 ? 0:-1;
	q2= q==2 ? -1:1;//q=quadrand 1 or 2

	translate([-l-w, q2*w/2+q2*g])
	circle(r=w/2);
	
	translate([-l-w, q1*w+(q2*g)])//[-l-w, q1*w+(q2*g)]
	square([l, w]);
	
	translate([-w, g*q2])
	qCircle(r=w, q=q);
	
	translate([-w,g*q1])
	square([w, g]);
}

module qCircle(r=10, q=1){//q=quadrant 1, 2, 3 or 4
	rotate(-(q-1)*90)
	difference(){
		circle(r=r);
		translate([-r-1,-r-1])
		square([r+1, r*2+2]);
		translate([0,-r-1])
		square([r+2,r+1]);
	}
}
