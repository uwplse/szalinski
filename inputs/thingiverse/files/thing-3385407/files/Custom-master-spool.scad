$fn=32;

part1 = 1;
part2 = 1;

printInnerRing = 1;
printOuterRing = 1;

d1=50; //hole for rod
d2=100; // inner filament refill diameter
d3=200; // outer spool diameter

h=70;
filamentHole = 2;
wall = 10;
rounding1 = 1;
rounding2 = wall/3;
tolerance = 0.2;

// wall thickness correction
d1w=d1+wall;
d2w=d2-wall;
d3w=d3-wall;
tol = tolerance;
d4=(!printInnerRing && printOuterRing)?d2w:d1w;
h1 = printInnerRing?0:wall/2;
not = 0.001+0; // preview hack
round2 = (printOuterRing)?0:rounding2;

if(part1) part1();
if(part2) translate([0,0,h+wall]) part2();



module part1(){
	//inner ring
	if(printInnerRing){
		torus(r1=d1w/2,r2=wall/2);
	}

	//outer ring
	if(printOuterRing){
		torus(r1=d3w/2,r2=wall/2);
	}

	//horizontal connection
	horiz(false);
	rotate([0,180,0]) horiz(false);

	//vertical connection
	difference(){
		union(){
			vertic();
			rotate([0,0,180]) vertic();
		}
	}
}

module part2(){
	//inner ring
	if(printInnerRing){
		torus(r1=d1w/2,r2=wall/2);
	}

	//outer ring
	if(printOuterRing){
		torus(r1=d3w/2,r2=wall/2);
	}

	//horizontal connection
	horiz();
	rotate([0,180,0]) horiz();
}

module vertic(){
	difference(){
		translate([d2w/2,0,h1]) cylinderRounded(d=wall,h=h+1.5*wall-h1,r1=0,r2=rounding1);
		translate([d2w/2,wall/2,h+wall]) rotate([90,0,0]) cylinder(d=filamentHole,h=wall);
	}
	if(!printInnerRing) translate([d2w/2+wall/2,0,wall/2]) rotate([90,180,0]) knee(r1=wall/2,r2=wall/2);
}

module horiz(hole=true){
	d5 = (d4==d1w)?d2w-d1w:0;
	translate([d4/2,0,0]) rotate([0,90,0])
	difference(){
		union(){
			translate([0,0,h1]) cylinderRounded(d=wall,h=(d3w-d4)/2-h1,r1=0,r2=round2);
			if(hole) translate([-wall/2,0,d5/2]) rotate([0,90,0])  cylinderRoundedHollow(d=wall+tol,h=wall,wall=wall/2,type=0);			
		}
		translate([0,wall/2,(d3w-d4)/2-wall]) rotate([90,0,0]) cylinder(d=filamentHole,h=wall);
		if(hole){
			translate([-wall/2,0,d5/2]) rotate([0,90,0]) cylinder(d=wall+tol,h=wall);
			translate([0,2*wall,d5/2]) rotate([90,0,0]) cylinder(d=filamentHole,h=4*wall);
		}
	}
}

module cylinderRoundedHollow(d=10,h=10,wall=1,type=1){
	nothing = 0.001;

	if(d<=0){
		hull(){
			translate([0,0,+wall/2]) sphere(d=wall);
			translate([0,0,h-wall/2]) sphere(d=wall);			
		}
	} else if(type==1) {
		difference(){
			union(){
				translate([0,0,wall/2]) cylinder(d=d+2*wall,h=h-wall);
				translate([0,0,wall/2]) torus(r1=d/2+wall/2,r2=wall/2);
				translate([0,0,h-wall/2]) torus(r1=d/2+wall/2,r2=wall/2);
			}
			translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
		}
	} else {
		difference(){
			union(){
				translate([0,0,wall]) cylinder(d=d+2*wall,h=h-2*wall);
				translate([0,0,wall]) mirror([0,0,1]) torusQuart(r1=d/2,r2=wall);
				translate([0,0,h-wall]) torusQuart(r1=d/2,r2=wall);
				cylinder(d=d,h=h);
			}
			translate([0,0,-nothing]) cylinder(d=d,h=h+2*nothing);
		}
	}
}

module cylinderRounded(d=10,h=10,r1=1,r2=2){
	not = 0.001;
	difference(){
		hull(){
			if (r1>0){
				translate([0,0,r1]) mirror([0,0,1]) torusQuart(r1=d/2-r1,r2=r1);
			} else {
				translate([0,0,0]) cylinder(d=d,h=not);
			}
			if (r2>0){
				translate([0,0,h-r2]) torusQuart(r1=d/2-r2,r2=r2);
			} else {
				translate([0,0,h]) cylinder(d=d,h=not);
			}
		}
	}
}

module torus(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	translate([r1, 0, 0])
	circle(r = r2);
}

module torusQuart(r1=10,r2=1){
	rotate_extrude(convexity = 10)
	intersection(){
		translate([r1, 0, 0]) circle(r = r2);
		translate([r1, 0, 0]) square([2*r2,2*r2]);
	}
}

module knee(r1=10,r2=2){
	intersection(){
		torus(r1=r1,r2=r2);
		translate([0,0,-r1]) cube([2*r1,2*r1,2*r1]);
	}
}