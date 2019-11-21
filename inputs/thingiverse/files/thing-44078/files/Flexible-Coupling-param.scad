// ********** CHANGE THESE PARAMETERS TO ADAPT DIMENSIONS ********** //

// OUTER DIAMETER
D1 = 25;

// INNER DIAMETER (BOTTOM)
D2a = 6;

// INNER DIAMETER (TOP)
D2b = 10;

// TOTAL HEIGHT
H1 = 50;

// BASE HEIGHT
H2 = 10;

// NUMBER OF FLEXIBLE ELEMENTS
N  = 12;

// SCREW HOLE DIAMETER
D3 = 3.5;

// NUT HOLE DIAMETER
Dnut=6.5;

// NUT HOLE THICKNESS
Hnut=2.5;

// FLAT SHAFT THICKNESS (BOTTOM)
Ba=5;

// FLAT SHAFT THICKNESS (TOP)
Bb=8.5;

// SCREW HOLE DISTANCE
H3=4;

// SPRINGS RESOLUTION
SLICES=16; //[6:36]

// ********** DON'T CHANGE BELOW UNLESS YOU KNOW WHAT TO DO ********** //

Re = D1/2;	// outer radius
Ria = D2a/2;	// inner radius 1
Rib = D2b/2;	// inner radius 2
fn = 2*N;	// default face number for cylinders
R3 = D3/2;	// screw hole radius
Rnut=Dnut/2;	// nut hole radius
B2a = Ba-Ria;	// flat face distance from center 1
B2b = Bb-Rib;	// flat face distance from center 2
Hspring=H1-2*H2;

module sq_spring(in_R,out_R,height,rot) {
	width=out_R-in_R;
	linear_extrude(height = height, center = false, convexity = 50, twist = rot, slices = SLICES)
	polygon(points=[[in_R,0],
			[out_R,0],
			[out_R*cos(180/N),out_R*sin(180/N)],
			[in_R*cos(180/N),in_R*sin(180/N)]],
			paths=[[0,1,2,3]]);
}

module hole_h(HoleDist,B2) {
	rotate([0,90,0]) {
		translate ([-HoleDist,0,(Re+B2)/2]) cylinder(r=R3,h=Re*1.2,center=true,$fn=fn);
		translate([-HoleDist,0,(Re+B2)/2]) cylinder(r=Rnut,h=Hnut,center=true,$fn=6);
		translate([0,0,(Re+B2)/2]) cube(size=[2*HoleDist,2*Rnut*cos(30),Hnut],center=true);
	}
}


$fn=fn;
module body(Ri,B2) {
	difference() {
		union() {
			difference(){
				cylinder (r=Re,h=H2,center=false, $fn=fn);
				cylinder(r=Ri,h=H2,center=false, $fn=fn);
				}
			translate([B2,-Ri,0]) cube(size=[Ri,2*Ri,H2], center=false);
		}
		hole_h(H3,B2);
	}
}


body(Ria,B2a);
translate([0,0,H1]) rotate([0,180,0]) body(Rib,B2b);
for (i=[1:N]){
	rotate([0,0,360*i/N]) translate ([0,0,H2]) sq_spring(max(Ria,Rib),Re,Hspring,120);
}
