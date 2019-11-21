//Cusomizable SeeJ flag by Mark G. Peeters 7-24-2014
//Notes: the text is resized to fit the flag, so keep the message short, initial, a single word etc. I have uploaded this in these places:
// https://www.youmagine.com/designs/customizable-seej-battle-flag
// http://www.thingiverse.com/thing:406884
// make sure to download the off set base too since the letters make the flag heavier you should use the offset base so it will not topple over due to the heavier flag.
//full original Seej 2013 files are here: http://www.thingiverse.com/thing:116450
//
// preview[view:south, tilt:top diagonal]

use<write/Write.scad>
//NOTE: Do not use too many letters, they will get too small to print legibly.
initials="M G P";
//ONLY USE for descending lowercase letters(like y,g,p,etc), this will move the text up so they are not cut off. BUT if you do not have descending lower case letters then this will cut the tops off.
loweryes=0;//[0:NO descending lowercase,1:descending lowercase letters]
//zero for no lowers, 1 for lower case letters use 0.2*y-dimension translation
//Choose your font
font = "Letters.dxf";//[write/Letters.dxf:Letters, write/BlackRose.dxf:Black Rose, write/knewave.dxf:Knewave, write/orbitron.dxf:Orbitron]



/* [Advanced] */
//how tall is the flag in mm
flag_height=10;
//radius for the curve, don't go crazy
flag_radius=6;
//how thick is the flag in mm
flag_thick=1.2;
//the letters will just be 0.8 flag thick

/* [hidden] */
textadjust =(loweryes==0)? 0 : 0.2;//if-then to set value of textadjust, used to move text up to keep lower case letter from being chopped off
$fn=100;
fod=flag_radius+flag_thick;//flag outer radius
fid=flag_radius;//flag inner raduis
movr=(fid+fod)*cos(45);

//flag body
difference(){
union(){
translate([-7,5.5,0])cylinder(h=flag_height,r=5);
translate([-7,5.5,flag_height])cylinder(h=2,r1=5,r2=2);
color("blue")translate([0,0,0])sinwave(fid,fod,flag_height);
}//end union
translate([-8.5,4,-2])cube([3.1,3.1,flag_height+4]);
translate([movr*3.4,0,flag_height/2])rotate([0,45,0])cube([3,10,3]);
translate([movr*3.4,0,flag_height/6])rotate([0,45,0])cube([3,10,3]);
translate([movr*3.4,0,flag_height/1.2])rotate([0,45,0])cube([3,10,3]);
}//end diff

//add text front
translate([0,-flag_thick*.8,0])
difference(){
translate([0,fod,textadjust*flag_height])rotate([90,0,0])resize([movr*3.4,flag_height,0])write(initials,h=flag_height,t=fod,font=font);
//part to trim front text
sinwave_cutout(fid,fod,flag_height);
}//end diff

//add text back
translate([0,flag_thick*.8,0])
difference(){
//translate([(fid+fod)*cos(45)*3.5,(fid+fod)*cos(45)-fid-monogram_thick,0])
translate([movr*3.4,0,textadjust*flag_height])rotate([90,0,180])resize([movr*3.4,flag_height,0])write(initials,h=flag_height,t=fod,font=font);
//part to trim front text
sinwave_cutout(fid,fod,flag_height);
}//end diff

//modules----------------------------------
module sinwave(fid,fod,flag_height){//this is the flag sin shape
movr=(fid+fod)*cos(45);
circqr(fid,fod,flag_height,45);
translate([movr,movr,0])circqr(fid,fod,flag_height,45+180);
translate([movr*2,0,0])circqr(fid,fod,flag_height,45);
translate([movr*3,movr,0])circqr(fid,fod,flag_height,45+180);
}//end mod sinwave

module sinwave_cutout(fid,fod,flag_height){//this is a cube with sine carved out used to trim text
movr=(fid+fod)*cos(45);
difference(){
translate([-fod*1.5,-fod/3,-flag_height*0.5])cube([fod*7,fod*2,flag_height*2]);
sinwave(fid,fod,flag_height);
}//end diff
}//end mod sinwave_cutout

module circqr(rin,rout,height,rot){//this is the 1/4 part of cylinders used to make flag shape
rotate([0,0,rot])difference(){   //diff1
cylinder(h=height,r=rout);
translate([0,0,-1])cylinder(h=height+2,r=rin);
translate([0,0,-1])difference(){    //diff2
translate([-rout,-rout,0])cube([rout*2,rout*2,height+2]);
rotate([0,0,1])cube([rout,rout,height+2]);
rotate([0,0,-1])cube([rout,rout,height+2]);}//end diff2
}//end diff1
}//end module