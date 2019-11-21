$fn = 128;
//How wide a slot should be created (mm)?
PhoneThickness = 10; //  [8,9,10,11,12,13,14,15]

PhoneScale = PhoneThickness/10;
// ignore this variable!

$PhoneYRotate8=-21*1;
$PhoneYRotate9=-19*1;
$PhoneYRotate10=-17*1;
$PhoneYRotate11=-15*1;
$PhoneYRotate12=-14*1;
$PhoneYRotate13=-13*1;
$PhoneYRotate14=-12*1;
$PhoneYRotate15=-11*1;


module horiztorus(){
radius = 8; 
inner_radius = 0; 

bend_radius = 45; 

angle_1 = 10; 
angle_2 = 100; 
                
// torus 
rotate_extrude() translate([bend_radius + radius, 0, 0]) circle(r=radius); 
}
module verttorus(){
radius = 5.5; 
inner_radius = 0; 

bend_radius = 45; 

angle_1 = 10; 
angle_2 = 100; 
                
// torus 
rotate_extrude() translate([bend_radius + radius, 0, 0]) circle(r=radius); 
}

module phonestand(){union() difference(){difference(){translate([22,0,-1]) horiztorus ();translate([-30,-80,-50]) cube([60,160,50]);};translate([0,-80,0]) cube([100,160,40]);}; translate([-20,0,30]) sphere(10);
        difference(){translate ([19,0,-5]) rotate([90,0,0]) verttorus(); translate([-17,-80,0]) cube(160);}translate([0, 40, -8]) sphere(20); translate([0, -40, -8]) sphere(20);
    }; 


module phonestand2(){difference(){phonestand();
        translate([-90,-90,-180]) cube(180);
    }
}
module phoneblock() {difference(){difference (){cube([10,130,40]);difference(){difference(){translate([8,0,0]) cube ([2,130,2]);translate([8,130,2]) rotate ([90,0,0]) cylinder(130,2,2,0);}}}difference(){translate([0,0,0]) cube ([2,130,2]);translate([2,130,2]) rotate ([90,0,0]) cylinder(130,2,2,0);}}}

if(PhoneThickness==8){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate8,0]) phoneblock();}
}
if(PhoneThickness==9){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate9,0]) phoneblock();}
}
if(PhoneThickness==10){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate10,0]) phoneblock();}
}
if(PhoneThickness==11){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate11,0]) phoneblock();}
}
if(PhoneThickness==12){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate15,0]) phoneblock();}
}
if(PhoneThickness==13){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate13,0]) phoneblock();}
}
if(PhoneThickness==14){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate14,0]) phoneblock();}
}
if(PhoneThickness==15){
    difference(){phonestand2();scale([PhoneScale,1,1])translate([-1,-65,2.8]) rotate([0,$PhoneYRotate15,0]) phoneblock();}
}


//phoneblock();
