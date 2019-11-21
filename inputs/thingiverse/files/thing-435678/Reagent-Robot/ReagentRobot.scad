/*

Reagent Robot - an automated test chamber for chemical water quality measurements.
Copyleft James Newton 2014. Released under GPL3
07/15/2014 Initial design
08/03/2014 Converted stirrer / cleaner plate into a set of plates so that they can be placed on either side of the main shaft, bolted in place, and hold a rubber outer edge cleaning pad. Standardized base, chamber, and top plate thickness to match common 1/4 plexiglass thicknesses. Added mounting bolt holes. 

The idea here is to remove human variability and provide for automated data collection with low cost chemical reagent tests for common water conditions such as Ammonia, Chlorine, Nitrate/Nitrite, and pH. Currently, the electronic sensors for those test are very, very expensive and require frequent replacement.

This video shows a possible design for the reaction chamber where the chemical indicator is added to the sample water and LED/photodetector combination is used to test the color of the resulting mixture. This design is not meant to be a final product, but instead just a starting point.

The bottom plate simply has a hole drilled part way through for the stirrer/cleaner shaft to sit in. A single ball from a bearing would be dropped in the hole to reduce friction and extend the life of the "bearing". Initially, this plate could be plex, but eventually should be something more durable. 

The center (clear) area is a square block of plex with a large circular hole in the middle where the sample will be held. 

A stirrer / cleaner made from metal with a vertical shaft turns in this space to both stir the sample and reagent and to clean the sides of the chamber to ensure consistent optical performance over time. The shaft exits the top plate and connects to a small stepper or gear motor which is not shown. If the recommended injector is used, the motor of the injector could be used to turn the stirrer / cleaner, but this is not necessary to the design. 

The black top plate has holes for the inlet of water from the valve (not pictured) and exit of the prior sample (to drain). Not shown is the small hole for the inlet of the reagent from the injector pump. 

Reagent Injector options:
http://www.thingiverse.com/thing:219281 looks just about perfect.

1. NOT recommended, way too complex.
http://www.thingiverse.com/thing:20733

2. Not recommended. Nice, but needs unavailable parts.
http://www.thingiverse.com/thing:31210
The thumb wheel and extruder parts are not needed, only the "trapeziumNut" to be printed and the "SyringeExtruderCasing.3dm" to be cut. I /think/ those are the correct files, but I'm not a 3DM user. No DXF files published. The trapeziumnut is made for a specific type of threaded rod described as 12x6x2 which is (apparently) impossible to find. It will need to be redesigned for a nut and more commonly available rod type.

3. No longer Recommended. Simple, easy, found all the parts.
http://www.thingiverse.com/make:17532
http://www.thingiverse.com/thing:30910
Requires 
Pulley, GT2, 5mm ID, 16mm OD, 2mm pitch, 6mm wide
http://www.adafruit.com/products/1251
Belt, GT2, 2mm pitch, 6mm width
http://www.adafruit.com/products/1184
Skate bearings
http://www.adafruit.com/products/1178 (minor changes to the files will have to be made to accomodate this slightly different size of skate bearing, but that is easily done as I work in OpenSCAD



Other parts required: Full list at

https://docs.google.com/spreadsheets/d/1VqRxvLsWpltaBc5tXhsEXb2C1_wAgTpsExAs6M93qz8/pubhtml



*/

inch = 25.4*1; // *1 to hide


/* [Main] */
plexidepth = 1/4 * inch;
basedepth = plexidepth; //standard plexiglass is quarter inch
chamberdepth = basedepth*2;
coverdepth = basedepth;

//Width of the chamber outside
bodywidth = 50;

//Length of the chamber outside
bodylength = 50;

//Thickness of the chamber wall inside to outside
chamberwall = 5;
chamberdia = min(bodywidth,bodylength)-chamberwall;
spindleseat = basedepth-3;

//Diameter of the water inlet / outlet
spindledia = 12.7;

//Diameter of the reagent injection inlet
injectdia = 1;

//Diameter of the bolts holding it all together.
boltdia = 4; //4mm is loose fit for #6-32

//divide the body width by this, and put the bolt hole that distance from the edge.
boltoff = 12; 


/* [Stirrer] */

//Thickness of the stirrer / cleaner. 1.245mm is 18 guage
stirthick = 1.245; //

//Width of the frame around the cut out area of the stirrer / cleaner
stiredge = 5;

//Diameter of the stirrer / cleaner shaft. 5mm=NEMA 17.
shaftdia = 5;

//Diameter of the bolts holding the stirrer / cleaner together
stirboltdia = 2;


/* [Render] */
//Select which part to generate. Customizer will generate each as an .stl file
part = "all"; // [all,base,chamber,cover,stirrer]

//true to make DXF files, false to make STL files.
2Dv3D = "3D"; // [2D, 3D]

//show black sides on the chamber
enclose = false;



/* [Hidden] */

include <LED_Module.scad> 



t=.01;
tt=t+t;
$fs=.1;
$fa=1;


if (part == "all") {	//do a preview of the assembled device
  optics();
  base();
// stirrer plates, animated
  rotate([0,0,$t*360]) 
    translate([0,-shaftdia/2,basedepth+chamberdepth/2])
      stirrer();
  rotate([0,0,180+$t*360]) 
    translate([0,-shaftdia/2,basedepth+chamberdepth/2])
      stirrer();
// cleaner pads, animated
  rotate([0,0,$t*360]) 
    translate([chamberdia/2-shaftdia/4,0,basedepth+chamberdepth/2])
      color("red") cube([stiredge/2,shaftdia/2,chamberdepth], center=true);
  rotate([0,0,180+$t*360]) 
    translate([chamberdia/2-shaftdia/4,0,basedepth+chamberdepth/2])
      color("red") cube([stiredge/2,shaftdia/2,chamberdepth], center=true);
// stirrer shaft.
  color("silver") translate([0,0,basedepth-spindleseat]) 
    cylinder(h=chamberdepth+coverdepth+spindleseat+8, r=shaftdia/2);

  translate([0,0,basedepth]) chamber();
  translate([0,0,basedepth+chamberdepth]) cover();
  }
