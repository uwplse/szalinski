//customizable paint roller by Mark G. Peeters, 5-24-14
//posted here
//http://www.thingiverse.com/thing:341577
//modified from idea shared by LPFP
//http://www.instructables.com/id/Paint-roll-hack-Text-and-massage-customised-3D
//http://www.thingiverse.com/thing:47372
//have fun!!!


use<write/Write.scad>

//NOTE: ALL units are in millimeters (mm) even font sizes
RollerText="Live Your Life!";
//size for the letters and numbers-still in millimeters
FontSize=12;
// how tall are letters and numbers , suggest between 2mm and 4mm
TextHeight=2;
//Choose your font
font = "Letters.dxf";//[write/Letters.dxf:Letters,write/BlackRose.dxf:Black Rose,write/braille.dxf:Braille,write/knewave.dxf:Knewave,write/orbitron.dxf:Orbitron]

//don't make roller taller your printer height
RollerLength=120;//[10:300]
RollerDiameter=37;
RollerRadius = RollerDiameter/2;
// radius for spindle hole diameter,
SpindleDiameter=5;
HoleRadius = SpindleDiameter/2;


/* [Advanced] */


//Letter spacing you want?
Letter_Spacing=12;//[6:20]
space=Letter_Spacing/10;
//Do you want more space between the lines of text?
Line_Pad=0;
//what angle should the text be on the roller, tilt it a little since 90 is harder to roll
TextAngle=70;


/* [hidden] */
cord=FontSize*1.3+Line_Pad;//allow for different lowercase desenders and font capitals
rfortheta=RollerRadius+TextHeight;//i am using the outer circle for cutting 
theta=2*asin(cord/(2*rfortheta));//max theta
repeats=floor(360/theta);//round down to whole number of repeats
goodtheta=360/repeats;//symetry is good
dup_angle=goodtheta;

difference(){
// make core and write on a cylinder 
union(){
for (i = [0:repeats-1]) {
color("blue")
cylinder(r=RollerRadius,h=RollerLength,center=true); 
writecylinder(RollerText,h=FontSize,t=RollerDiameter,[0,0,0],radius=-RollerRadius,height=RollerLength,rotate=TextAngle,space=space,font=font,east=dup_angle*i,center=true);
}//end loop
}//end core union

//remove hole for spindle
cylinder(r=HoleRadius,h=RollerLength+50,center=true,$fn=50);

//make trim shell to get smooth outer layers
difference(){
cylinder(r=RollerDiameter*1.5,h=RollerLength+45,center=true);
cylinder(r=rfortheta,h=RollerLength+50,center=true,$fn=100);
}//end trim shell diff
//*/
}//end difference