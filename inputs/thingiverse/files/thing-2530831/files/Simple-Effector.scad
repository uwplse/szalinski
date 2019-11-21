//BY DOWNLOADING, OPENING AND/OR USING THIS WORK YOU AGREE TO THE TERMS AND CONDITIONS CONTAINED AT THE END OF THIS FILE.

Resolution=60; //[30:Low, 60:Medium, 120:High]

Display=0; //[0:All, 1:Effector, 2:Mount]

//Main body height.
Height=8;

//Main body diameter.
Body=38;

//Hotend upper section diameter.
Hotend=16;

//Hotend groove mount.
Hotend_Mount=12;

//Hotend mount hole size.
Mount_Size=3.4;

//Hotend mount configuration.
Mount_Configuration=60;  //[60:Six, 120:Three, 180:Two]

//Clamp body height.
Clamp_Height=5.2;

//Clamp body diameter.
Clamp_Body=32;

//Rod offset.
Rod_Offset=24;

//Ball joint mount thread size.
BallMount=3;

//Ball joint offset.
Ball_Joint=42;

/* [Hidden] */

//Cable Pass
Include_Cable_Pass=false;

Cable_Pass=5;

$fn=Resolution;


//Main Body//
if ( Display == 0 || Display == 1) {
difference() {
color("Orange") union() {
cylinder(Height,Body/2,Body/2,true,$fn=Resolution*3);

for ( i = [60:120:359]) {
//Main Intersection
intersection() {
cube([Body*2,Body*2,Height],true);

rotate([0,0,i]) {
difference() {
union() {   
//Ball Joint Mount
translate([+Ball_Joint/2-2,Rod_Offset,0])
rotate([0,90,0])
cylinder(4,11.575/2,5/2,true);

//Ball Joint Mount
translate([-Ball_Joint/2+2,Rod_Offset,0])
rotate([0,90,0])
cylinder(4,5/2,11.575/2,true);

//Mount Barrel
translate([0,Rod_Offset,0])
rotate([0,90,0])
cylinder(Ball_Joint-8,11.575/2,11.575/2,true);

//Mount Support
translate([0,Rod_Offset-7,0])
cube([24,12,Height],true);
}

//Ball Joint Mount Thread
translate([0,Rod_Offset,0])
rotate([0,90,0])
cylinder(Ball_Joint+1,BallMount/2,BallMount/2,true,$fn=Resolution/2);
}
}
}
}
}

//Main Difference
cylinder(Height+1,Hotend/2,Hotend/2,true);

for (i=[-30:Mount_Configuration:359-30]) {
rotate([0,0,i])
translate([12.5,0,0])
cylinder(Height+1,Mount_Size/2,Mount_Size/2,true,$fn=Resolution/2);
}

//Cable Pass
if ( Include_Cable_Pass == true )
translate([0,-16,0])
cylinder(Height+1,Cable_Pass/2,Cable_Pass/2,true);

}
}

//Hotend Groove Mount
if ( Display == 0 || Display == 2) {
translate([0,0,-Height/2-Clamp_Height/2]) {
color("MidnightBlue") difference() {
hull() {
translate([0,0,Clamp_Height/2])
cylinder(0.0001,Body/2,Body/2,true,$fn=Resolution*3);
    
translate([0,0,-Clamp_Height/2])
cylinder(0.0001,Clamp_Body/2,Clamp_Body/2,true,$fn=Resolution*3);
}

hull() {
//Hotend Groove Difference
cylinder(Clamp_Height+1,Hotend_Mount/2,Hotend_Mount/2,true);
    
translate([0,-20,0]) 
cylinder(Clamp_Height+1,Hotend_Mount/2,Hotend_Mount/2,true);
}
    
translate([0,-Body/2+3,0]) 
cube([Clamp_Body,8,Clamp_Height+1],true);

//Hotend Mount
for (i=[-30:Mount_Configuration:359-30]) {
rotate([0,0,i])
translate([12.5,0,0])
cylinder(Height+1,Mount_Size/2,Mount_Size/2,true,$fn=Resolution/2);
}
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