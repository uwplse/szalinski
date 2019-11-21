//Drain Diameter (bathtub 38, bathroom sink 28.5)
diameter=38; //
// //Bathtub (mine was 38mm)
// //Sink    (mine was 28.5mm)
scale(diameter/36.25,[1,1,1]) //bathtub 38

//_______________________________________
//original design=36.25mm
// To calculate the scale..
// NewScale=DiameterRequired/36.25
//_______________________________________

difference(){	
	union(){
		intersection(){
		cylinder(r1=35/2,r2=37/2,h=10,$fn=50);
		translate([0,0,12])
		sphere(19,$fn=50);
		}
		translate([0,0,10])
		cylinder(r1=37/2,r2=39/2,h=1.5,$fn=50);	
	}
	translate([0,0,20])
	sphere(35.5/2,$fn=100);
	//translate([0,0,3])
	//cylinder(r=34.5/2,h=11,$fn=25);
	for (r=[0:40:359]){
		rotate(r)
	difference(){
	hull(){
			translate([5,0,-8])
			rotate([0,90,0])
			cylinder(r1=.9,r2=3.75,h=28/2,$fn=16);
			translate([5,0,5])
			rotate([0,90,0])
			cylinder(r1=.9,r2=6.75,h=28/2,$fn=16);
		}
		translate([0,0,10])
		cylinder(r1=37/2,r2=39/2,h=1.5,$fn=50);
	}
	}

	cylinder(r=3.5,h=10,center=true,$fn=16);
	
}
