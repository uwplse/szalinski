// Small diameter of the lid
SD=30;

// Large diameter of the lid
LD=44;

// Height of the lid
LH=30;

// Height of the handle
HH=60;

// To help adhésion cut off the botton (replaces Cura similar option)
CUTOFF=1.5;

$fa=0.5; 

intersection(){
	hull(){
		cylinder(r1=SD/2, r2=LD/2, h=LH);
		scale([1,1,0.3]) sphere(r=15);
	}
	translate([-50, -50, -4.5+CUTOFF]) cube([100, 100, 100]);
}

cylinder(r=8, h=LH+HH-27.5);

hull(){
   translate([0,0,LH+HH-27.5]) sphere(r=8);
	translate([0,0,LH+HH-7.5]) scale([1,1,0.6]) sphere(r=15);
}