/* [Global] */

dia = 25;
holeDia = 4;
coneDia = 20;
coneHeight = 27;

translate([0,0,dia/4])
	difference(){
		sphere(dia/2,$fn=72);
		holes();
	}



module holes () {
	union(){
		translate([0,0,-dia/2])
			cylinder(h=coneHeight,r1=coneDia/2,r2=0,$fn=72);
		translate([-dia/2,-dia/2,-dia*5/4])
			cube(dia);
		translate([0,0,-dia])
			cylinder(r=holeDia/2,h=dia*2,$fn=36);
	}
}