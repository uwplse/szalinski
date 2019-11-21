// simple bushing clamp and pipe collar in two parts.
// Used for GPS navigation sleeve on a Yamaha X-MAX: These clamp are
// attached to the rear mirrors on both sided of the steering bar.

// v0.0.1 2016Nov02, Bushmills initial version
// v0.0.2 2016Nov06, Bushmills changed rod from 24mm steel to 16mm carbon fibre
//                             added rod rotation preventing rails, requiring grooves at rod ends

length = 12;                // [1:80]
width = 40;                 // [16:64]
base = 5;                   // [1:0.2:16]
wall = 4;                   // [0.5:0.1:8]
inner = 14;                 // [4:0.1:32]
angle = 230;                // [90:360]
hole = 4;                   // [2:0.1:8]
distance = 28;              // [12:0.1:48]
flap = 12;                  // [0:50]
rod = 16.5;                 // [10:0.1:40]
collar = 12;                // [8:40]
rail = 4;                   // [0:8]

spacing = 5;

block = collar+wall;
outer = inner + 2*wall;
peri  = (inner+wall)/2;
a1    = angle/2;

little = 0+0.01;
$fn = 0+100;


bracket();
translate([0, flap+outer, 0])  bracket();
translate([width/2+spacing, 0, 0])  collar();
translate([width/2+spacing, flap+outer, 0])  collar();


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
translate([0, (base-outer)/2])
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
translate([p, base-(outer-little)/2, length/2])
rotate([90, 0, 0])
cylinder(h=base+little, d=hole);                 // mount holes
}

if (flap)  {
translate([-outer/2, -cos(a1)*peri+flap/2, length/2])
rotate([0, 90, 0])
cylinder(h=outer, d=hole);
}

rotate([-8, 0, 0])
linear_extrude(length)  {
translate([0, (-base-outer)/2])
square([width+little, base], center=true);           // base
}
}
}


module collar()  {
difference()  {
union()  {
cube([width, length, block]);
translate([width/2, length/2, 0])
cylinder(h=block, d=rod+wall);
}

translate([width/2, length/2, wall])
cylinder(h=collar+little/2, d=rod);

for (p =[-1, 1])  {
translate([(width+p*distance)/2, length/2, -little/2])
cylinder(h=block+little, d=hole);                 // mount holes
}
}

translate([width/2, (length-rod)/2, wall])               // rails preventing rotation of rod
rotate([270, 0, 0])
cylinder(h=rod, d=rail);
}
