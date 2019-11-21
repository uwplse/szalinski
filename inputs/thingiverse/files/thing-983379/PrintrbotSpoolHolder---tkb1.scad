// printrbot spool holder

// updated by Tyler Bletsch
//  - rounded head
//  - adjustable guide arm height
//  - reinforced guide elbow

$fn = 64*1;

// Radius of spool holder
Rspool=15;
// Height of spool holder
H=100;
// Radius of Z-rods (adjust fit here)
R=6.2;
// Path width of single trace of plastic
w1=.4;
// Distance between Z-rods (inside measurement)
D=58;
// Length of guide arm
L=130;
// Height of guide arm
ah = 80;

w=w1*4;
d=D/2+R;

difference(){
	union(){
		translate([0,0,17]){
			cylinder(r=Rspool,h=H-Rspool);
            translate([0,0,H-Rspool]) sphere(r=Rspool);
			cylinder(r1=30,r2=0,h=40);
		}
		cylinder(r1=15,r2=30,h=17.01);
		translate([0,0,17/2])cube([2*d,2*(R+w),17],center=true);
		translate([d,0,0])cylinder(r=R+w,h=17);
		translate([-d,0,0])cylinder(r=R+w,h=17);
		translate([d,0,0])rotate([0,0,-45]){
			translate([0,-5,0])cube([L-d,10,10]);
            translate([L-d-5,0,10]) rotate([90,0,0]) cylinder(d=20,h=10,center=true);
			translate([L-d,0,0])rotate([0,0,90])guide();
		}
	}
	translate([d,0,0])cylinder(r=R,h=30,center=true);
	translate([d,0,0])cylinder(r1=2*R+0.8,r2=0.8,h=30,center=true);
	translate([-d,0,0])cylinder(r=R,h=30,center=true);
	translate([-d,0,0])cylinder(r1=2*R+0.8,r2=0.8,h=30,center=true);
}

module guide()
difference(){	
	translate([-5,-5,0])cube([10,10,ah]);
	translate([0,0,ah-10])rotate([0,90,0])cylinder(r=3,h=20,center=true,$fn=12);
	translate([0,0,ah-10])rotate([0,135,0])cylinder(r=3,h=20,$fn=12);
	//mirror([0,1,0]){
		translate([0,0,ah-10])rotate([-30,0,0])translate([-1,-3,0])cube(20);
		translate([0,0,ah-10])rotate([-30,0,180])translate([-1,-3,0])cube(20);
		translate([0,0,ah-10])rotate([0,45,0])cube(20);
	//}
	translate([0,0,ah])cube([2,20,20],center=true);
	
}