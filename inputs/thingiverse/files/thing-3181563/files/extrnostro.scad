diam_foro_estr=7.6;
diam_vite_sup=5.5+0.3;
diam_foro_mot=3.5;
h_estr_int=37;
parete_sup_estr=5;
lato_estr=25;

include <threads.scad>;

module roundedBox(size, radius, sidesonly)
{
// Written by Clifford Wolf <clifford@clifford.at> and Marius
// Kintel <marius@kintel.net>
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true,$fn=30);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}


difference(){
    union(){
//base screws        
translate([0,0,-(h_estr_int+parete_sup_estr)/2+3]) difference(){
roundedBox([55,10,6], 3, true);    
translate([45.3/2,0,0]) cylinder(r=3.5/2,h=20,$fn=20,center=true);
translate([-45.3/2,0,0]) cylinder(r=3.5/2,h=20,$fn=20,center=true);
}        
//ext supports
tall=8;
translate([0,0,(h_estr_int+parete_sup_estr+30)/2-tall]) 
    difference(){
rotate([0,0,45]) cylinder(h=30+tall*2, r1=lato_estr/2+sqrt(lato_estr), r2=21*sqrt(2), center=true,$fn=4);
translate([0,31/2,0]) cube([50,15,30+tall*2+2],center=true);     
translate([0,-31/2,0]) cube([50,15,30+tall*2+2],center=true);             
translate([0,0,tall+0.5]) {cube([18,50,31],center=true);        
 cylinder(h=31, r1=25/2, r2=15, center=true);        
}
    }
//extruder body
roundedBox([lato_estr,lato_estr,h_estr_int+parete_sup_estr], 3, true);
    }
//inner screw extruder    
translate([0,0,-parete_sup_estr]) cylinder(h=h_estr_int,r=diam_foro_estr/2,$fn=50,center=true);
translate([0,0,10]) cylinder(h=h_estr_int,r=diam_vite_sup/2,$fn=50,center=true);  
translate([0,-lato_estr/2,4]) rotate([90,0,0]) cylinder(h=lato_estr,r=diam_foro_estr/2,$fn=50,center=true);    
//inlet screw    
translate([0,-3-diam_foro_estr/2,4]) rotate([90,0,0]) english_thread (diameter=1/2+1/25.4,  length=0.5,internal=true);     
}
//NEMA 17 support
translate([0,0,30+(h_estr_int+parete_sup_estr+11)/2])
difference(){
 roundedBox([42,42,11], 5, true);
cylinder(r=15,h=20,center=true);    
translate([31/2,31/2,0])cylinder(r=diam_foro_mot/2,h=20,center=true,$fn=20);       
translate([-31/2,31/2,0])cylinder(r=diam_foro_mot/2,h=20,center=true,$fn=20);   
translate([-31/2,-31/2,0])cylinder(r=diam_foro_mot/2,h=20,center=true,$fn=20);       
translate([31/2,-31/2,0])cylinder(r=diam_foro_mot/2,h=20,center=true,$fn=20);           
}


