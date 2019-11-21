$fn = 30;
d = 10;
//d1 = 19.33;
//d2 = 15.8;
d1 = 20;
d2 = 10;
wall = 1;
h = max(d1,d2)+2*wall;
bolt = 3;
lock = 2.5*bolt;
nut = 6.3;
pitch = (d1+d2)/2+wall/2;
nothing = 0.01;


difference(){
	union(){
		union(){
	//		cylinderRounded(d=d,h=h,wall=wall);
	//		translate([-d/2-wall,d,d/2+wall]) rotate([0,90,0]) cylinderRounded(d=d,h=h,wall=wall);

			//cylinders
			cylinderRounded(d=d1,h=h+lock,wall=wall);
			translate([-d1/2-wall,pitch,d2/2+wall]) rotate([0,90,0]) cylinderRounded(d=d2,h=h+lock,wall=wall);

		//cylinder holder
		translate([0,-3*wall+pitch-d2/2,0]) roundedCube([d1/2+lock+wall,wall,h+lock],wall/2);
		translate([-d1/2-wall,pitch+wall/2,d1/2+wall]) roundedCube([h+lock,wall,d1/2+lock+wall],wall/2);

		}
	}
	
	//tube holes
	cylinderHole(d=d1,h=h+lock,wall=wall);
	translate([-d1/2-wall,pitch,d2/2+wall]) rotate([0,90,0]) cylinderHole(d=d2,h=h+lock,wall=wall);

	//clearance
	translate([-nothing,-2*wall+pitch-d2/2,-nothing]) cube([d1/2+lock+wall+2*nothing,wall,h+lock+2*nothing]);
	translate([-d1/2-wall-nothing,pitch-wall/2,d2/2+wall+nothing]) cube([h+lock+2*nothing,wall,d1/2+lock+wall+2*nothing]);

	//bolt
	translate([d1/2+wall/2+lock/2,0,d1+1.5*wall+lock/2]) rotate([90,0,0]) translate([0,0,-3*d1]) cylinder(d=bolt,h=6*d1);
}

//nut
translate([d1/2+wall/2+lock/2,-2*wall+pitch-d2/2,d1+1.5*wall+lock/2]) rotate([90,0,0])
	difference(){
		hull(){
			minkowski(){
			nut(d=nut,h=nut/2);
			translate([0,0,wall]) sphere(d=2*wall);
		}
		translate([0,-nut,wall]) sphere(d=nothing);
	}
	translate([0,0,-nothing]) nut(d=nut,h=2*nut);
}

module cylinderRounded(d=10,h=10,wall=1){
	nothing = 0.01;
	difference(){
		union(){
			translate([0,0,wall]) cylinder(d=d+2*wall,h=h-2*wall);
			translate([0,0,wall]) torus(r1=d/2,r2=wall);
			translate([0,0,h-wall]) torus(r1=d/2,r2=wall);
		}
		translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
	}
}

module cylinderHole(d=10,h=10,wall=1){
	nothing = 0.01;
	translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
}

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	translate([r1, 0, 0])
	circle(r = r2);
}

module roundedCube(size = [9,9,9], r = 3){
	if(r<=0)
		cube(size);
	else {
		hull(){
			translate([r,r,r]) sphere(r=r);
			translate([size[0]-r,r,r]) sphere(r=r);
			translate([r,size[1]-r,r]) sphere(r=r);
			translate([size[0]-r,size[1]-r,r]) sphere(r=r);

			translate([r,r,size[2]-r]) sphere(h=r,r=r);
			translate([size[0]-r,r,size[2]-r]) sphere(h=r,r=r);
			translate([r,size[1]-r,size[2]-r]) sphere(h=r,r=r);
			translate([size[0]-r,size[1]-r,size[2]-r]) sphere(h=r,r=r);
		}
	}
}

module nut(d=6.3,h=6.3){
	cylinder(d=d,h=h,$fn=6);
}