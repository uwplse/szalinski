/* [Global] */

// Enter the width of your filament roll
width = 60;

/* [Hidden] */

// Between end and filament ring
fil = 5;
// Lenght of holder
length = width+2*(1+3+fil+3);

$fn=144;

/* [Global] */


difference() {
cylinder( h=length, r=25/2, center=false );
cylinder( h=length, r=21/2, center=false );
}
difference() {
cylinder( h=3, r=28/2, center=false );
cylinder( h=3, r=21/2, center=false );
}
translate([0,0,1.5])
rotate_extrude(convexity = 10 ){ 
translate([14,0,0])
circle(r=1.5 );
}
difference() {
cylinder( h=1.5, r=31/2, center=false );
cylinder( h=1.5, r=21/2, center=false );
}
translate([0,0,3+fil])
difference() {
cylinder( h=3, r=26/2, center=false );
cylinder( h=3, r=21/2, center=false );
}
translate([0,0,3+fil+1.5])
rotate_extrude(convexity = 10 ){ 
translate([13,0,0])
circle(r=1.5 );
}
translate([0,0,length-3])
difference() {
cylinder( h=3, r=28/2, center=false );
cylinder( h=3, r=21/2, center=false );
}
translate([0,0,length-1.5])
rotate_extrude(convexity = 10 ){ 
translate([14,0,0])
circle(r=1.5 );
}
translate([0,0,length-1.5])
difference() {
cylinder( h=1.5, r=31/2, center=false );
cylinder( h=1.5, r=21/2, center=false );
}
translate([0,0,length-3-fil-3])
difference() {
cylinder( h=3, r=26/2, center=false );
cylinder( h=3, r=21/2, center=false );
}
translate([0,0,length-3-fil-1.5])
rotate_extrude(convexity = 10 ){
translate([13,0,0])
circle(r=1.5 );
}