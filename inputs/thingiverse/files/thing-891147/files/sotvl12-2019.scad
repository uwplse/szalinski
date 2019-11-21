// Honeycomb vase
// by Radus 2015-2019
// http://vk.com/linuxbashev

//include<cutrad.scad>;

// Parameters

// Height vase
h=270;
// Count hexes on a circle
n=12;
// Hex size
dw=40;
// Gap between hexes
w=1;
// Hex angle
an=30;
// Perimeter width (0 for spiral vase)
sw=0;
// Round corners radius
cr=0;
// Resolution for round
$fn=32;
//
//
//


// -----------------------------
//no=5;
//do=18;

dst=(dw-w)/sin(360/6);
dct=((n*dw)/(2*PI))*2;
dh=dw*sin(360/6);

h1=cata(dst/2*sin(360/6),90-an)+1;



function cata(catb,catang)=catb/sin(catang)*cos(catang);
function catb(cata,catang)=cata/cos(catang)*sin(catang);
function gip(cata,catb)=sqrt(cata*cata+catb*catb);

function a2p(AX1,AY1,AZ1, AX2,AY2,AZ2, AX3,AY3,AZ3, BX1,BY1,BZ1, BX2,BY2,BZ2, BX3,BY3,BZ3) = acos(abs(((AY2-AY1)*(AZ3-AZ1)-(AZ2-AZ1)*(AY3-AY1))*((BY2-BY1)*(BZ3-BZ1)-(BZ2-BZ1)*(BY3-BY1))+((AX3-AX1)*(AZ2-AZ1)-(AX2-AX1)*(AZ3-AZ1))*((BX3-BX1)*(BZ2-BZ1)-(BX2-BX1)*(BZ3-BZ1))+((AY3-AY1)*(AX2-AX1)-(AY2-AY1)*(AX3-AX1))*((BY3-BY1)*(BX2-BX1)-(BY2-BY1)*(BX3-BX1)))/(sqrt(((AY2-AY1)*(AZ3-AZ1)-(AZ2-AZ1)*(AY3-AY1))*((AY2-AY1)*(AZ3-AZ1)-(AZ2-AZ1)*(AY3-AY1))+((AX3-AX1)*(AZ2-AZ1)-(AX2-AX1)*(AZ3-AZ1))*((AX3-AX1)*(AZ2-AZ1)-(AX2-AX1)*(AZ3-AZ1))+((AY3-AY1)*(AX2-AX1)-(AY2-AY1)*(AX3-AX1))*((AY3-AY1)*(AX2-AX1)-(AY2-AY1)*(AX3-AX1)))*sqrt(((BY2-BY1)*(BZ3-BZ1)-(BZ2-BZ1)*(BY3-BY1))*((BY2-BY1)*(BZ3-BZ1)-(BZ2-BZ1)*(BY3-BY1))+((BX3-BX1)*(BZ2-BZ1)-(BX2-BX1)*(BZ3-BZ1))*((BX3-BX1)*(BZ2-BZ1)-(BX2-BX1)*(BZ3-BZ1))+((BY3-BY1)*(BX2-BX1)-(BY2-BY1)*(BX3-BX1))*((BY3-BY1)*(BX2-BX1)-(BY2-BY1)*(BX3-BX1)))));


module cutrad(crh=1, crr=1, cang=90) {
//cos(cang/2)=crx/crc;
//sin(cang/2)=crr/crc;
crc=crr/sin(cang/2);
crx=crc*cos(cang/2);
difference() {
union() {
hull() {
cube([0.1,0.1,crh],true);
translate([crx-0.05,0,0]) cube([0.1,0.1,crh],true);
rotate([0,0,cang]) translate([crx-0.05,0,0]) cube([0.1,0.1,crh],true);
} // hl
} // un
translate([crx,crr,0]) cylinder(crh+0.1, crr, crr, true);
} // df    
} // mod cutrad




