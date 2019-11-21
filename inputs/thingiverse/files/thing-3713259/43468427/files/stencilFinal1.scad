//-- This script was derived from someoneonly and is licensed under the Creative Commons - Attribution license.
 use </Users/applesucks/Library/Fonts/KGPrimaryPenmanship2.ttf>
 
 /* [Text] */
//Do you want to print a name or just a letter?
p = "name";//[name,letter]
//If you want a single letter, enter the letter here:
t="A";
//Enter the name you want on the stencil here:
print1="Andy";

//Text Size in mm
TS=20;

/* [Please tweak parameters of stencil here] */
//How wide do you want the rectangle around letters?
W=100;
//How tall do you want the rectangle around letters?
H=40;
//How thick do you want the stencil? (in mm)
ST = 2;
//Stencil border on left side of name (in mm)
B=10;
//How high do you want the letters placed? (in mm)
HL=3;




/* [Advanced Tweaking] */
//Vertical
VA="bottom";// Eg top, center, bottom, baseline, or any number
//Horizontal
HA="left";//Eg left, right, center or any number
// Spacing
space=1;
//Text Stretch X
TSX=1;
//Text Stretch Y
TSY=1;
//http://www.kimberlygeswein.com/
//Please thank Kimberly Geswein for the KG font.  She gave me an ok over email to use this font.  KG is very close to the printing style we learn in kindergarten. I've uploaded the font for you to use with opencad(Thingverse customizer will not allow me to upload it). You can add your own font but you are on your own...
Font="Questrial";
//Additional Vertical Spacing between text lines (if they merge for larger fonts)
VS=0;
//Maximum characters in a line
MC=7;

TSMM=TS*3*25.4/72.0;


if(p=="letter"){
    B=3;
    difference(){
translate([0,0,0]){
    cube([W,H,ST]);
}
translate([B,HL,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(t,TSMM,Font,halign=HA ,bottom,spacing=space);
    }
}
}

}
}

if(p=="name"){
difference(){
    
//STENCIL
translate([0,0,0]){
cube([W,H,ST]);
}

//TEXT
translate([B,HL,0]){
linear_extrude(height=ST+0.1){
scale([TSX,TSY,ST]){
text(print1,TSMM,Font,halign=HA ,valign=VA,spacing=space);
    }
}
}


}
}


