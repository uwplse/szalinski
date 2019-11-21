//Tip OD:
TIP=13;
//Mouth OD:
M=200;
//Intermediate ID:
I=20;
//Wall Thickness
T=6;
//Spout Length
S=100;
//Bowl Height
B=200;

$fn=200;

difference(){
    cylinder(h = B, r1 = M, r2 = I, center = true);
    translate([0,0,0])cylinder(h = B+.5, r1 = M-T, r2 = I-T, center = true);
}
difference(){
    translate([0,0,(B/2)+(S/2)])cylinder(h = S, r1 = I, r2 = TIP, center = true);
    translate([0,0,(B/2)+(S/2)])cylinder(h = S+.5, r1 = I-T, r2 = TIP-T, center = true);
}