// A fully parameterised Filament Spool holder
//   Author: Nick Wells
// Revision: 1.0 19/01/2018 Initial release
//           1.1 20/03/2018 Added bq spool sunken profile
//           1.2 03/02/2019 Refactored Code
// http://customizer.makerbot.com/docs
// Credit to https://openhome.cc/eGossip/OpenSCAD/GoldenSpiral.html
// for the Golden Spiral

// Set the spool and shaft sizes here. all units in mm
/* [Spool Settings] */
// Internal diameter of filament spool (mm)
spool_diameter = 57; // [20:0.5:100]

// External width of the Filament spool (mm)
spool_width    = 70;  // [30:1:100]

// Threaded shaft diameter
shaft_diameter = 7; // [3:0.5:20]

/* [Hub Settings]*/
// Centre hub length
hub_length     = 70; // [20:0.5:120]

// Centre hub diameter
hub_diameter   = 15; // [10:0.5:30]  

/*[ General Settings ]*/
// Thickness of body walls 
wall_thickness = 0;  //  [0:0.5:6]

// Rear Coller diameter 
collar_diameter = 80; // [30:1:150]

// Rear Collar thickness
collar_thickness   = 2;  // [0:0.5:10]

// Minkowski curved edges must be less than half of the wall thickness
edge_curve     = 0; //[0:0.1:1.9]

/* [Spoke Settings ]*/
// Type of spool hub
spoke_type      = "spiral"; // [blade,wire,spiral,auger]

// Number of blades or spokes
spoke_count     = 10; // [1:1:30]

// Thickness of blade or spokes
spoke_thickness = 1.5; // [1:0.5:10]

// Angle of blade or spoke
spoke_rotation  = 0; // [0,5,25]

// Now the fun bit!
// You can makes some cool spools by altering the spoke settings


// brand    type   diam   depth  spokes thickness rotation
// eSun     blade  52     70     3      4         30
// Sunlu    blade  72     70     3      4         30
// bq       blade  45     65     8      2         30 
// bq       spiral 45     65     10     1.5       0
// priline  spiral 57     68     10     1.5       0

// Here are some samples, 
// ############################################################################################
// ## Type 1) A standard hub, to use this set the spoke_type to "blade"                      ##
// ############################################################################################
// Then set the 3 spoke parameters using one of the samples below and press F6 to render:
// A single spoke hub       1,5,0
// A standard 5 spoke hub   5,5,0
// A thin 6 spoke hub       6,3,0
// A slanted  3 spoke hub   3,4,20
// A 10 blade fan           10,2,10
// A 20 blade turbine fan   20,1,20

// ############################################################################################
// ## Type 2) This is an interesting hub using an auger, to use it set spoke_type to "auger" ##
// ############################################################################################
// This ignores all other spoke settings
// Pretty cool but needs support to print

// ############################################################################################
// ## Type 3) This one makes a Jaguar style spoked hub, to use it set spoke_type to "wire"   ##
// ############################################################################################
// The spoke_count and spoke_thickness can be used
// Pretty but will be interesting to print!
// A 12 thick spoke hub 6,5,0
// A 24 thin spoke hub  12,3,0


// Some of the options will take a while to render due to the Minkowski curved edges.

/* [hidden] */
$fn=100;

// Uses the MCAD library to create the auger
include <MCAD/screw.scad>

// Create the spool!
MainSpool();

module MainSpool()
{
  translate([0,0,edge_curve])
  {
    difference()
    {
      spool_body();
      spool_remove();
    }
  }
}

module spool_body()
{
   shell();
   hub();
   spokes();
}

module spool_remove()
{
  // Shaft hole
  translate([0,0,-0.5])cylinder(d=shaft_diameter,h=spool_width-2*edge_curve+1);
  
  // Trim for short shaft
  translate([0,0,hub_length])cylinder(d=spool_diameter-2*wall_thickness,h=spool_width-hub_length+1);
}

