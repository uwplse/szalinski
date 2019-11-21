///////////////
// Version 1 of the Customizer version of http://www.thingiverse.com/thing:1693879
// Basic functionality (number or blank, change font)
// Add requests in comments
// TODO: alter clip dimensions/allow for more than 2 numbers (letters too? 3 chars?)
// Please post made pics ;)
//////////////
/* [Hidden] */
$fn=360;
 halign = [
   [-20, "left"],
   [0, "center"],
   [90, "right"]
 ];
  valign = [
   [  0, "top"],
   [ 40, "center"],
   [ 75, "baseline"],
   [110, "bottom"]
 ];

//
/* [Basic Configuration] */
//Choose -1 for blank, otherwise pick a number!
tag_text=7;//[-1:1:99]
font_name="Share Tech Mono"; //[Cousine,Droid Sans Mono,Fira Mono,Inconsolata,Nova Mono,Oxygen Mono,PT Mono,Roboto Mono,Share Tech Mono,Source Code Pro,Space Mono,Ubuntu Mono]

CreateBlank();
echo (str(tag_text));
if ((tag_text)!=-1) 
	{ 
		echo ("False");
		CreateText();
	}    
 module CreateText()
	{	      
	difference()
	{
		cube([21,2,20],center=true) ; //TagFront	
		translate ([0,-0.5,0]) rotate ([90,0,0])linear_extrude(height=1) 
		text(str(tag_text),13,font_name,halign="center",valign="center"); 
	}
}
module CreateBlank()
	{   
		difference(){    
			translate ([0,3.75,0]) color ("green") cylinder(r=4,h=20, center=true); //Clip Outside
			translate ([0,3.75,0]) color("Blue") cylinder(r=2.4,h=22, center=true); //Clip Inside
			translate ([0,6,0]) color("red") cube([4,4,22],center=true); //Clip Opening
		}
	
	if ((tag_text)==-1)
		{
		difference(){
			cube([21,2,20],center=true); //TagFront	
			translate ([0,-1,0]) cube([20.5,0.5,19.5],center=true); //BeveledBlank
			}	
		}
	}
 module cylinder_outer(height,radius,fn){
   fudge = 1/cos(180/fn);
   cylinder(h=height,r=radius*fudge,$fn=fn);}
 module cylinder_mid(height,radius,fn){
   fudge = (1+1/cos(180/fn))/2;
   cylinder(h=height,r=radius*fudge,$fn=fn);}