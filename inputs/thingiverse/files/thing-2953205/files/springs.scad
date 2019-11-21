// simple spring Glyn Cowles June 2018
// Internal hole for bolt
holeDiam=5; 
// Width of spring
width=14;
// Height of spring
height=13; 
// Thickness
th=1.5; 
// Overall length
length=20; 
// Number of links
n=2; 
// Add extra flaps at ends to aid adhesion
brim=1; // [1:True,0:False]
// Resolution
$fn=50; 

cDiam=(length+(2*n-1)*th)/(2*n);
echo (cDiam);
connector=width-cDiam;
//--------------------------------------------------------------
difference() {
    linear_extrude(height) main();
    #translate([connector/2,0,height/2]) rotate([90,0,180]) cylinder(d=holeDiam,h=length);
}
if (brim) {
translate([-cDiam/2,-width/2,0]) cube([width,width/2,.4]);
translate([-cDiam/2,length,0]) cube([width,width/2,.2]);
}
//--------------------------------------------------------------
module main() { 
for (i=[0:n-1]) {
translate([0,i*((cDiam-th)*2)+cDiam/2]) link1();
}
eb=cDiam/3; // extra bit
translate([-eb,(n)*(cDiam-th)*2]) square([connector+eb,th]);
translate([0,0]) square([connector+eb,th]);
}
//--------------------------------------------------------------
module halfCircle(diameter, th) {
	difference(){
		circle(d = diameter);
		circle(d = diameter - th*2);
        translate([0,-diameter/2-th/2]) square([diameter,diameter+th]);
	}
}
//--------------------------------------------------------------
module link0() {
    halfCircle(cDiam,th);
    translate([0,-cDiam/2]) square([connector,th]);

}
//--------------------------------------------------------------
module link1() {
    link0();
    translate([connector,cDiam-th])rotate([180,0,180])  link0();
}
//--------------------------------------------------------------