module shell()
{
  difference()
  {
     minkowski()
     {
       shell_body();
       sphere(edge_curve);
     }
     shell_remove(); 
  }
}
module shell_body()
{
    // Back collar
    cylinder(d=collar_diameter-2*edge_curve,h=collar_thickness-2*edge_curve);
    // spool hub
    cylinder(d=spool_diameter-2*edge_curve,h=spool_width-2*edge_curve);
}
module shell_remove()
{
  // Add a bit so the hole renders ok in OpenSCAD
  translate([0,0,-0.5])cylinder(d=spool_diameter-2*wall_thickness,h=spool_width+1);
}

module hub()
{
  // Hub
  cylinder(d=hub_diameter,h=spool_width-2*edge_curve);
}

module spokes()
{
  difference()
  {
    spoke();
    spoke_trim();
  }
}
module spoke()
{
  if(spoke_type == "auger")  auger_spoke();
  if(spoke_type == "wire")   translate([0,0,hub_diameter])wire_spoke();
  if(spoke_type == "blade")  translate([0,0,-spoke_thickness/2])blade_spoke();
  if(spoke_type == "spiral") spiral_spoke();
}
module spoke_trim()
{
  // trim top
  translate([0,0,spool_width-0.01])cylinder(d=spool_diameter*2,h=collar_thickness+hub_diameter);
  
  // trim bottom
  translate([0,0,-spoke_thickness])cylinder(d=collar_diameter,h=spoke_thickness);
  

  // Leave a gap at the base of the spiral to detach it from the collar
  if(spoke_type == "spiral")
  {
     translate([0,0,collar_thickness])cylinder(d=collar_diameter,h=collar_thickness); 
     difference()
     {
       cylinder(d=spool_diameter*2,h=spool_width);
       cylinder(d=spool_diameter+2,h=spool_width);
     }
  }
  else
  {
    // trim shell
    difference()
    {
      cylinder(d=spool_diameter*2,h=spool_width);
      cylinder(d=spool_diameter,h=spool_width);
    }
  }
}
module auger_spoke()
{
      // Uses the auger function from the MCAD library supplied with OpenSCAD
    // auger(pitch, length, outside_radius, inner_radius, taper_ratio = 0.25)
    auger(30,spool_width,spool_diameter/2-wall_thickness,hub_diameter/2,0.25);
}
module wire_spoke()
{
  // Generate spokes
    for(a = [0:360/spoke_count:360])
    {
      rotate([0,0,a])translate([0,spool_diameter/4+spoke_thickness/2,0])rotate([45,0,0])
        cylinder(d=spoke_thickness, h = spool_diameter/2+2*wall_thickness+10,center=true);
   
      rotate([0,0,a+(180/spoke_count)])translate([0,spool_diameter/4+spoke_thickness/2,0])rotate([-45,0,0])
        cylinder(d=spoke_thickness, h = spool_diameter/2+2*wall_thickness+10,center=true);
    }
}

module blade_spoke()
{
  for(a = [0:360/spoke_count:360])
  {
    rotate([spoke_rotation,0,a])
      translate([-spool_diameter/2,0,0])
        cube([spool_diameter/2,spoke_thickness,spool_width+hub_diameter]);
  }
}

module spiral_spoke()
{
  cylinder(h=collar_thickness,d=spool_diameter);

  // from, to thickness
  translate([0,0,collar_thickness+0.2])
  {
    linear_extrude(height=hub_length)
    for(a = [0:360/spoke_count:360])
    {
    rotate([0,0,a])golden_spiral(5, 9, spoke_thickness); 
    }
  }
}

// Credit to https://openhome.cc/eGossip/OpenSCAD/GoldenSpiral.html
function fibonacci(nth) = 
    nth == 0 || nth == 1 ? nth : (
        fibonacci(nth - 1) + fibonacci(nth - 2)
    );

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 

module golden_spiral(from, to, thickness) {
    if(from <= to) {
        f1 = fibonacci(from);
        f2 = fibonacci(from + 1);

        arc(f1, [0, 90], thickness, 100);

        offset = f2 - f1;

        translate([0, -offset, 0]) rotate(90)
            golden_spiral(from + 1, to, thickness);
    }
}