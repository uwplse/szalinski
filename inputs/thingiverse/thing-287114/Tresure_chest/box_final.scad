$fn=20;
width=100;
depth=100;
height=50;
width1=85;
depth1=85;
height1=45;
width2=12;
depth2=10;
height2=10;
height3=11;
rayon3=6;
height4=11;
rayon4=5;

//
//Cube that makes the main box
//
difference() {
cube([width,depth,height]);
translate([8,8,10])cube([width1,depth1,height1]);
}

//
//support for the hinges
//
translate([-10,30,40])cube([width2,depth2,height2]);
translate([-10,90,40])cube([width2,depth2,height2]);

//
//Union of the left support cube and the left hinge cylinder
//
Union(){
translate([-10,30,40])cube([width2,depth2,height2]);
translate([-5,30,45])rotate([90,0,0])cylinder(h=height3,r=rayon3);
}
//
//Union of the right support cube and the right hinge cylinder
//
Union(){
translate([-10,90,40])cube([width2,depth2,height2]);
translate([-5,90,45])rotate([90,0,0])cylinder(h=height3,r=rayon3);
}

//
//Other part of the hinge on the left, slot for the cylinder on the lid
//
difference(){
translate([-5,30,45])rotate([90,0,0])cylinder(h=height3,r=rayon3);
translate([-5,30,45])rotate([90,0,0])cylinder(h=height4,r=rayon4);
}
//
//Other part of the hinge on the right, slot for the cylinder on the lid
//
difference(){
translate([-5,90,45])rotate([90,0,0])cylinder(h=height3,r=rayon3);
translate([-5,90,45])rotate([90,0,0])cylinder(h=height4,r=rayon4);
}