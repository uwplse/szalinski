// based on thing 5620  - in public domain

//Diameter screw hole in middle (mm)
innerD = 6; // [0:10]
//Diameter of the pulley (mm)
pulleyD = 80; //[10:200]
//Width of the pulley belt (mm)
beltwidth= 3; //[1:6]
//facets on the pulley
facets = 60; //[10:100]

//height lips that hold the belt on (added to pullyD) (mm)
lipheight = 3; //[1:10]
//thickness of the upper lip (mm)
lipthickness = 1; //[0:10]
//Angle the top lip overhang makes (increase to lower the profile)
topangle = 45; 
//number of holes in the section
holenr = 6; //[0:10]
//gap size to avoid holes interconnecting (increase on interconnect)
gap = 5; //[0:20]
//second row of holes or not
secondholes = "True";  //[True, False]

function pi()=3.14159265358979323846;

$fn=facets; //faceting

//construction
translate([0,0,0])
	difference(){
	union(){
		cylinder(r=lipheight+pulleyD/2, h=lipthickness);
		cylinder(r=pulleyD/2, h = lipthickness*2+beltwidth+lipheight*cos(topangle));
		translate([0,0,lipthickness*2+beltwidth+lipheight*cos(topangle)])cylinder(r=lipheight+pulleyD/2, h=lipthickness);
		translate([0,0,beltwidth+lipthickness*2])cylinder(r1=pulleyD/2, r2=lipheight+pulleyD/2, h=lipheight*cos(topangle));
		}
		translate([0,0,-1])cylinder(r=innerD/2, h=lipthickness*2+beltwidth+lipheight*2);
   	holes();
}

widthhole=2*pi()*((pulleyD/2-innerD/2)/2-holenr/2)/(holenr+1);
lengthhole=(pulleyD-innerD)/2-gap;

module holes(){
	for (i=[1:holenr]) {
		rotate([0,0,i*360/holenr])
		translate([lengthhole/2+innerD/2+gap/2,0,-1]) scale([lengthhole/2,widthhole/2,1]) 
			cylinder(r=1, h=2*lipthickness+beltwidth+lipheight*4);
        if (secondholes == "True") {
            rotate([0,0,i*360/holenr+360/holenr/2])
            translate([3*lengthhole/4+innerD/2+gap/2,0,-1]) scale([lengthhole/4,widthhole/3,1]) 
                cylinder(r=1, h=2*lipthickness+beltwidth+lipheight*4);
        }
	}
}