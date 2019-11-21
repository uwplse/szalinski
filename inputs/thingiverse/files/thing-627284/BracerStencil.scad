WristArc=160;
ElbowArc=260;
Length=180;


//hidden---------------
Wrist2orig=(WristArc*Length)/(ElbowArc-Length);
Elbow2orig=Wrist2orig+Length;
Angle=(WristArc/Wrist2orig)*(180/3.14159);

difference(){
union(){
difference(){
cylinder(r=Elbow2orig,h=2,center=true, $fn=50);
cylinder(r=Wrist2orig,h=3,center=true, $fn=50);
}
}
	
union(){
	translate([Elbow2orig,0,0])
		cube([Elbow2orig*2,Elbow2orig*2+5,4],center=true);


	rotate([0,0,Angle])
		translate([-Elbow2orig,0,0])
			cube([Elbow2orig*2,Elbow2orig*2+5,5],center=true);
}
}