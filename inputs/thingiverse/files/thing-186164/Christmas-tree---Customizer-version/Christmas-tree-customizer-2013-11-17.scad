//Number of "twigs"
number=8; //[2:20]

//Tree diameter at base [mm]
base_diameter=40; //[20:200]

//Tree height [mm]
height=50;	//[10:200]

//Wall thickness
wall=0.5; //[0.25:thin (0.25 mm),0.5:standard (0.5 mm),1:thick (1 mm)]

//Twist angle [°] (>180 will be hard to print)
twist=90; //[0:360]

//Turning direction
direction=-1; //[-1:counterclockwise,1:clockwise]

//Add hanger
hanger=2; //[0:none,1:make hole in top,2:add ring on top]

baseplate=1; //[1:small,2:full circle]


difference () {
	tree(number=number,radius=base_diameter/2,height=height,wall=wall,twist=twist,dir=direction);
	
	if (hanger==1) {
		for (i=[0,90]) {
			translate ([0,0,height*0.94])
			rotate ([90,0,i])
			scale ([1,2,1])
			cylinder (r=radius*0.025,h=10,$fn=25,center=true);
		}
	}
}

if (hanger==2) {
	translate([0,0,height+2])
	rotate([90,0,0])
	scale([1,1,1])
	rotate_extrude(convexity = 10, $fn = 100)
	translate([3, 0, 0])
	circle(r = 1, $fn = 100);	
}



module tree (number=6,radius=30,height=100,wall=0.5,twist=-90,direction=direction) {

points=[[wall*0.5,0],[wall*0.5,radius-1],[wall*0.4,radius-0.6],[wall*0.2,radius],[0,radius],[wall*-0.2,radius],[wall*-0.4,radius-0.6],[wall*-0.5,radius-1],[wall*-0.5,0]];

intersection () {

for (i=[1:number]) {
	rotate ([0,0,i*360/number])
	linear_extrude($fn=100,height = height,  convexity = 10, twist = twist*direction)
	polygon( points);
}
	cylinder (r1=radius,r2=2,h=height);
}

//Baseplate
	if (baseplate==1) {
		for (i=[1:number]) {
			rotate ([0,0,i*360/number])
			linear_extrude($fn=100,height = 0.5,  convexity = 10)
			scale ([5,1,1])
			polygon(points);
		}
	}

	if (baseplate==2) {
		cylinder (r=radius,height=0.5,$fn=100);
	}

}



