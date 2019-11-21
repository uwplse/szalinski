
// Radius of the whistle in mm
rad = 30; // [20:50]

// Height of the whistle in mm
hoehe  =  20;  // [15:30]

// Length of blow element in mm
laenge =  35;  // [20:50]

// Make a handle for whistle?
make_holder =  1;  // [0:1]

//text to put on bracelet
textshow = "Love";

// Textsize on whistle
textsize =  10;  // [8:14]

// preview[view:south, tilt:top]

// ............................................................

// Pfeife by Nischi, Alexander Nischelwitzer
// nischelwitzer@gmail.com (C)Jan/2013
// http://www.thingiverse.com/thing:41915
//
// V1.1 Rotationsrundung weg
// V1.2 stärkerer Halter
// V2.0 Optimierunge für Parameter
// V2.1 Textparameter, Anpassung Innenkugel hohl
// V2.2 Innenkugel mit 1mm Ständer 
// V2.3 dynamischer Halter (scale)
// V2.4 innenreifen für rad>40 zum deckel machen, innenkugel true/false
// V2.5 if statements, round text, dynamic handle, staender, adjustment inner sphere
// V2.6 corrected some bugs, better whistle hole

use <write/Write.scad>  
// http://www.thingiverse.com/thing:16193

// ============================================================
// Paramters 

dicke  =   2+0;  
breite =   6+0;  

ball   =   3+0;  
buffer =   0+0;  
texth  =   1+0;  

dostay =   false+0;  

// ============================================================

pfeife(textshow, textsize);

// ============================================================

module pfeife(name,sizename)
{
  
  if (make_holder) rotate([90,0,0]) translate([-rad/2+0.1,hoehe/2,0]) scale([15/hoehe,1,1]) halter(dicke);

  if (rad < 40) rotate([0,0,0])  translate([0,0,hoehe]) texter(name, sizename);
  if (rad > 39) 
  {
    color("yellow") writecylinder(name,[0,0,0],t=3,h=9,font="write/Letters.dxf", 
      space=1.2, rad/2+1,hoehe,face="top");
  }

  difference() 
  {
    union()  
    {       
      color("red") translate([0,0,0]) cylinder(hoehe, r=rad/2, $fn = 35); 
      color("red") translate([0,rad/2-breite,0]) cube([laenge,breite,hoehe]);  
      color("red") translate([0,0,0]) cube([rad/2,rad/2,hoehe]); 
	}
    translate([0,0,dicke]) cylinder(hoehe-dicke*2+buffer, r=rad/2-dicke, $fn = 25); 
    translate([0,rad/2-breite+dicke,dicke]) 
      cube([laenge+dicke,breite-dicke*2,hoehe-dicke*2+buffer]);

    if (rad > 39) // stützkreis
      translate([0,0,0]) cylinder(hoehe, r=(rad-25)/2-dicke, $fn = 25);  

    color("blue") translate([dicke*5,rad/2-dicke/3,dicke]) rotate([0,0,150])
      cube([dicke*5,dicke*2,hoehe-2*dicke]);  // Pfeifenschlitz mit Winkel
    color("blue") translate([4,rad/2-7.5,dicke]) rotate([0,0,0])
      cube([rad/8,10,hoehe-2*dicke]); // Schlitz gerader Block
  }

  if (dostay) // to let it stay on table for presentation
    color("black") translate([-rad/6,-rad/2,0]) cube([rad/3,dicke,hoehe]); 

  if (rad > 39) // stützkreis
  {
    difference() {
      translate([0,0,dicke]) cylinder(hoehe-dicke*2, r=(rad-25)/2, $fn = 35);
      translate([0,0,dicke]) cylinder(hoehe-dicke*2, r=(rad-25)/2-dicke, $fn = 25); 
    }
  } 

  if (true) // innere sphere - innenkugel mit stäender
  {
    color("red") translate([0,rad/2-7.5,dicke]) cylinder(1, r=1, $fn = 10);
    difference() // innenkugel
    {
      color("red") translate([0,rad/2-7.5,dicke+ball+1+1]) sphere(ball+1, $fn=25); 
      color("red") translate([0,rad/2-7.5,dicke+ball+1+1]) sphere(ball, $fn=25); 
    }
  }
}

// ============================================================

module texter(gotname="NIS", sizename=11)
{
  color("yellow")   translate([0.5,2,0]) rotate([0,0,40])
    write(gotname,t=3,h=sizename,font="write/Letters.dxf", space=0.90, center=true);
}

module halter(dicke=1)
{
  difference() 
  {
    union()  
    {       
      color("blue") translate([0,0,-dicke]) cylinder(dicke*2, r=hoehe/2, $fn = 25); 
	}
    translate([0,0,-dicke]) cylinder(hoehe-dicke*2, r=hoehe/2-dicke*hoehe/15, $fn = 25); 
    translate([0,-hoehe,-dicke]) cube([hoehe,hoehe*2,dicke*2]); 
  }
}

// ============================================================

