handleL=50;
handleW=20;
handleH=4;
spadeL=20;
spadeW=15;
spadeH=3;
tineW=2;
tineAngle=25;
keyringT=2;

difference(){
union(){
difference(){

	cube([spadeL,spadeW,spadeH]);
	//translate([0,spadeW/2,-1])
	//	cylinder(r=spadeW/2-tineW,h=spadeH+2,$fn=50);
	rotate([0,-tineAngle,0])
		translate([0,-1,0])
			cube([spadeL,spadeW+2,spadeH*2]);
	rotate([0,90-tineAngle,0])
	translate([-spadeW/4,spadeW/2,-1])
		cylinder(r=spadeW/2-tineW,h=spadeL*2,$fn=50);
}
translate([spadeL-0.1,(spadeW-handleW)/2,0]){
	cube([handleL,handleW,handleH]);
	translate([handleL,handleW/2,0])
		cylinder(r=handleW/2,h=handleH,$fn=50);
}
}
translate([spadeL+handleL,handleW/2-(handleW-spadeW)/2,-1])
	cylinder(r=handleW/2-keyringT,h=handleH+2,$fn=50);
}
	



