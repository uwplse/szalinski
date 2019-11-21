// simple bushing clamp, pipe bracket, or general snap on point for cylindric structures
// meant to carry LM8UU type of linear bearings for mounting below Y carriage.
// v0.0.1 2016oct30, Bushmills  v0.0.1

length = 20;                // [1:80]
width = 44;                 // [16:64]
base = 8;                   // [1:0.2:16]
elev = 2;                   // [0:0.1:20]
wall = 3;                   // [0.5:0.1:8]
inner = 15;                 // [4:0.1:32]
angle = 320;                // [90:360]
hole = 4;                   // [2:0.1:8]
distance = 30;              // [12:0.1:48]
// set to 0 for none
flap = 8;                   // [0:50]


little = 0+0.01;
$fn = 0+100;

outer = inner + 2*wall;
peri  = (inner+wall)/2;
a1    = angle/2;

bracket();



// --- pesky item details follow ---

// --- include <pie.scad> ---
// (inclusion of /home/l/3d-print/my/lib/pie.scad done by /misc/bin/scad_include)
/* 2D pie.  works on angles 0..any - but 360 or multiple will be interpreted as 0, i.e. "no circle" instead "full circle"

2016sep?? v0.0.1,ls  initial version. 0..180°
2016oct21 v0.0.2,ls  modified for 360° operation.
*/

module pie(r, a)  {
extra = 5;			// depending on $fn, the circumference of a circle isn't perfect.
// when substracting rotated circle from circle, those deviations show as artefacts.
// "extra" gives the substracting circle larger radius to avoid those artefacts.
module halfcircle(r)  {
difference()  {
circle(r);
translate([-r, -r])
square([r, 2*r+extra]);
}
}
angle = a%180;
half = a%360-angle;
if (half) halfcircle(r);
rotate([0, 0, half])
difference()  {
halfcircle(r);
rotate([0, 0, angle])
halfcircle(r+extra);
}
}
// (inclusion of /home/l/3d-print/my/lib/pie.scad finished)


module bracket()  {
difference()  {
linear_extrude(length)  {
difference()  {
translate([0, (base-outer)/2+elev])
square([width, base], center=true);           // base
circle(d=outer);                              // in case base is thicker than wall
}

difference()  {                                  // tube/bearing holding part
circle(d=outer);                              // outer
circle(d=inner);                              // inner
rotate([0, 0, a1])
pie(outer/2+little, 360-angle);               // remove wedge
}

for (a = [a1, -a1])  {
translate([-sin(a)*peri, -cos(a)*peri, 0])  {
circle(d=wall);                               // rounded ends
translate([-wall/2, 0, 0])
square([wall, flap]);
}
}
}
for (p =[distance/2, -distance/2])  {
translate([p, base-(outer-little)/2+elev, length/2])
rotate([90, 0, 0])
cylinder(h=base+little, d=hole);                 // mount holes
}

if (flap)  {
translate([-outer/2, -cos(a1)*peri+flap/2, length/2])
rotate([0, 90, 0])
cylinder(h=outer, d=hole);
}
}
}
