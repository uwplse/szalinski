$fn=100;

d=14.48;
height=3;
thick=1.5;

earThick=height;
rounding=2;
angle=35;

difference(){
	union(){
		rotate([0,0,angle]) translate([-d/2,0,0]) ear();
		rotate([0,0,-angle]) translate([-d/2,0,0]) ear();
	}
	translate([0,0,-height]) cylinder(r=d/2+thick/2,h=3*height);
}

scale([1,1,height/thick]) translate([0,0,thick/2])  ring();

module halfEar(){
	translate([0,0,rounding/2]) minkowski(){
		sphere(d=rounding);
		difference(){
			rotate([0,0,-25]) scale([1,0.3,1]) cylinder(r=10,h=earThick-rounding);
			translate([-50,0,-50]) cube([100,100,100]);
			translate([0,-50,-50]) cube([100,100,100]);
		}
	}
}

module ear(){
	halfEar();
	mirror([0,1,0]) halfEar();
}

module ring(){
	torus(r1=d/2+thick/2,r2=thick/2);
}

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	translate([r1, 0, 0])
	circle(r = r2);
}
