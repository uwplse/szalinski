//BY DOWNLOADING, OPENING AND/OR USING THIS WORK YOU AGREE TO THE TERMS AND CONDITIONS CONTAINED AT THE END OF THIS FILE.

resolution = 65; //[20:Low, 65:Medium, 200:High]

//Length of the clamping face for the clip.
length=60;

//Width of the clip.
width=14; //12.75

//Width of the clamping studs.
studwidth=2.5;

//Height of the clamping studs.
studheight=2;

//Thickness of clamp arms.
thickness=3;

//Sealing gap.
gap=2.5; //0.4

//Screw hole size for hinge.
hole=3.75;

//Countersinking.
screwtop=6;

//Clip thread for screw.
thread=2.75;

//Hand grips. Makes opening clips easier.
grip=1; //[0:No Grip, 1:Grip]

//Spliting for printing. 0=All, 1=Base, 2=Top.
display=0; //[0:All, 1:Base, 2:Top]

$fn=resolution;

lift=0;

if (display==0||display==1) {
translate([length,0,0]) cube([thickness,width,thickness]);

translate([length+thickness/2,0,thickness/2]) cube([thickness,width,thickness*1.875+studheight+gap]);

hull() {
translate([length+thickness/2,0,thickness*2.375+studheight+gap]) rotate([-90,0,0]) cylinder(width,thickness/2,thickness/2);
    
translate([length+thickness,0,thickness*2.375+studheight+gap]) rotate([-90,0,0]) cylinder(width,thickness/2,thickness/2);
}

translate([length+thickness,0,thickness/2]) rotate([-90,0,0]) cylinder(width,thickness/2,thickness/2);

//base//
cube([length,width,thickness]);

//base studs
translate([0,0,0]) cube([length,studwidth,thickness+studheight]);
translate([0,width-studwidth,0]) cube([length,studwidth,thickness+studheight]);

//hindge cylinder base
translate([-thickness*2,0,thickness+studheight/2+gap/2]) rotate([-90,0,0]) {
difference() {
cylinder(width/2,thickness+studheight/2+gap/2,thickness+studheight/2+gap/2);
cylinder(width,hole/2,hole/2);
cylinder(width/4,screwtop/2,hole/2);
}
}

//hinge bridge
translate([-thickness*2,0,0]) {
difference() {
cube([width,width/2,thickness]);
translate([0,0,thickness+studheight/2+gap/2]) rotate([-90,0,0])
cylinder(width/2,thickness+studheight/2,thickness+studheight/2);
}
}
}

if (display==0||display==2) {
//top//
translate([0,0,thickness+studheight+gap+lift]) {
cube([length,width,thickness]);

//top stud
translate([0,width/4+gap,-studheight]) 
cube([length,width/2-gap*2,thickness+studheight]);
}


//hindge cylinder top
translate([-thickness*2,width/2,thickness+studheight/2+gap/2+lift]) rotate([-90,0,0]) {
difference() {    
cylinder(width/2,thickness+studheight/2+gap/2,thickness+studheight/2+gap/2);
cylinder(width,thread/2,thread/2);
}
}
   
//hinge bridge
translate([-thickness*2,width/2,0]) {
difference() {
translate([0,0,thickness+studheight+gap+lift]) cube([width,width/2,thickness]);
translate([0,0,thickness+studheight/2+gap/2+lift]) rotate([-90,0,0])    cylinder(width/2,thickness+studheight/2,thickness+studheight/2);
}
}

translate([length,0,thickness*1.5+studheight+gap+lift]) rotate([-90,0,0]) cylinder(width,thickness/2,thickness/2);

if (grip==1) {
hull() {
translate([length/1.75,thickness/2,thickness+studheight+gap+lift]) cylinder(thickness,thickness/2,thickness);
translate([length/1.25,thickness/2,thickness+studheight+gap+lift]) cylinder(thickness,thickness/2,thickness);
}

hull() {
translate([length/1.75,width-thickness/2,thickness+studheight+gap+lift]) cylinder(thickness,thickness/2,thickness);
translate([length/1.25,width-thickness/2,thickness+studheight+gap+lift]) cylinder(thickness,thickness/2,thickness);
}
}
}

//License Conditions 

//Rights: 
//Save and privately distribute modified copies for the sole purpose of convenience, provided the license remains included and unmodified. 
//Use this design in a commercial setting provided it is on a single case basis. 
//Review the code and values for learning purposes. 
//Display this design in a public setting provided the appropriate attributions are included and clearly visible. 

//Conditions (without prior written permission): 
//Sell, gain profit from or relicense this design in any format or by any means, commercially or otherwise. 
//Directly copy sections of code for any other project or design. 
//Publicly redistribute or host this file. 
//The design owner can revoke all rights at any time, including all use, for any reason. Sorry.