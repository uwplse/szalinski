// Customizable simple axe head

//Customizer Variables

//axe head back
r= 70; //[1:200]

//resolution
n=100; //[1:200]

//axe head height
h=100; //[1:500]

// handle hole radius
x=25; // 

//scale
s=140; //

// blade lip
l=50;//

// roundness
a=20;//

module chuck(){
	union(){
translate([0,-0.1*r,0])cube([r,0.7*r,h], center = true);
translate([0,0.6*r/2,0])cylinder(h = h, r1 = r/2, r2 = r/2, center = true, $fn=n);
}
}

module chunk(){
hull(){
chuck();
translate([0,s,l/2])cylinder(h = h+l, r1 = 0.1, r2 = 0.1, center = true, $fn=n);
				}
}

module axehead(){
	difference(){
	chunk();	
	translate([0,x*.1,0])cylinder(h = h+l+1, r1 = x, r2 = x, center = true, $fn=n);
	translate([-x,-x*.9,-h/2-1])cube([2*x, x,h+l+1,]);
	}
					}
axehead();
