/*
Parametric endmill index/holder.
Copyright (C) 2019 David H. Brown

https://www.thingiverse.com/thing:3882481

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License
http://creativecommons.org/licenses/by-nc-sa/4.0/

*/

// Vector of vectors of: [tip diameter, shaft diameter, cutting length, total length]
endmills = [ 
    [2,6,7,51],
    [3,6,8,52],
    [4,6,11,55],
    [5,6,13,57],
//    [6,6,13,57], // nominal
    [6,6,19,60], // actual
    [7,8,19,63],
    [8,8,19,63],
    [9,10,22,72],
    [10,10,22,72],
    [12,12,26,83]
];
/* [Holder geometry] */
// Thickness of exterior walls
wall = 1; //[0.4:0.05:2.5]
// Added to shaft and tip diameters to ensure they fit
clearance = 0.4; // [0:0.1:1]
// Thickens the ridges that help the mills snap in. Set to -clearance if you want no ridges.
interference = 0.2;  //[-1:0.1:1]
// the slope leading to the bottom recess. 270 degrees would be flat and not usable.  
insertion_angle=290; // [280:5:330]
/* [Label text] */
// Thickness of the text labels. Set to 0 if you don't want any
text_extrude=0.5; // [0:0.1:1]
// The text is scaled to the shaft diameter which determines the available width
text_scale = 1; // [0.25:0.05:1.25]
// If the tip size needs multiple characters, set this < 1 to squish them together
text_spacing = 0.75; // [0.5:0.05:1.1]
// If this font isn't available (must install for all users on Windows), try "Liberation Sans:style=Bold" 
font = "Roboto Condensed:style=Bold";
/* [Hidden] */
$fn=72;
fudge=0.01;
endmill_count = len(endmills);
//index names for the endmill vectors: 
iTip=0;
iShaft=1;
iCut=2;
iLength=3;
//function findTotalWidth(v, i) = (i == 0 ? v[i][2] + wall + wall :
//    v[i][2] + wall + findTotalWidth(v,i-1) ) ;
//total_width = findTotalWidth(endmills, endmill_count-1);
//max_shaft = max([for(i = endmills) i[1]]);
//max_length = max([for(i = endmills) i[3]]);
module holder(endmill) {
    shaft = endmill[iShaft];
    yip = wall+clearance+shaft*2;// Y insertion point just past covering lip
    insertion_length = 2*yip + yip * sin(insertion_angle);
    xmid = wall+(shaft+clearance)/2; // X middle
    ridge_length=min([6,shaft]);
    
    union(){
       difference(){
            cube([shaft+2*wall+clearance,endmill[iLength]+2*wall+clearance*2,shaft*1.5+wall]);
        color("silver") {
            // shaft:
            translate([xmid,wall,shaft]) rotate([270,0,0]) cylinder(d=shaft+clearance,h=endmill[iLength]-endmill[iCut]);
            // tip:
            translate([xmid,wall,shaft]) rotate([270,0,0]) cylinder(d=endmill[iTip]+clearance,h=endmill[iLength]+clearance*2);
        } //silver for the taps themselves
       color("blue") intersection(){ //recessed area
               translate([wall,wall,wall]) cube([shaft+clearance,shaft*2,shaft]);
               translate([wall,yip,shaft]) rotate([insertion_angle,0,0]) translate([0,0,-insertion_length]) mirror([0,1,0]) union(){
                       translate([(shaft+clearance)/2,0,0]) cylinder(d=shaft+clearance,h=insertion_length);
                       cube([shaft+clearance,yip,insertion_length]);
                   } //union
           } // intersection; blue for the space to push down on the bottom end
    color("cyan") intersection() {
        translate([wall,wall,wall]) cube([shaft+clearance,endmill[iLength],shaft*1.5+wall+clearance]);
    translate([wall+(shaft+clearance)/2,yip,shaft]) rotate([insertion_angle,0,0]) translate([0,0,-shaft]) cylinder(d=shaft+clearance,h=shaft*2);
        }
       color("green") {
           // tip and most of shaft:
           translate([wall,yip,shaft]) cube([endmill[iShaft]+clearance,endmill[iLength]-(endmill[iShaft]*2)+clearance,endmill[iShaft]+wall+clearance]);
           // a square bit at the bottom:
           translate([wall,wall,endmill[iShaft]]) cube([endmill[iShaft]+clearance,endmill[iShaft]+clearance,endmill[iShaft]+wall+clearance]);
           
       } // green for being open above the endmills except where covered
       color("magenta") translate([wall+shaft/4+clearance/2,yip-shaft-clearance,wall+shaft]) cube([shaft/2,shaft+clearance*2,shaft*1.5+2*wall]);
       color("red") translate([xmid,wall/2,shaft/2+wall]) rotate([270,0,0]) {
           cylinder(d=shaft*3/4,h=wall+fudge,center=true);
           translate([0,-shaft/2,0]) cube([shaft*3/4,shaft+fudge,wall+fudge],center=true);
       }
        }//difference
        //ridges to help secure shaft in slot
        color("black") translate([0,wall+clearance+(yip+endmill[iLength]-endmill[iCut]-ridge_length)/2,shaft+wall]) {
            for(x=[wall,wall+shaft+clearance])
            translate([x,0,0]) rotate([270,0,0]) cylinder(d=clearance+interference,h=ridge_length);
        }
        // tip size label
        // as of version 2019.05, there is a glitch in centering: https://github.com/openscad/openscad/issues/3081
       // multiplying xmid*0.85 tries to compensate a bit
        label_text = str(endmill[iTip]);
        label_spacing = len(label_text) == 1 ? 1 : text_spacing;
        label_x = xmid*len(label_text) == 1 ? 1 :label_spacing/1.2;
       color("orange") translate([xmid*0.85,endmill[iLength]+2*wall+clearance*2,shaft*1.5]) rotate([270,0,0]) linear_extrude(text_extrude) text(label_text, size=shaft*text_scale, halign="center", font=font, spacing=label_spacing);
    }//union
}
function holderX(i) = (i == 0 ? 0 : endmills[i-1][iShaft]+wall+clearance + holderX(i-1));
    
for(i=[0:endmill_count-1]) {
    translate([holderX(i),0,0]) holder(endmills[i]);
}//for endmills