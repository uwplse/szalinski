/* [Configuration ] */
//Length
l=25.8;
//Breadth
b=9.3;
//Width
w=10.5;
//Length thickness of walls
lt=1.5;
//Breadth thickness of walls
bt=1.25;

/* [Text] */
//Text
text="";
//Text Size
TS=5;
//https://www.google.com/fonts [eg Liberation Sans:style=Bold Italic]
FONT="Times New Roman";

/* [Advanced Text] */
// Text Spacing
space=1;
//Text Stretch X
tx=1;
//Text Stretch Y
ty=1;
//Text Rotation[in degrees]
tr=0;
//text x offset
txo=0;
//text y offset
tyo=0;

/* [Expiermental] */
//Text Tiwst
tt=0;
//Resolution of file
$fn = 200;
//Vertical Text Alignment
VA="center";// Eg left, right, center, or any number
//Horizontal Text Alignment
HA="center";//Eg top, center, bottom, baseline, or any number

difference(){

difference(){
    cube([l,b,w]);
    translate([lt,bt,-0.1]){
    cube([l-lt*2,b-bt*2,w+0.2]);
    }
}

//TEXT
translate([l/2+txo,lt-0.1,w/2+tyo]){
rotate([90,tr,0]){
linear_extrude(height=lt,twist=tt){
scale([tx,ty,1]){
text(text,TS,FONT,halign=HA ,valign=VA,spacing=space);
    }
}
}
}

}