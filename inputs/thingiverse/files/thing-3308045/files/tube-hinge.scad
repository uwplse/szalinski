$fn=50;
d = 12.4;
wall = 3;
h = 10;
gap = 2;
tolerance = 0.1;
bolt = 3;
nut = 6.22;
block = 20;
print = 0;
hinge1 = 1;
hinge2 = 1;
peg = 1;
nothing = 0.01;

if(print){
	if(peg) translate([0,-d/2-wall/2,0]) peg();
	if(hinge1) hinge1();
	if(hinge2) translate([3*wall,0,h]) rotate([0,180,0]) hinge2();
} else {
	if(peg) translate([0,-d/2-wall/2,0]) peg();
	if(hinge1) hinge1();
	if(hinge2) hinge2();
}

module hinge1(){
	difference(){
		union(){
			difference(){
				union(){
					cylinderRounded(h=h,d=d,wall=wall);
					translate([-gap/2-wall,d/2,0]) roundedCube([gap+2*wall,3*bolt,h]);
				}
				translate([-2*d,-d,-nothing]) cube([2*d,2*d+3*bolt,h+2*nothing]);
				//translate([0,0,-nothing]) cylinder(h=h+2*nothing,d=d);
				translate([-gap/2,0,-nothing]) cube([gap,2*d,h+2*nothing]);				
				translate([0,-d,+h/2+nothing]) cube([wall/2,d,h/2]);
			}
			translate([0,-d/2-wall/2,0]) cylinder(d=wall,h=h/2);
		}
		translate([0,-d/2-wall/2,-nothing]) cylinder(r=wall/4,h=h+2*nothing);
		translate([gap/2+wall/2,d/2+bolt*1.5,h/2]) rotate([0,90,0]) nut();
		translate([-d,d/2+bolt*1.5,h/2]) rotate([0,90,0]) cylinder(d=bolt,h=2*d);
	}
}

module hinge2(){
	difference(){
		union(){
			difference(){
				union(){
					cylinderRounded(h=h,d=d,wall=wall);
					translate([-gap/2-wall,d/2,0]) roundedCube([gap+2*wall,3*bolt,h]);
				}
				translate([0,-d,-nothing]) cube([2*d,2*d+3*bolt,h+2*nothing]);
				//translate([0,0,-nothing]) cylinder(h=h+2*nothing,d=d);
				translate([-gap/2,0,-nothing]) cube([gap,2*d,h+2*nothing]);
				translate([-wall/2,-d,-nothing]) cube([wall/2,d,h/2]);
			}
			translate([0,-d/2-wall/2,h/2]) cylinder(d=wall,h=h/2);
		}
		translate([0,-d/2-wall/2,-nothing]) cylinder(r=wall/4,h=h+2*nothing);
		translate([-d,d/2+bolt*1.5,h/2]) rotate([0,90,0]) cylinder(d=bolt,h=2*d);	
	}
	translate([-wall-d/2,-block,0])  roundedCube([wall,block,h]);
}

module peg(){
	cylinder(r=wall/4,h=h-wall/4);
	translate([0,0,h-wall/4]) sphere(r=wall/4);
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

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	translate([r1, 0, 0])
	circle(r = r2);
}