module st(dc, ds) {
render()    
mirror([0,0,1])
difference() {
translate([0,0,0]) rotate([0,90,0]) cylinder(dc/2+h1, ds/2, ds/2, $fn=6);
rotate([30,0,0]) {
for (r1=[0:2]) {
translate([dc/2+h1, 0,0]) rotate([r1*120,0,0]) rotate([0,-an,0]) translate([0.01,-dw/2,0]) cube([dw,dw,dw]);

if (cr!=0) {
anb=acos(h1/cos(90-an)/sqrt(h1*h1+(h1/cos(90-an)*sin(90-an)/cos(60))*(h1/cos(90-an)*sin(90-an)/cos(60))));
a1x=dc/2+h1;
a1y=0;
a1z=0;
a2x=dc/2;
a2y=0;
a2z=catb(h1,90-an);
a3x=dc/2;
a3y=-catb(catb(h1,90-an),60);
a3z=catb(h1,90-an);
//%hull(){
//translate([a1x,a1y,a1z]) cube([1,1,1],true);
//translate([a2x,a2y,a2z]) cube([1,1,1],true);    
//translate([a3x,a3y,a3z]) cube([1,1,1],true);
//}
b1x=a1x;
b1y=a1y;
b1z=a1z;
b2x=a3x;
b2y=a3y;
b2z=a3z;
b3x=dc/2;
b3y=0;
b3z=-gip(catb(h1,90-an),catb(catb(h1,90-an),60));
//%hull(){
//translate([b1x,b1y,b1z]) cube([1,1,1],true);
//translate([b2x,b2y,b2z]) cube([1,1,1],true);    
//translate([b3x,b3y,b3z]) cube([1,1,1],true);
//}
ang1=a2p(a1x,a1y,a1z, a2x,a2y,a2z, a3x,a3y,a3z, b1x,b1y,b1z, b2x,b2y,b2z, b3x,b3y,b3z);
//echo(ang1);
translate([dc/2+h1,0,0]) rotate([r1*120,0,0]) rotate([0,-an,0]) rotate([anb,0,0]) rotate([0,0,90]) cutrad(ds*2, cr, 180-ang1);
} // if cr
} // for

if (cr!=0) {
for (rt=[0:60:359])
translate([dc/4, 0,0]) rotate([0,90,0]) rotate([0,0,rt]) translate([0,ds/2,0]) rotate([0,0,-150]) cutrad(dc/2+h1*2,cr,120);

cbd=cata(ds/2*sin(360/6),90-an);
c1x=dc/2+h1-cbd;
c1y=0;
c1z=catb(cbd,90-an);
c2x=dc/2+h1;
c2y=0;
c2z=0;
c3x=c1x;
c3y=ds/2;
c3z=c1z;
//%hull(){
//translate([c1x,c1y,c1z]) cube([1,1,1],true);
//translate([c2x,c2y,c2z]) cube([1,1,1],true);    
//translate([c3x,c3y,c3z]) cube([1,1,1],true);
//}

d1x=dc/2+h1-cbd;
d1y=0;
d1z=catb(cbd,90-an);
d2x=dc/2+h1-cbd;
d2y=ds/2;
d2z=catb(cbd,90-an);
d3x=dc/2;
d3y=0;
d3z=ds/2*sin(360/6);
//%hull(){
//translate([d1x,d1y,d1z]) cube([1,1,1],true);
//translate([d2x,d2y,d2z]) cube([1,1,1],true);    
//translate([d3x,d3y,d3z]) cube([1,1,1],true);
//}
ang2=a2p(c1x,c1y,c1z,c2x,c2y,c2z,c3x,c3y,c3z, d1x,d1y,d1z,d2x,d2y,d2z,d3x,d3y,d3z);
for (r2=[0:120:359])
rotate([r2,0,0]) translate([c1x,c1y,c1z]) rotate([-90,0,0]) rotate([0,180,0]) cutrad(ds,cr,180-ang2);

ugk=acos(h1/sqrt(h1*h1+(h1/cos(90-an)*sin(90-an)/cos(60))*(h1/cos(90-an)*sin(90-an)/cos(60))));
ebt=(catb(cbd,90-an)/sin(ugk))*cos(ugk);
e1x=dc/2+h1-cbd;
e1y=-ds/4;
e1z=catb(cbd,90-an);
e2x=dc/2+h1-cbd;
e2y=-catb(cbd,90-an)*sin(60);
e2z=catb(cbd,90-an)*cos(60);
e3x=dc/2+h1-ebt;
e3y=-catb(cbd,90-an)*sin(60);
e3z=catb(cbd,90-an)*cos(60);
//%hull(){
//%translate([e1x,e1y,e1z]) cube([1,1,1],true);
//%translate([e2x,e2y,e2z]) cube([1,1,1],true);    
//%translate([e3x,e3y,e3z]) cube([1,1,1],true);
//}
f1x=dc/2+h1;
f1y=0;
f1z=0;
f2x=dc/2+h1-cbd;
f2y=-ds/4;
f2z=catb(cbd,90-an);
f3x=dc/2+h1-ebt;
f3y=-catb(cbd,90-an)*sin(60);
f3z=catb(cbd,90-an)*cos(60);
//%hull(){
//%translate([f1x,f1y,f1z]) cube([1,1,1],true);
//%translate([f2x,f2y,f2z]) cube([1,1,1],true);    
//%translate([f3x,f3y,f3z]) cube([1,1,1],true);
//}
ang3=a2p(e1x,e1y,e1z,e2x,e2y,e2z,e3x,e3y,e3z, f1x,f1y,f1z,f2x,f2y,f2z,f3x,f3y,f3z);
//echo(ang, ang2, ang3);
ugd=asin((cbd-ebt)/sqrt((cbd-ebt)*(cbd-ebt)+ds/4*ds/4));
for (r2=[0:120:359])
for (r3=[-ugd,ugd])
rotate([r2,0,0]) translate([f3x,f3y,f3z]) rotate([-30,0,0]) rotate([0,180+r3,0]) cutrad(ds*2,cr,180-ang3);

} // if cr
} // rotate
} // df

} // mod st;



