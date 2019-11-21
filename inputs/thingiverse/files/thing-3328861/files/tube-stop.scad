$fn=50;
d = 12.4;
wall = 3;
h = 10;
gap = 2;
tolerance = 0.1;
bolt = 3;
nut = 6.22;
block = 20;
print = 1;
hinge1 = 1;
hinge2 = 1;
nothing = 0.01;

hinge2();

module hinge2(){
	difference(){
		union(){
			difference(){
				cylinderRounded(h=h,d=d,wall=wall);
				translate([-d,0,0]) cube([3*d,d,h]);
			}
			difference(){
				translate([+d/2,-wall,0]) roundedCube([wall,d/2+3*bolt+wall,h],r=wall/2);
				translate([-d,-d,0]) cube([3*d,d,h]);				
			}

			//translate([-d/2-wall,-wall,0]) roundedCube([wall,d/2+3*bolt+wall,h],r=wall/2);
			//translate([-wall-d/2,-block,0]) roundedCube([wall,block,h],r=wall/2);
			
			translate([-d/2-wall,-block,0]) roundedCube([wall,d/2+3*bolt+block,h],r=wall/2);
			
		}
		translate([-d/2,0,-nothing]) cube([d,2*d,h+2*nothing]);
		translate([-d,d/2+bolt*1.5,h/2]) rotate([0,90,0]) cylinder(d=bolt,h=2*d);	
		cylinder(h=h,d=d);
		translate([d/2+wall/2,d/2+bolt*1.5,h/2]) rotate([0,90,0]) nut();
	}
}

module nut(){
	cylinder(d=nut,h=2*d,$fn=6);
}

module roundedCube(size = [9,9,9], r = 1){
	if(r<=0)
		cube(size);
	else {
		hull(){
			translate([r,r,r]) sphere(r=r);
			translate([size[0]-r,r,r]) sphere(r=r);
			translate([r,size[1]-r,r]) sphere(r=r);
			translate([size[0]-r,size[1]-r,r]) sphere(r=r);

			translate([r,r,size[2]-r]) sphere(r=r);
			translate([size[0]-r,r,size[2]-r]) sphere(r=r);
			translate([r,size[1]-r,size[2]-r]) sphere(r=r);
			translate([size[0]-r,size[1]-r,size[2]-r]) sphere(r=r);
		}
	}
}

//module cylinderRounded(d=10,h=10,wall=1){
//	nothing = 0.01;
//	difference(){
//		union(){
//			translate([0,0,wall]) cylinder(d=d+2*wall,h=h-2*wall);
//			translate([0,0,wall]) torus(r1=d/2,r2=wall);
//			translate([0,0,h-wall]) torus(r1=d/2,r2=wall);
//		}
//		translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
//	}
//}

module cylinderRounded(d=10,h=10,wall=1){
	nothing = 0.01;

	if(d==0){
		hull(){
			translate([0,0,+wall/2]) sphere(d=wall);
			translate([0,0,h-wall/2]) sphere(d=wall);			
		}
	} else {
		difference(){
			union(){
				translate([0,0,wall/2]) cylinder(d=d+2*wall,h=h-wall);
				translate([0,0,wall/2]) torus(r1=d/2+wall/2,r2=wall/2);
				translate([0,0,h-wall/2]) torus(r1=d/2+wall/2,r2=wall/2);
			}
			translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
		}
	}
}

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	translate([r1, 0, 0])
	circle(r = r2);
}
