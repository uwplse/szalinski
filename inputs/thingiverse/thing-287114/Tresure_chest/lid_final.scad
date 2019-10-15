$fn=30;
width=100;
depth=100;
height=20;
width1=85;
depth1=85;
height1=25;
width2=100;
depth2=100;
height2=100;
height3=100;
rayon3=50;
width4=10;
depth4=10;
height4=20;
height5=10;
rayon5=4;


//
//Empty space under the half cylinder
//
difference(){
cube([width,depth,height]);
translate([8,8,0])cube([width1,depth1,height1]);
}

//
//Half cylinder that makes the back portion of the lid
//
intersection(){	
translate([-50,20,20])translate([0,-20,0])cube([width2,depth2,height2]);
translate([50,100,20])rotate([90,0,0])cylinder(h=height3,r=rayon3);
}

//
//Half cylinder that makes the front portion of the lid
//
intersection(){	
translate([50,20,20])translate([0,-20,0]) cube([width2,depth2,height2]);
translate([50,100,20])rotate([90,0,0])cylinder(h=height3,r=rayon3);
}

//
//Cylinder makes part of the hinges on the left and cube makes the support from the hinge to the lid
//
translate([-10,0,-10])cube([width4,depth4,height4]);
translate([-5,90,-5])rotate([90,0,0])cylinder(h=height5,r=rayon5);

//
//Cylinder makes part of the hinges on the right and cube makes the support from the hinge to the lid
//
translate([-10,70,-10])cube([width4,depth4,height4]);
translate([-5,20,-5])rotate([90,0,0])cylinder(h=height5,r=rayon5);