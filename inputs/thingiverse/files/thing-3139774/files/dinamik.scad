// Dinamic
// by Radus 2018
// http://vk.com/linuxbashev

// Parameters

rorb=0; // 0 base or 1 ring

h=2;    // height base
h3=3;   // height center
h4=2;   // height ring

di=130; // diameter inside
d1=160; // diameter outside
d2=22;  // diameter corners

wr=5;   // width ring

rz=0.2; // gap between ring and base

do=4.3; // diameter holes
dsh=10+2; // diameter washers

bw=115;  // length between holes


lay=0.2;    // layer height
sow=0.8;    // hex width nozzle*2
sohh=10;    // hex height
sodd=10;    // hex diameter

sphd=217;   // sphere diameter



// other formulas
d3=di+2;
d4=di+wr+2;

$fn=128;

sox=di+2;
soy=di+2;
soh=sohh+h3;

sod=sodd+sow;
sodx=sod*sin(360/6);



module sot() {
difference() {
	translate([0,0,soh/2]) cube([sox,soy,soh], true);

for (n=[0,1]) mirror([0,n,0])
	for (m=[0,1]) mirror([m,0,0])
	for (j=[0:sox/sodx]) translate([j*(sodx+sow), 0, 0])
	for (i=[0:sox/sodx]) {
	rotate([0,0,360/6])
	translate([i*(sodx+sow), 0, -1]) rotate([0,0,360/6/2]) cylinder(soh+2, sod/2, sod/2, $fn=6);
	rotate([0,0,360/6*2])
	translate([i*(sodx+sow), 0, -1]) rotate([0,0,360/6/2]) cylinder(soh+2, sod/2, sod/2, $fn=6);
	} // for i
} // df
} // mod sot


module dinamik(){    
difference() {
union(){
hull(){
translate([0,0,h/2]) cylinder(h,d1/2,d1/2,true);    
for (my=[0,1]) mirror([0,my,0])
for (mx=[0,1]) mirror([mx,0,0])
translate([-bw/2,-bw/2,h/2]) cylinder(h,d2/2,d2/2,true);
} // hl
translate([0,0,h3/2]) cylinder(h3,d3/2,d3/2,true);    
} // un
translate([0,0,h3/2]) cylinder(h3+1, di/2,di/2,true);
for (my=[0,1]) mirror([0,my,0])
for (mx=[0,1]) mirror([mx,0,0]) {
translate([-bw/2,-bw/2,h/2]) cylinder(h+1,do/2,do/2,true);
translate([-bw/2,-bw/2,h]) cylinder(lay*4,dsh/2,dsh/2,true);
} // for


} // df
} // mod

module sot1(){
difference() {    
difference() {
sot();
difference(){
translate([0,0,soh/2]) cylinder(soh+1,d1/2+40,d1/2+40,true);
//translate([0,0,soh/2]) cylinder(soh+2,di/2+1,di/2+1,true);
translate([0,0,-sphd+soh]) sphere(sphd);
  
} // df
} // df
translate([0,0,-sphd+soh-h3]) sphere(sphd);

} // df
} // mod

module dinamik1(){
difference(){
union(){
dinamik();
sot1();
} // un

difference(){
translate([0,0,h]) cylinder(h4+lay*2, d4/2+rz*2,d4/2+rz*2,true);
translate([0,0,h]) cylinder(h4+1, d3/2,d3/2,true);
} // df

} // df
} // mod

module dko(){
difference(){
translate([0,0,h]) cylinder(h4, d4/2+rz,d4/2+rz,true);
translate([0,0,h]) cylinder(h4+1, d3/2+rz,d3/2+rz,true);
} // df    
} // mod 

if (rorb==0)
dinamik1();
else
dko();
