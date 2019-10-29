// 3D Name Ruler
// by RyanPetroff for Maker Academy
// Free as in Freedom! CC-BY-SA
// Official page: http://www.thingiverse.com/thing:1599421
// This is a remix of customizable ruler by Stu121, CC-BY-SA, http://www.thingiverse.com/thing:109739

// Welcome to OpenSCAD! 
// This will serve as an introduction to using code to generate 3D models. Code is basically a superpower.
// This code will help you generate a ruler with your name on it!
// All you need to do is put in your name and choose a fitting font size. Easy!

// Writescad allows us to use text!
// Doubled to allow Thingiverse Customizer and OpenSCAD compatibility, respectively
use<write/Write.scad> 
use<Write.scad> 

/* [Beginner] */

// What is your name?
RulerText="Your Name Here!";
// Full names don't always fit. First names are great!
FontSize=8; //[7:0.5:11.5]

/* [Advanced] */

// Things we usually keep the same for our class prints
RulerLength=10;// [1:30]
TextX=12;
TextY=18;
TextHeight=1;
TextSpacing=1.15;
NumberSize=8;//[1:15]
NumberOffset=1;//[0:3]

{
// First let's generate all the text on our ruler

// Apply our name 
translate([TextX,TextY,TextHeight])  write(RulerText,h=FontSize,t=2,space=TextSpacing); 

// Generate the marker numbers
for (i=[1:1:RulerLength]){
if (i > 9){
translate([(i*10)-2+NumberOffset,5.5,1]) write(str(i),h=NumberSize,t=2); 
}
else
translate([(i*10)+NumberOffset,5.5,1]) write(str(i),h=NumberSize,t=2); 
}
// Make sure everyone knows this is a metric ruler in centimetres
translate([0.3,5.5,1]) write("cm",h=8,t=2); 
// Yes, lowercase cm is correct.
}

{
    // Now we'll build the rest of the ruler.

difference(){
    
    //This is the body of the ruler. To get the sloped edge...
hull(){
    // We stretch a hull over a large prism...
translate([0,5,0]) cube([(RulerLength*10)+10,25,2.5]);
    // and a small prism.
translate([0,-5,0])  cube([(RulerLength*10)+10,1,1]);
}
// This is the hole for a keyring.
translate([6,24,0]) cylinder(h = 10, r=3, center = true, $fn=50);

 // Apply our imprint to the back
translate([105,8,1]) rotate([0,180,0])  write("Maker Academy",h=9.5,t=2,space=1.2); 
// You can comment this out if it is causing printing problems, otherwise please leave it in.
{
// Future! Ssshhh.
// translate([107,8,1]) rotate([0,180,0])  write("MakerAcademy.XYZ",h=8,t=2,space=1.2); 
}
}

// Marker lines
for (i=[0:10:RulerLength*10]){  
translate([i+3,-4.9,0.5]) rotate([8.5,0,0]) cube([1,10,1.5]);
}
}

// That's it! We made the 3D Name Ruler!
// Hurray!
// Think about all the other infinite things we could make with code!