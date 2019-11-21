$fn=64;
d1 = 12.9+.1;
d2 = 15.9;
h=40;
wallCylinder = 2;
wallPad = 3.5;
nut = 6.15;
nutThick = 2;
gap = 2;
capD = 20;
noth = 0.01;
bolt = 3;
tolerance = 0.15*2; //my printer makes 0.3 smaller holes


holder(d1=d1,d2=d2,h=h,gap=gap);

module holder(d1=10,d2=15,h=10,gap=1){
	difference(){
		union(){
			cylinderRounded(h=h,d=d2,wall=wallCylinder);
			translate([-wallPad-d1/2,-wallPad,0]) roundedCube([gap+2*wallPad,2*wallPad+2*bolt+d2/2,h],r=wallPad);
		}
		//gap
//		translate([-d1/2,0,-noth]) cube([gap,2*d1,h/2-wall/2+noth]);
//		translate([-d1/2,0,h/2+wall/2]) cube([gap,2*d1,h/2-wall/2]);
		translate([-d1/2,0,-noth]) cube([gap,2*d1,h+2*noth]);
		
		//tube holes
		translate([0,0,-noth]) cylinder(d=d1+tolerance,h=h/2+2*noth);
		translate([0,0,h/2]) cylinder(d=d2,h=h/2+2*noth); //no tolerance to fit firmly
		
		//nuts & bolts
		translate([-d1/2+gap+wallPad/2,d2/2+bolt*1.6,h-1.5*bolt]) rotate([30,0,0]) rotate([0,90,0]) nut(h=nutThick+wallPad/2);
		translate([-d2,d2/2+bolt*1.5,h-1.5*bolt]) rotate([0,90,0]) cylinder(d=bolt+tolerance,h=2*d2);

		translate([-d1/2+gap+wallPad/2,d2/2+bolt*1.6,1.5*bolt]) rotate([30,0,0]) rotate([0,90,0]) nut(h=nutThick+wallPad/2);
		translate([-d2,d2/2+bolt*1.5,1.5*bolt]) rotate([0,90,0]) cylinder(d=bolt+tolerance,h=2*d2);
	}
}

module nut(h=1){
	//smaller tolerance so it fits firmly
	cylinder(d=nut+tolerance/2,h=h,$fn=6);
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
	difference(){
		union(){
			translate([0,0,wall]) cylinder(d=d+2*wall,h=h-2*wall);
			translate([0,0,wall]) mirror([0,0,1]) torus(r1=d/2,r2=wall);
			translate([0,0,h-wall]) torus(r1=d/2,r2=wall);
			cylinder(d=d,h=h);
		}
	}
}

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}
