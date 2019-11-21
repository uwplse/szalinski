// Licence: Creative Commons, Attribution
// Created: 04-2014 by bmcage http://www.thingiverse.com/bmcage

// An LED lamp holder for easter

/* [Size] */

//diameter of the horizontal circle in mm
diameter = 40;  //[10:150]
//vertical scale factor to make it an egge (choose number from 1 to 2)
eggscale = 1.2;
//single shell thickness, take your nozzle diameter as minimum
th_shell = 0.6;
//base cylinder diameter in mm.
base_diam = 24; //[5:100]
//base extra height under egg
base_extra_height=20; // [0:20]
//The part to generate. Print both for rigidity, or increase shell thickness if only one!
part="both"; // [inner,outer,both]
//cuttoff position of egg where we the base ends
h_cuttoff = 20; //[0:200]

/* [Pattern] */

//pattern to imprint on the egg. Use custom to give a custom polygon below
pattern = "circle"; //[triangle,circle,custom]
//Scale the pattern to the size you want. Use 0.1 as start for a custom pattern.
patternscale = 0.2; //
//For custom pattern, draw here the polygon to use (default is a simple square)
custom_polygon = [[[-10,10],[10,10],[10,-10],[-10,-10]],[[0,1,2,3]] ]; //[draw_polygon:100x100]

/* [Layout and Text] */
//how to layout the pattern: 1/random, 2/a cylinder at the equator, 3/a spiral from bottom to top, 4/a double spiral, 5/only display pattern at the top of the egg 6/use 5 polygon to project on North, South, East, West and Top, you need to give 4 extra custom polygons. 
repeattype = "random"; //[random, cylinder,spiral,doublespiral,topproject,5point]
//how many times the pattern should be present
patternrepeat = 30;  //[1:100]
//For layout random, give a seed to generate the positions
random_seed = 121;  //[0:3200]
//Rotate pattern around it's center in a random way or not
rotate_pattern="true";  //[true,false]
//for layout spiral, how many rotations from botton to top
spiral_circles = 4; //[1:10]
//for layout doublespiral, extra rotation offset for second spiral
dh_angle=45; //[0:180]

//text to write on equator
text = "Ingegno.be";
//fraction of the circumference to use for the text (value between 0.1 and 0.9)
textcircum = 0.8;


/* [Extra Polygons] */

//The North Polygon for 5 point layout
north_polygon = [[[-10,0],[0,10],[10,0]],[[0,1,2]] ]; //[draw_polygon:100x100]
//Scale of north polygon.
north_scale = 0.3; //
//The South Polygon for 5 point layout
south_polygon = [[[-10,10],[0,0],[10,10]],[[0,1,2]] ]; //[draw_polygon:100x100]
//Scale of north polygon.
south_scale = 0.3; //
//The East Polygon for 5 point layout
east_polygon = [[[0,10],[10,0],[0,-10],[-10,0]],[[0,1,2,3]] ]; //[draw_polygon:100x100]
//Scale of north polygon.
east_scale = 0.3; //
//The West Polygon for 5 point layout
west_polygon = [[[-10,10],[10,10],[10,-10],[-10,-10]],[[0,1,2,3]] ]; //[draw_polygon:100x100]
//Scale of north polygon.
west_scale = 0.3; //

use <utils/build_plate.scad>;
use <MCAD/fonts.scad>;

//for display only, doesn't contribute to final object
build_plate_selector = 0; //[0:Replicator 2,1: Replicator,2:Thingomatic,3:Manual]

//when Build Plate Selector is set to "manual" this controls the build plate x dimension
build_plate_manual_x = 100; //[100:400]

//when Build Plate Selector is set to "manual" this controls the build plate y dimension
build_plate_manual_y = 100; //[100:400]

build_plate(build_plate_selector,build_plate_manual_x,build_plate_manual_y); 

//code begins, dummy module to indicate this
module test(){
  echo("test");
}

// sin(alpha) = R_C/R_S, cos(alpha) = sqrt(1- (R_C/R_S)**2)
// cutoff sphere is R_S*(1-cos(alpha)
sinalpha = base_diam/2 / (diameter/2);
cosalpha = sqrt(1-pow(sinalpha,2));
rcuttoff = diameter/2*(1-cosalpha);

module easterlamp(diam, transdist)
{
translate([0,0,transdist]) 
 	{
	 difference() 
		{
 		 scale([1,1,eggscale]) sphere(r = diam/2, $fn=60);
	 	 union(){
 		 scale([1,1,eggscale]) sphere(r = diam/2-th_shell*eggscale, $fn=60);
    	 translate([0,0,-eggscale*diam]) cylinder(r=base_diam/2, h=eggscale*diam);
		 }
		}
	}
}

module filledfoot()
{
cylinder(r=base_diam/2, h=base_extra_height+eggscale*rcuttoff+2, $fn=40);
}

module foot()
{
difference()
	{
 	 filledfoot();
 	 translate([0,0,-0.05])cylinder(r=base_diam/2-2*th_shell*eggscale, h=base_extra_height+eggscale*rcuttoff+2.1, $fn=40);
	}
}


