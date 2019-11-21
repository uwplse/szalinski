$fn = 100;

rf = 5.5;
hf = 8.5;
h1 = 2;
h2 = 10;
kol = 6;
rHex = 7.1/2;

difference(){
	union(){cylinder(h1,d = 11);
			cylinder(h2,d = 9);
	}
	cylinder(h2,d=4.2);
	translate([0, 0, 3])
   	cylinder(h2,d = 7.1);
}

intersection(){
	for (i = [0:kol]) {
		translate([sin(360*i/kol)*5, cos(360*i/kol)*5, 0 ])
		cylinder(h2, r=1.5);
	}

	rotate_extrude(convexity = 2)	{
		square([ rf, hf ]);
		translate([ 0, hf ])
		intersection() {
			square([ rf, rf ]);
			scale([ 1, 0.5 ]) circle(rf);
		}
	
	}
}

translate([0,0,3]){
	difference(){
		cylinder(3,d=rHex*2);
		linear_extrude(4,center = false,2,twist = 0,slices = 20)
			polygon(points=[[sin(360*1/6)*rHex, cos(360*1/6)*rHex],[sin(360*2/6)*rHex, cos(360*2/6)*rHex],[sin(360*3/6)*rHex, cos(360*3/6)*rHex],[sin(360*4/6)*rHex, cos(360*4/6)*rHex],[sin(360*5/6)*rHex, cos(360*5/6)*rHex],[sin(360*6/6)*rHex, cos(360*6/6)*rHex]]);}
}