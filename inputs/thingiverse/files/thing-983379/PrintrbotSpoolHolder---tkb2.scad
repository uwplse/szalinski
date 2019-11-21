// printrbot spool holder

// updated by Tyler Bletsch
//  - rounded head
//  - adjustable guide arm height
//  - reinforced guide elbow

// updated by Tyler Bletsch 2015-12-05
//  - variable arm thickness
//  - improved arm filament guide shape using sphere hulls
//  - added various 1/4" mounting holes at base and on shaft
//  - guide elbow converted to nice sweeping curve instead of cylinder

$fn = 64*1;

// Radius of spool holder
Rspool=13;

// Height of spool holder
H=100;

// Radius of Z-rods (adjust fit here)
R=6.2;

// Path width of single trace of plastic
w1=.4;

w=w1*4; // 4 traces around for Z shaft holder

// Distance between Z-rods (inside measurement)
D=58;

// Length of guide arm
L=130;

// Height of guide arm
ah = 80;

// Thickness of guide arm, make this 2*(R+w1*4) for a uniform look
th=15.6; // make arm as thick as the base

// Radius of the curve at the elbow of the support
elbow_radius = 15;

// Diameter of the holes put into the base and vertical shaft (used for optionally mounting various stuff with bolts (use ~6.7mm for 1/4" or M6 bolts)). Set to 0 to disable these holes.
hole_dia = 6.7;

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
			translate([0,-th/2,0])cube([L-d,th,th]);
            
            // old ugly guide elbow
            //translate([L-d-th/2,0,th]) rotate([90,0,0]) cylinder(d=20,h=th,center=true);
            
            // guide elbow
            translate([L-d-th/2+0.1,0,th]) difference() {
                translate([-elbow_radius,-th/2,0]) cube([elbow_radius,th,elbow_radius],center=false);
                translate([-elbow_radius,0,+elbow_radius]) rotate([90,0,0]) cylinder(r=elbow_radius,h=th+1,center=true);
            }
			translate([L-d,0,0])rotate([0,0,90])guide();
		}
        
        // base perp hole square
        translate([0,0,17/2]) cube([17*2,60,17],center=true);
	}
	translate([d,0,0])cylinder(r=R,h=30,center=true);
	translate([d,0,0])cylinder(r1=2*R+0.8,r2=0.8,h=30,center=true);
	translate([-d,0,0])cylinder(r=R,h=30,center=true);
	translate([-d,0,0])cylinder(r1=2*R+0.8,r2=0.8,h=30,center=true);
    
    // base perp hole
    translate([17/2,0,17/2]) rotate([90]) cylinder(d=hole_dia,h=80,center=true);
    translate([-17/2,0,17/2]) rotate([90]) cylinder(d=hole_dia,h=80,center=true);
    
    // shaft holes
    translate([0,0,50]) rotate([90]) cylinder(d=hole_dia,h=80,center=true);
    translate([0,0,70]) rotate([0,90]) cylinder(d=hole_dia,h=80,center=true);
    translate([0,0,90]) rotate([90]) cylinder(d=hole_dia,h=80,center=true);
}

module guide()
difference(){	
	translate([-th/2,-th/2,0])cube([th,th,ah]);
	/*
    // old filament guide geometry
    translate([0,0,ah-10])rotate([0,90,0])cylinder(r=3,h=20,center=true,$fn=32);
	hull() {
        translate([0,0,ah-10])rotate([0,135,0])cylinder(r=3,h=20,$fn=32);
        translate([0,0,ah-2])rotate([0,135,0])cylinder(r=3,h=20,$fn=32);
    }
    */
    hull() {
        translate([-th,0,ah-10]) sphere(d=6,$fn=$fn/2);
        translate([0,0,ah-10]) sphere(d=6,$fn=$fn/2);
    }
    hull() {
        translate([0,0,ah-10]) sphere(d=6,$fn=$fn/2);
        translate([th,0,ah-10-th]) sphere(d=6,$fn=$fn/2);
        translate([th,0,ah-10]) sphere(d=6,$fn=$fn/2);
    }
    translate([0,0,ah-10])rotate([-30,0,0])translate([-1,-3,0])cube(th);
    translate([0,0,ah-10])rotate([-30,0,180])translate([-1,-3,0])cube(th);
    translate([0,0,ah-10])rotate([0,45,0])cube([th,th,5]);
	translate([0,0,ah])cube([2,th+1,th+1],center=true);
	
}