module singlepattern()
{
//translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
	{scale([patternscale,patternscale,1])
		{
		 if (pattern == "triangle")
		 { translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
           polygon(points=[[-10,0],[0,10],[10,0]]);
		 }
		 if (pattern == "circle")
		 { translate([0,0,1*eggscale*diameter/4]) cylinder(r=10, h=eggscale*diameter/4, $fn=20);
		 }
		 if (pattern =="custom")
		 {translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
			 polygon(points = custom_polygon[0], paths = custom_polygon[1]);
		 }
	   }
	}
}

module rotsinglepattern(rotangle)
{
 if (rotate_pattern=="true")
	{rotate([0,0,rotangle]) singlepattern();
	} else {
	 singlepattern();
	}
}

module manypatterns()
{
random_numbers=rands(0,360,2*patternrepeat,random_seed);
union(){
 if (repeattype == "random")
  {
  for (i=[1:patternrepeat])
	{
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
		rotate([0,10+random_numbers[i-1]/360*160,random_numbers[i]]) 
		{
		 rotsinglepattern(random_numbers[i]);
	 	}
	}
  }
 if (repeattype == "cylinder")
  {
  for (i=[1:patternrepeat])
	{
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
		rotate([0,90,i*360/patternrepeat]) 
		{
		 rotsinglepattern(random_numbers[i]);
	 	}
	}
  }
 if (repeattype == "topproject" || repeattype == "5point")
  {
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
		{
		 rotsinglepattern(random_numbers[0]);
	 	}
  }
 if (repeattype == "5point")
  { //North
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
     rotate([90,0,180])
	   scale([north_scale,north_scale,1])
		  translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
			 polygon(points = north_polygon[0], paths = north_polygon[1]);
   //East
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
     rotate([90,0,90])
	   scale([east_scale,east_scale,1])
		  translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
			 polygon(points = east_polygon[0], paths = east_polygon[1]);
   //South
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
     rotate([90,0,0])
	   scale([south_scale,south_scale,1])
		  translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
			 polygon(points = south_polygon[0], paths = south_polygon[1]);
   //West
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
     rotate([90,0,-90])
	   scale([west_scale,west_scale,1])
		  translate([0,0,1*eggscale*diameter/4]) linear_extrude(height = eggscale*diameter/4, convexity = 10)
			 polygon(points = west_polygon[0], paths = west_polygon[1]);
  }
 if (repeattype == "spiral" || repeattype == "doublespiral")
  {
  for (i=[1:patternrepeat])
	{
	 translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
		rotate([0,10+i*160/patternrepeat, i*360/patternrepeat*spiral_circles]) 
		{
		 rotsinglepattern(random_numbers[i]);
	 	}
	}
  if (repeattype == "doublespiral")
   {
   for (i=[1:patternrepeat])
	 {translate([0,0,eggscale*diameter/2+base_extra_height-0.1]) 
	  //difference()
     { 
		 rotate([0,10+i*160/patternrepeat, -i*360/patternrepeat*spiral_circles+dh_angle]) 
		 {
		  rotsinglepattern(random_numbers[i]);
	 	 }
	  //cube([diameter/2,diameter/2,diameter/2], center=true);
     }
	 }
   }
  }
 }
}


//process the text, we have beta_1 for the symbol, use beta_2 for border!
thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];
theseIndicies=search(text,thisFont[2],1,1);
wordlength = (len(theseIndicies));

factorygap = 3;
scale_x = PI * diameter * textcircum/wordlength / x_shift;
scale_y = (diameter*eggscale/5) / y_shift;
//thicknessword = text_thickness * nozzlediam;

// Create the Text
module alltext() {
    for( j=[0:(len(theseIndicies)-1)] ) 
        {
			translate([0,0,eggscale*diameter/2+base_extra_height-0.1])
			rotate([90,0,j*360 * textcircum/wordlength])
        	translate([0,0,2.8*eggscale*diameter/8]) scale([scale_x,scale_y,1]){
          linear_extrude(height=1.2*eggscale*diameter/8) 
            polygon(points=thisFont[2][theseIndicies[j]][6][0],paths=thisFont[2][theseIndicies[j]][6][1]);
        }
      }
}

centeregg = eggscale*diameter/2+base_extra_height-0.1;
module fullobject()
{
if (part =="both")
	{
	 easterlamp(diameter-2*th_shell*eggscale+0.05, centeregg);
	}

if (part =="inner")
	{difference() {
   	 easterlamp(diameter-2*th_shell*eggscale-0.05, centeregg);
		 foot();
	 }
	}

if (part == "outer" || part == "both")
	{
 	 foot();
	 difference()
	 {
		easterlamp(diameter, centeregg);
		manypatterns();
      alltext();
	 }
	}
}

//module easterlamp()
//{
if (h_cuttoff>0)
{
translate([0,0,-h_cuttoff+0.01])
 difference()
	{
	 fullobject();
	 translate([-diameter/2,-diameter/2,-0.01]) cube([diameter, diameter,h_cuttoff]);
	}
} else {
 fullobject();
}
//}
//alltext();
//easterlamp();
//manypatterns();
