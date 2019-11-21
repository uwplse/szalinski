// Printed Bearing
// by Radus 2018
// http://vk.com/linuxbashev

// Parameters
diameter_in=8;   // Inner Diameter
diameter_out=22; // Outer Diameter
height=7;        // Height
wall_width=0.79; // Wall Width

printedbearing(diameter_in,diameter_out,height, wall_width);  // 608

// Examples
//translate([0,0,0])  printedbearing(3,10,4, 0.52);  // 623
//translate([20,0,0]) printedbearing(4,13,5, 0.65);  // 624
//translate([-20,0,0]) printedbearing(5,16,5, 0.81); // 625
//translate([0,20,0]) printedbearing(6,19,6, 0.76);  // 626
//translate([0,-20,0]) printedbearing(7,22,7, 0.83); // 627
//translate([25,25,0]) printedbearing(8,24,8, 0.79);   // 628
//translate([25,-25,0]) printedbearing(8,22,7, 0.79);  // 608
//translate([-25,-25,0]) printedbearing(9,26,8, 1.11); // 629
//translate([-25,25,0]) printedbearing(10,26,8, 1.07); // 6000
//translate([0,0,0]) printedbearing(20,42,12, 1.64); // 6004
//translate([0,0,0]) printedbearing(100,150,24, 2.06); // 6020


function catb(cata,catang)=cata/cos(catang)*sin(catang);

module printedbearing(pdi=8, pdo=22, ph=7, pw=1){

do=pdo;
di=pdi;
h=ph;
w2=pw;
w1=w2;

zz=0.15;             // gap between rollers and base

dr=do/2-di/2-w1*2-w2*2-zz*2;

h2=catb(w1,45);     // angle inside rollers
//h3=(dr-h2*2)/1.5;
//h1=(h-h3-h2*2)/2;
h1=w1;
h3=h-h1*2-h2*2;


n=floor(2*PI*(di/2+(do/2-di/2)/2)/(dr+w1*2));
//echo(n);
sph=0.15;
spw=0.6;
$fn=64;



module bout(){
difference(){
union(){
translate([0,0,h/2]) cylinder(h,do/2,do/2,true);
} // un

translate([0,0,h1/2-1/2]) cylinder(h1+1.1,do/2-w1-w2,do/2-w1-w2,true);
translate([0,0,h1+h2/2]) cylinder(h2,do/2-w1-w2,do/2-w2,true);
translate([0,0,h1+h2+h3/2]) cylinder(h3+0.02,do/2-w2,do/2-w2,true);
translate([0,0,h1+h2+h3+h2/2]) cylinder(h2,do/2-w2,do/2-w2-w1,true);
translate([0,0,h1+h2+h3+h2+h1/2+1/2]) cylinder(h1+1.1,do/2-w2-w1,do/2-w2-w1,true);
} // df
} // mod

module bin(){
difference(){
union(){
translate([0,0,h1/2]) cylinder(h1,di/2+w2+w1,di/2+w2+w1,true);
translate([0,0,h1+h2/2]) cylinder(h2,di/2+w2+w1,di/2+w2,true);
translate([0,0,h1+h2+h3/2]) cylinder(h3,di/2+w2,di/2+w2,true);
translate([0,0,h1+h2+h3+h2/2]) cylinder(h2,di/2+w2,di/2+w2+w1,true);
translate([0,0,h1+h2+h3+h2+h1/2]) cylinder(h1,di/2+w2+w1,di/2+w2+w1,true);
} // un

translate([0,0,h/2]) cylinder(h+1,di/2,di/2,true);
} // df
} // mod

module rol(){
union(){
translate([0,0,h1/2]) cylinder(h1,dr/2,dr/2,true);
translate([0,0,h1+h2/2]) cylinder(h2,dr/2,dr/2+w1,true);
translate([0,0,h1+h2+h3/2]) cylinder(h3,dr/2+w1,dr/2+w1,true);
translate([0,0,h1+h2+h3+h2/2]) cylinder(h2,dr/2+w1,dr/2,true);
translate([0,0,h1+h2+h3+h2+h1/2]) cylinder(h1,dr/2,dr/2,true);
} // un
} // mod

module sp(){
difference(){
translate([0,0,sph/2]) cylinder(sph, di/2+(do/2-di/2)/2+spw/2, di/2+(do/2-di/2)/2+spw/2,true);
translate([0,0,sph/2]) cylinder(sph+1, di/2+(do/2-di/2)/2-spw/2, di/2+(do/2-di/2)/2-spw/2,true);
} // df
} // mod sp


difference(){
union(){
bout();
bin();
for (r=[0:n-1]) rotate([0,0,360/n*r])
translate([di/2+(do/2-di/2)/2,0,0]) rol();
sp();
} //un
//cube([100,100,100]);
} // df

} // mod prinbe



