//Variables de creacion.
Longitude=30; // [20:30]
rad_wrist=3; // [2:6]
rad_elbow=6; // [4:10]
thick=1; // [0.5:5]
rjoint=2; // [0.5:4]
Rarm=5; // [5:30]

module Shell(L,r_w,r_e,thick,rj){
difference() {
	translate([0,-L+rj+2,0])rotate([-90,0,0]) cylinder(L,r_w+thick,r_e+thick);
	translate([0,-L+rj+1.9,0])rotate([-90,0,0]) cylinder(L+0.5,r_w,r_e);
}}

//Cono hueco;
//Creamos un cono exterior con un grosor añadido y le quitamos el cono interior.
//Shell(Longitude,rad_wrist,rad_elbow,thick);

//Cortamos por la mitad

/*difference(){
	Shell(Longitude,rad_wrist,rad_elbow,thick,rjoint);
	translate([0,-70,-20])cube([50,100,50]);
	translate([10,0,0])rotate([0,-90,0]) cylinder(20,rjoint,rjoint);
	translate([10-rad_wrist-thick,2,-20])cylinder(50,10,10);
}*/

//translate([rad_wrist+thick+2,2,-40])cylinder(80,10,10);

module Shelly(L,r_w,r_e,thick,rj,rspatial){
	difference(){
		Shell(L,r_w,r_e,thick,rj);
		translate([0,-70,-20])cube([50,100,50]);
		translate([10,0,0])rotate([0,-90,0]) cylinder(20,rjoint,rjoint);
		translate([rspatial-rad_wrist-thick,2,-20])cylinder(50,rspatial,rspatial);
	}
}

Shelly(Longitude,rad_wrist,rad_elbow,thick,rjoint,Rarm);