else if (part == "base") {
  if (2Dv3D=="2D") {
    projection() base();
    }
  else {
    base();
    }
  }
else if (part == "chamber") {
  if (2Dv3D=="2D") {
    projection() chamber();
    }
  else {
    chamber();
    }
  }
else if (part == "cover") {
  if (2Dv3D=="2D") {
    projection() cover();
    }
  else {
    cover();
    }
  }
else if (part == "stirrer") {
  if (2Dv3D=="2D") {
    projection()
      translate([0,0,stirthick/2]) rotate([90,0,0]) stirrer();
    }
  else {
    translate([0,0,stirthick/2]) rotate([90,0,0]) stirrer();
    }
  }


module optics() {
  translate([bodywidth/4-6,bodylength,basedepth+chamberdepth/2-led_h/2]) 
    led("red");
  translate([bodywidth/4+0,bodylength,basedepth+chamberdepth/2-led_h/2]) 
    led("green");
  translate([bodywidth/4+6,bodylength,basedepth+chamberdepth/2-led_h/2]) 
    led("blue");
  translate([bodywidth/4+0,-bodylength,basedepth+chamberdepth/2-led_d/4]) 
    rotate([-90,0,0]) 
      led("white");
  }

module stirrer() { // just the plate, not including the shaft.
  difference() {
    color("silver") 
      cube([chamberdia-shaftdia/4, stirthick,chamberdepth], center=true);
    translate([chamberdia/4+shaftdia/4,0,0])
      cube([chamberdia/2-stiredge-boltdia-shaftdia/2, stirthick+tt,chamberdepth-stirthick*2]
			, center=true);
    translate([-chamberdia/4-shaftdia/4,0,0])
      cube([chamberdia/2-stiredge-boltdia-shaftdia/2, stirthick+tt,chamberdepth-stirthick*2]
			, center=true);
    translate([0,shaftdia/2,0])
      cylinder(r=shaftdia/2, h=chamberdepth+tt, center=true);
  translate([shaftdia/2+boltdia/2,0,chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([shaftdia/2+boltdia/2,0,-chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([-shaftdia/2-boltdia/2,0,chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([-shaftdia/2-boltdia/2,0,-chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
//outside edge bolt holes (through cleaning pad)
  translate([chamberdia/2-shaftdia/8-stiredge/3,0,chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([chamberdia/2-shaftdia/8-stiredge/3,0,-chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([-chamberdia/2+shaftdia/8+stiredge/3,0,chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
  translate([-chamberdia/2+shaftdia/8+stiredge/3,0,-chamberdepth/4])
    rotate([90,0,0])
      cylinder(r=stirboltdia/2,h=stirthick+tt, center=true);
    }

  }

module boltholes(depth) {
    translate([-bodywidth/2+bodywidth/boltoff,-bodywidth/2+bodywidth/boltoff,0])
      cylinder(h=depth+tt, r=boltdia/2);
    translate([+bodywidth/2-bodywidth/boltoff,-bodywidth/2+bodywidth/boltoff,0])
      cylinder(h=depth+tt, r=boltdia/2);
    translate([-bodywidth/2+bodywidth/boltoff,+bodywidth/2-bodywidth/boltoff,0])
      cylinder(h=depth+tt, r=boltdia/2);
    translate([+bodywidth/2-bodywidth/boltoff,+bodywidth/2-bodywidth/boltoff,0])
      cylinder(h=depth+tt, r=boltdia/2);
	}

module cover() {
  difference() {
    color("black") translate([0,0,coverdepth/2])
      cube([bodywidth, bodylength,coverdepth], center=true);

    cylinder(h=coverdepth+tt, r=shaftdia/2);
    translate([bodywidth/4,0,0])
      cylinder(h=coverdepth+tt, r=spindledia/2);
    translate([-bodywidth/4,0,0])
      cylinder(h=coverdepth+tt, r=spindledia/2);
    translate([0,-bodywidth/4,0])
      cylinder(h=coverdepth+tt, r=injectdia/2);
    boltholes(coverdepth);

    }
  }

module base() {
  difference() {
    color("black") translate([0,0,basedepth/2])
      cube([bodywidth, bodylength,basedepth], center=true);
    translate([0,0,(basedepth-spindleseat)+t])
      cylinder(h=spindleseat, r=spindledia/2);
      cylinder(h=basedepth+tt, r=.5); //guide hole, easy to plug
	boltholes(basedepth);
    }
  }

module chamber() {
  if (part == "all") { //add back some color so we can see the holes.
    color("grey",.3) translate([0,0,-t])
      cylinder(h=chamberdepth+tt, r=chamberdia/2);
    color("white",.3) boltholes(chamberdepth);
    }
if (enclose) {
  color("black") translate([bodywidth/2+t,0,chamberdepth/2])
    cube([.1,bodylength,chamberdepth],center=true);
  color("black") translate([-(bodywidth/2+t),0,chamberdepth/2])
    cube([.1,bodylength,chamberdepth],center=true);
  }
  difference() {
    color("white",.5)
      translate([0,0,chamberdepth/2])
        cube([bodywidth, bodylength, chamberdepth], center=true);
    translate([0,0,-t])
      cylinder(h=chamberdepth+tt, r=chamberdia/2);
	boltholes(chamberdepth);
    }
  }