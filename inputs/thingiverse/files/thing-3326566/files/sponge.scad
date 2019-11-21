$fn=50;
d1=22.2;
d2=20;
d3=100;
w=1/2*80;
h1=20;
h2=h1/2;
wall=1;
overhang=d1;
not=0.01;

difference(){
	//translate([0,0,-wall]) cylinderRounded(d=d1,h=w+wall,wall=wall);
	cylinder(d=d1+2*wall,h=w);
	translate([0,0,-not]) cylinder(d=d1,h=w+2*not);
	translate([0,0,-not]) cube([d1,d1,w+2*not]);
	translate([overhang,-d1,-not]) cube([d1,d1,w+2*not]);
}
//translate([0,-d1/2-wall/2,0]) cylinderRounded(d=0,h=w,wall=wall);

//connection
translate([-wall,d1/2,0]) roundedCube([h1+2*wall,wall,w],r=wall/2);

//hook 2
translate([h1,(d1+d2)/2+wall,0]) difference(){
	cylinderRounded(d=d2,h=w,wall=wall);
	translate([0,0,-not]) cylinder(d=d2,h=w+2*not);
	translate([-d2,-d2,-not]) cube([d2,2*d2,w+2*not]);
}

//sponge holder
translate([h1-h2,d1/2+d2+wall,0]) roundedCube([h2+wall,wall,w],r=wall/2);

//torus holder
translate([d3/2,-d1/2-wall,0]) rotate([0,90,90]) intersection(){
	translate([0,0,d1/2+wall]) torusHollow(d3/2,d1/2,wall);
	cube([d3,d3,d3]);
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

module torusHollow(r1=10,r2=1, wall=1){
	difference(){
		rotate_extrude(convexity = 10)
		translate([r1, 0, 0])
		difference(){
			circle(r = r2+wall);
			translate([-r1,0]) square([r1,r1]);
		}

		rotate_extrude(convexity = 10)
		translate([r1, 0, 0])
		circle(r = r2);
		
	}
}