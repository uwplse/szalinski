
LEG_DEPTH = 33; //[10:60]
LEG_WIDTH = 31; //[10:60]
LEG_SLOPE = atan(9/53); //[0:0.5:30]
LEG_OVERLAP = 2; //[0:0.5:5]
//Distance from back of chair leg to wall
BUMP = 60; //[40:80]
//Height of bumper
LEG_HEIGHT = 20;// [40]


//Wall thickness of bumper
WALL2 = 2.4; // [1.2:5]
//Wall thickness, think wall around chair leg
WALL1 = 1.6;//[0.6:2.4]
//min Radius
MR = 1; 

/* [Hidden] */
e = 0.01;
echo(LEG_SLOPE=LEG_SLOPE);
$fn = 16;

//front strap for chair
intersection(){
	translate([0,0,LEG_HEIGHT/2])
	cube([LEG_WIDTH*3,LEG_WIDTH*3,LEG_HEIGHT],center=true);
	
	extraHeight = LEG_WIDTH*sin(LEG_SLOPE)*2;
rotate([0,-LEG_SLOPE,0]){
	translate([0,0,-extraHeight])
	linear_extrude(LEG_HEIGHT+extraHeight*2, convexity = 4)
	translate([0,-0.5*(LEG_WIDTH+WALL1)])
	difference(){
	offset(r=WALL1/2)
		translate([-LEG_DEPTH*0.5,0])
			square([LEG_DEPTH*1.5,LEG_WIDTH+WALL1]);
		
		translate([-LEG_DEPTH*0.5-WALL1/2-e,WALL1/2])
			square([LEG_DEPTH*1.5,LEG_WIDTH]);
	}
	
	translate([0,0,-LEG_OVERLAP*sin(LEG_SLOPE)])
	linear_extrude(LEG_HEIGHT+extraHeight, convexity = 2)
	translate([-LEG_WIDTH/2-WALL2+LEG_OVERLAP,0])
		legWidthCircle(-LEG_OVERLAP*2);

}//rotate
}//intersection

module legWidthCircle(gap=WALL2){
	difference(){
		circle(d=LEG_WIDTH+WALL2*2, $fn=64);
		circle(d=LEG_WIDTH, $fn=128);	
	}
	translate([gap/2,0])
	square([LEG_WIDTH-abs(gap),WALL2], center=true);
}

for(xo = [//-BUMP/2+LEG_OVERLAP/2,
	-BUMP+LEG_WIDTH/2+WALL2])
	linear_extrude(LEG_HEIGHT, convexity = 2)
		translate([xo,0])
			legWidthCircle(0);
