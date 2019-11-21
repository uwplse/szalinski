// Customizable simple horsehoe

//Customizer Variables

//radius of sphere
r= 50; //[1:200]

//resolution
n=100; //[1:200]

//height
h=12; //[1:100]

// nail hole size
x=2.3; // 

//scale
s=1.5; //

//scale lip
t=0.7; //

//scale lip 2
u=1.1; //

module main(){
	difference(){
difference(){
scale([1.0,s,1.0])cylinder(h = h, r1 = r, r2 = r, center = true, $fn=n);
scale([t,u,1.0])cylinder(h = h+1, r1 = r, r2 = r, center = true, $fn=n);}
	rotate([0,0,45])translate([-r,-r,0])cube([2*r,2*r,h+1], center = true);}
}

module divot(){
		difference(){
	difference(){
difference(){
scale([.9,1.45,.9])cylinder(h = h, r1 = r, r2 = r, center = true, $fn=n);
scale([0.8,1.35,1.0])cylinder(h = h+1, r1 = r, r2 = r, center = true, $fn=n);}
rotate([0,0,45])translate([-0.8*r,-0.8*r,0])cube([2*r,2*r,h+1], center = true);}
rotate([0,0,45])translate([1.4*r,1.4*r,0])cube([2*r,2*r,h+1], center = true);}
}

difference(){
main();
translate([0,0,0.7*h])divot();
translate([-0.85*r,0,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([0.85*r,0,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([-0.83*r,.3*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([0.83*r,.3*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([-0.83*r,-.3*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([0.83*r,-.3*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([-0.77*r,.6*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([0.77*r,.6*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([0.675*r,.85*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
translate([-0.675*r,.85*r,0])cylinder(h = h+1, r1 = x, r2 = x, center = true, $fn=n);
}