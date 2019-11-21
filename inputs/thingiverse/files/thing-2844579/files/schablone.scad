/* This file is free software and comes with NO WARRANTY -
 * --- GPL-v2 --- read the file
 * COPYING for details  
 * 03/2018 M. Hoffmann crated this little piece of software 
 * 04/2018 improved (MH) */

/* TODO: 
   * make a list of widths for the letters (proportional font):
     This can be extracted out of the .ttf files.
   * Find more line-fonts.
*/

/* If you want to use custom fonts, declare the files with the use statement.*/

//use <fonts/A.ttf>

/* [Main Dimensions] */

// Height of the labels (mm)
labelheight=0.3;         // [0:0.8]

// size of the molts
schiene=31.75; 

// Size of the letters (8...20)
size=18;         // [8:20]

//  Font name and style to be used
font="Courier New:style=Standard";  

// thickness of the plates (mm)
thickness=2;    // [1:3]

// engraving depth of the letters (mm)
depth=1;

/* [What to be performed] */

// Action: Which set of 15 letters to make  
doaction=0;  // [0,1,2,3,4,5,6,7,8,9]

/* [Hidden] */

// Tolerance (smallest value) (mm)
eps=0.1;         // [0.1:0.3]
arelation=0.8;



if(doaction==0) {
  text="Hello World ! ;-) ";
  for(y=[-1:1]) { for(x=[-2:2]) {
    translate([size*1.05*x,schiene*1.05*y,0]) doletter(size,font,text[x+2+(1-y)*6]);
  } }
} else if(doaction==7) {
/* Make special charackters */
  text="{|}~µ €ŋħĸ¢ »«„“”";
  for(y=[-1:1]) { for(x=[-2:2]) {
    translate([size*1.05*x,schiene*1.05*y,0]) doletter(size,font,text[x+2+(1-y)*6]);
  } }
} else if(doaction==8) {
/* Make german special charackters */
  text="ÄÜÖßµ äüö{} ¢€æç|";
  for(y=[-1:1]) { for(x=[-2:2]) {
    translate([size*1.05*x,schiene*1.05*y,0]) doletter(size,font,text[x+2+(1-y)*6]);
  } }
} else if(doaction==9) {
/* Make some of the most used charackters */
  text="eeenn ttaar riisshhrr";
  for(y=[-1:1]) { for(x=[-2:2]) {
    translate([size*1.05*x,schiene*1.05*y,0]) doletter(size,font,text[x+2+(1-y)*6]);
  } }
} else {
  for(y=[-1:1]) { for(x=[-2:2]) {
    translate([size*1.05*x,schiene*1.05*y,0]) doletter(size,font,chr(19+x+1+(y+1)*5+15*doaction));
  } }
}

/* Erstellt einen Buchstaben */
module doletter(size,font,char) {
  difference() {
    union() {
      /* make the plate */
      linear_extrude(height=thickness, scale=[1,1-thickness/schiene])  translate([-size/2,-schiene/2])  square([size,schiene]);
      /* mark the baseline*/
      translate([-size/2,-size/2,0]) cube([size,0.5,thickness+labelheight]);
      /* Label the plate*/
      translate([0,size/2+1.5,0])
      linear_extrude(height=thickness+labelheight, scale=1) {
        color([0,0,0]) text(str(font[0],font[1],font[2],font[3],font[4],font[5],font[6]),font="Arial",size=4, halign="center");
      }
      translate([size/2-4,-size/2-5,0])
      linear_extrude(height=thickness+labelheight, scale=1) {
        color([0,0,0]) text(str(size),font="Arial",size=4, halign="center");
      } 
    }
    translate([0,0,thickness-depth])  
    # minkowski() {
      linear_extrude(height=eps, scale=1) {
        translate([0,-size/2])  text(char,font=font,size=size, halign="center", valign="baseline");
      } 
      union() {
        cylinder(h=depth,r1=0,r2=arelation);
        translate([0,0,depth]) cylinder(h=labelheight+eps,r=arelation);
      }
    }
  }
}