module sotc() {
difference() {
union() {
translate([0,0,0])cylinder(h, dct/2, dct/2, $fn=128);

for (hn=[0:h/dh])
translate([0,0,hn*dh])
rotate([0,0,360/n/(hn%2+1)])
for (r=[0:n-1]) {
	 translate([0,0,dh/2]) rotate([0,0,360/n*r]) st(dct,dst);
} // for

} // un
translate([0,0,h/2])
for (mz=[0,1]) mirror([0,0,mz])
translate([0,0,h/2]) cylinder(h, dct/2+h1*2, dct/2+h1*2, $fn=128);


} // df


} // mod sotc

module sotcin() {
difference() {
union() {
translate([0,0,sw]) cylinder(h+dh, dct/2-sw, dct/2-sw, $fn=128);

for (hn=[0:h/dh])
translate([0,0,hn*dh])
rotate([0,0,360/n/(hn%2+1)])
for (r=[0:n-1])
translate([0,0,dh/2]) rotate([0,0,360/n*r]) st(dct-sw*2,dst-sw*2);

} // un
translate([0,0,sw]) mirror([0,0,1]) cylinder(h, dct/2+h1*2, dct/2+h1*2, $fn=128);


} // df
} // mod sotc

module holes() {
for (r=[0:no-1]) {
rotate([0,0,360/no*r]) translate([dct/2-do/2-3.5, 0, -0.1]) cylinder(1, 5/2+1, 5/2);
rotate([0,0,360/no*r]) translate([dct/2-do/2-3.5, 0, -1]) cylinder(do, 5/2, 5/2);
rotate([0,0,360/no*r]) translate([dct/2-do/2-3.5, 0, 2+do/2]) sphere(do/2);
rotate([0,0,360/no*r]) translate([dct/2-do/2-3.5, 0, 2+do/2]) cylinder(h, do/2, do/2);
rotate([0,0,360/no*r]) translate([dct/2-do/2-3.5, 0, h-2]) cylinder(2.1, do/2, do/2+2);
} // for
} // mod holes



difference() {
sotc();
if (sw!=0) sotcin();
//holes();
} // df

