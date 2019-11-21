echo ("Copyright 2017 Nevit Dilmen");
echo("optimized by webours");

//values to change
ball = 9; //radius of a ball
balls = 6; //number of balls
oth = 2; //outside thickness

//calculated values
radius= ((2*ball+1)/2)/sin((360/balls)/2);
radius_int = radius - ball - 1;
radius_ext = radius + ball + 1 + oth;

//Balls
for(i = [0 : 360/balls : 360]) {
	translate ([cos(i)*radius,sin(i)*radius,0])
		sphere (ball);    
}

//bearing
difference() {
	linear_extrude(ball*2+2+oth,center=true)
		circle(radius_ext);
	rotate_extrude()
		translate([radius,0,0])
			circle(ball+1);
	linear_extrude(ball*2+2*oth+1,center=true)
		difference() {
			circle(radius_ext - oth - ball/2);
			circle(radius_int + ball/2);
		}
}
