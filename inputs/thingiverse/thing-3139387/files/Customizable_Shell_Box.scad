// This makes a box for 12 gauge shells. The width of box (w) can be changed for either 3.5 inch magnum shells (97MM), or 2.75 inch shells (78MM). The box can also be changed into any dimension needed. The 3MM walls will stay that thickness.
// All of these dimensions are in MM.

//Box frame for shells
$fn=100;
l = 115; //overall length in X direction
w = 84; //76.2MM shells, with 3MM walls, (97mm for 3.5 inch mags), (78mm for 2.75 inch shells)
h = 110; //height of box (22mm per row of shells.)
l2 = l-6;
w2 = w-6;
h2 = h-3;
difference(){
    translate([0,75,0])cube([l, w, h], center = true);
    translate([0,075,3])cube([l2,w2,h2], center = true);
}
//LID Code
L = l+7;
W = w+7;
H = 15;
difference(){
    rotate([90,0,0])translate([-l/2,-h/2,0])cube([L,W,H]);
    rotate([90,0,0])translate([(-l/2)+3,(-h/2)+3,3])cube([l,w,h]);
} 