Inside_Radius=0.75; // [0.2:0.05:6.0]
Outside_Radius=1.25; // [1.2:0.05:10.5]  
Nozzle_Length=0.0; // [0.0:50.0]

/* [Hidden] */
$fn=128;

color("orange"){

// front side
difference(){
	cylinder(r=Outside_Radius,Nozzle_Length);
	translate([0,0,-0.1]) cylinder(r=Inside_Radius,Nozzle_Length+0.2);
}

// luer connection
difference(){
	//outside
	union(){
		translate([0,0,-5]) cylinder(r1=5.4/2,r2=Outside_Radius,h=5);
		translate([0,0,-11]) cylinder(r1=5.6/2,r2=5.4/2,h=6);
		translate([0,0,-11]) cylinder(r=7.5/2,h=1);
	}
	//inside
	translate([0,0,-11.1]) cylinder(r1=4.3/2,r2=4.0/2,h=6.1);
	translate([0,0,-5.1]) cylinder(r1=4.0/2,r2=Inside_Radius,h=5.2);
	//notches
	translate([5.6/2,-7.5/2,-11.1]) cube([1,7.5,1.2]);
	translate([-5.6/2-1,-7.5/2,-11.1]) cube([1,7.5,1.2]);
}

}