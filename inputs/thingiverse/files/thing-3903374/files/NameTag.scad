/* [Base] */
length=45;  //[5:100] 
width=15;   //[3:30] 
height=3;   //[3:5] 
holeRad=height/2; 

/* [text] */
textHeight=2;  //[2:4] 
textSize=6;   //[4:25] 
myColor="blue";
myFont="Liberation Sans"; //[Liberation Mono, Liberation Sans, Liberation Serif] Font
textstr="My Name"; //what would you like to say?

module base() {
   cube([length, width, height], center=true);
  
}



makeTag();
module makeTag() {
    difference() { 
union() {

base();

textExtrude();
}
    holes();
}
}

module holes() {
   translate([-length/2.2,0,0])
    #cylinder(r=holeRad, h=2*height, $fn=36, center=true);
    translate([length/2.2,0,0])
    #cylinder(r=holeRad, h=2*height, $fn=36, center=true);
}


module textExtrude() {
  color(myColor)
        linear_extrude(height=textHeight)
    text(textstr, halign="center", valign="center", size=textSize,font=myFont);  
}