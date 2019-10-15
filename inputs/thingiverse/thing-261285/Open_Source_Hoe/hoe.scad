// Customizable simple hoe head

//Customizer Variables

//axe head back
r= 60; //[1:200]

//resolution
n=100; //[1:200]

//hoe head height
h=20; //[1:500]

// handle hole radius
x=25; // 

//scale LENGTH OF HOE
s=150; //

// base blade thickness
b=30;//

// blade width
w=120;

l=50;

module chuck(){
	union(){
translate([0,-0.1*r,0])cube([r,0.7*r,h], center = true);
translate([0,0.3*r/2,0])cylinder(h = h, r1 = r/2, r2 = r/2, center = true, $fn=n);
}
}

module chunk(){
chuck();
hull(){
cylinder(h = h, r1 = b, r2 = b, center = true, $fn=n);
translate([0,s,-h/2])rotate([0,90,0])cylinder(h = w, r1 = 0.1, r2 = 0.1, center = true, $fn=n);
				}
}

module hoe(){
	difference(){
	chunk();	
	translate([0,x*.1,0])cylinder(h = h+l+1, r1 = x, r2 = x, center = true, $fn=n); //HANDLE HOL
	translate([-x,-x*.9,-h/2-1])cube([2*x, x,h+l+1,]); //SQUARE HANDLE HOLE
	}
					}
hoe();
