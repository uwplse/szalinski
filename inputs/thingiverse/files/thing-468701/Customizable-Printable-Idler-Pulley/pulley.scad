//variables (mm)
	idlerID = 30; //Inner Dia
	idlerOD = 40; //Outer Dia
	beltwidth= 2.5; //Belt Width
	$fn=120; //faceting

//these are the lips that hold the belt on
	lipheight = 5; //Lip Height
	lipthickness = 1.25; //Lip Thickness
	topangle = 60; //The angle the top lip overhang makes. You can increase this to lower the idler profile.

//construction
	difference(){
	union(){
		cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		cylinder(r=idlerOD/2, h = lipthickness*2+beltwidth+lipheight*cos(topangle));
		translate([0,0,lipthickness+beltwidth+lipheight*cos(topangle)])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,beltwidth+lipthickness])cylinder(r1=idlerOD/2, r2=lipheight+idlerOD/2, h=lipheight*cos(topangle));
		}
		translate([0,0,-1])cylinder(r=idlerID/2, h=lipthickness*2+beltwidth+lipheight*2);
}