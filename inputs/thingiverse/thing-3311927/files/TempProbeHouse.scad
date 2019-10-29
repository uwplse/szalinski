//-----------------------------------------------------------------------------
// Author: Andre Pruitt, andre@pruittfamily.com
// Date:   12/23/2018
//
// This OpenSCAD model create a  AcuRite 06054M Temperature and 
// Humidity Solar Radiation Shield
//
// This work has been dereived from HAMOP's Radiation / Weather shield for 
// Netatmo outdoor sensor on Thingiverse.com: https://www.thingiverse.com/thing:804356/files
//
// This version is coded in OpenSCAD and is easy to modify for any type of temperature
// probe. I have chosen to use M3-0.5 Threaded Heat Set Inserts for 3D Printing rather
// then glueing the parts together. 
//
// For the AcuRite 06054M Temperature and Humidity probe you will need to print
// 1 top section, 5 middle sections and 1 bottom section. 
//
// Change the value of the Model variable to print the different parts of the design
// The values can be "top", "middle" and "bottom"
//
//      ------------
//     /            \           Top Section
//    /              \
//    ----------------
//     /            \   ==  -+
//    /              \  ==   |
//    ----------------  ==   |
//     /            \   ==   |
//    /              \  ==   |
//    ----------------  ==   |  Middle Sections
//     /            \   ==   |   (5 of these)
//    /              \  ==   |
//    ----------------  ==   |
//     /            \   ==   |
//    /              \  ==   |
//    ----------------  ==   |
//     /            \   ==   |
//    /              \  ==   |
//    ----------------  ==  -+
//       =================      Bottom Section
//       =================

$fn=50;

// top, middle (you will need 6 of these), bottom
Model = "bottom";

// Set a few parameters 
ConnectorRadius =  5;
M3Length        = 10;
M3HeadRadius    = 5.40/2 + 0.2;
M3HeadHeight    = 3.15;
M3ShaftRadius   = 2.85/2 + 0.2;
NutRadius       = 4.90/2 - 0.2;
ProbeWidth      = 27;

// Print the requested item
if(Model == "top")
{
     dome(Radius = 30, Top = "true");
  Support(Radius = 30, Angle =   0, Shaft = "yes");
  Support(Radius = 30, Angle =  90, Shaft = "no");
  Support(Radius = 30, Angle = 180, Shaft = "yes");
  Support(Radius = 30, Angle = 270, Shaft = "no");
}
else
if(Model == "middle")
{
     dome(Radius = 30, Top = "False");
  Support(Radius = 30, Angle =   0, Shaft = "yes");
  Support(Radius = 30, Angle =  90, Shaft = "no");
  Support(Radius = 30, Angle = 180, Shaft = "yes");
  Support(Radius = 30, Angle = 270, Shaft = "no");
}
else
if(Model == "bottom")
{
  Bottom(Radius = 30);
}

// This module draws the Support structures
module Support(Radius = 50, Height = 20, Wall = 1, Angle = 0, Shaft = "yes")
{
  // Rotate the object to the specified position
color("yellow"){  rotate([0,0,Angle])
  {
    difference()
    {
      hull()
      {
        // Draw the post
        translate([0, Radius - ConnectorRadius, 0])
          cylinder(r = ConnectorRadius, h = Height);
      
        // Draw the part the connects the post to the wall of the dome
        difference()
        {
          translate([-Wall, Radius - Wall/2, - Wall/2])
            rotate([0, 90, 0])linear_extrude(height = 2 * Wall)
              circle(r = Height); 
      
        // Remove bottom half
        translate([-Wall - 0.1, Radius - Height - Wall/2, -Height - Wall * 1.85]) 
          cube([2 * Wall + 0.2, 2 * Height, Height + 2 * Wall]);
      
        // Remove the last quarter of the circle
        translate([-Wall - 0.1,  Radius - Height - Wall/2, - Wall/2]) 
          cube([2 * Wall + 0.2, Height, Height]);
        }
      }
 
      // Is this where the M3 screw goes or the Brass nut?
      if(Shaft == "yes")
      {
        // Carve out the cylinder for accessing the M3 screw head
        translate([0, Radius - ConnectorRadius, -0.01])
          cylinder(r = M3HeadRadius, h = Height - M3Length / 2 + 0.02);
  
        // Carve out the cylinder for the M3 shaft
        translate([0, Radius - ConnectorRadius, Height - M3Length / 2])
          cylinder(r = M3ShaftRadius, h = M3Length / 2 + 0.02);
      }
      else
      {
        // Carve out a hole to put the brass inset nut into 
        translate([0, Radius - ConnectorRadius, -0.01])
          cylinder(r = NutRadius, h = 5 + 0.02);
  
        // Add a little lip to make it easer to set up the inset nut to be melted in place
        translate([0, Radius - ConnectorRadius, -0.01])
          cylinder(r = NutRadius + 0.25, h = 0.5);
      }
    }
  }
}}

module dome(Radius = 50, Height = 20, Wall = 1, Top = "False")
{
  translate([0,0, Wall ]) // Accounts for the rounded edge on the bottom of the dome
  {
    // Draw the hole thing with a funny hole in the center  
    difference()
    {
      // Draw the upper part of the done with the top cut off
      union()
      {
        // Draw the scopped out dome
        difference()
        {
          translate([0,0, -0.5]) rotate_extrude(convexity = 10)
            translate([Radius, 0, 0]) 
              circle(r = Height);

          translate([0,0, -0.5]) rotate_extrude(convexity = 10)
            translate([Radius - Wall, 0, 0]) 
              circle(r = Height - Wall);
        }
      }
        
      // Remove the bottom part of the drawing
      translate([-2*Radius,-2*Radius,-2*Height + 0.1]) 
        cube([4*Radius,4*Radius, 2*Height]);

      // Draw the hole in the middle
      cylinder(r=Radius, h = Height );
    }

    // Draw the rounded edge on the bottom
    difference()
    {
      color("red")              
        rotate_extrude(convexity = 10)
          translate([Radius + Height - Wall, 0, 0]) 
            circle(r = Wall);

      // Cut off the top of the ring
      translate([-Radius, -Radius, 0]) 
       cube([2*Radius, 2*Radius, Height - Wall /2]);
    }

    if(Top == "true")
      translate([0, 0, Height - 2 * Wall]) cylinder(r = Radius, h = 1.5 * Wall);
  }
}

// Draw the bottom of the house. It includes the mounting bracket
module Bottom(Radius = 50, Height = 6,  Wall = 1)
{
  difference()
  {
    union()
    {
      // Draw the base
      cylinder(r = Radius + Height , h = 2 * Height); // Wall/2 accounts for rounded bottom of dome

       // Draw the mounting braces
       translate([-Radius, -ProbeWidth/3, 10]) rotate([0, 90, 0]) cylinder(r = Radius/3, h = 2 * Radius);
 
       // Draw the mounting braces
       translate([-Radius, ProbeWidth/3, 10]) rotate([0, 90, 0]) cylinder(r = Radius/3, h = 2 * Radius);
    }

    // Carve out the cylinder for accessing the M3 screw head
    translate([Radius - ConnectorRadius, 0, -0.01])
      cylinder(r = M3HeadRadius, h = M3HeadHeight + 0.02);

    // Carve out the shaft
    translate([Radius - ConnectorRadius, 0, 0])
      cylinder(r = M3ShaftRadius, h = Height + 0.01 + Wall/2); // Wall/2 accounts for rounded bottom of dome

    // Carve out the cylinder for accessing the M3 screw head on the other side
    translate([-Radius + ConnectorRadius, 0, -0.01])
      cylinder(r = M3HeadRadius, h = M3HeadHeight + 0.02);

    // Carve out the shaft on the other side
    translate([-Radius + ConnectorRadius, 0, 0])
      cylinder(r = M3ShaftRadius, h = Height + 0.01 + Wall/2); // Wall/2 accounts for rounded bottom of dome

    // Carve out a grove for the horizontal arm
    translate([-2 * Radius, -ProbeWidth/2 - .1, Height]) cube([4 * Radius, ProbeWidth + 0.2, 3*Height]);
  }

  // Draw the mounting arm
  translate([3*Radius, 0, ProbeWidth/2]) rotate([90, 0, 0])
  { 
    difference()
    {
      union()
      {
        // Draw the vertical arm
        translate([2*Radius - Height, -ProbeWidth/2, 0]) cube([Height, ProbeWidth, 100]);
  
        // Draw the horizontal arm
        translate([-Radius - Radius / 7, -ProbeWidth/2, 0]) cube([3 * Radius + Radius / 7, ProbeWidth, Height]);
  
        // Draw the joint support
        translate([2*Radius - Height, ProbeWidth/2, 5]) rotate([90, 0, 0]) cylinder(r = 5, h = ProbeWidth);
      }

      // Carve out the mounting holes on the vertical arm
      translate([Radius - ConnectorRadius, 0, -0.1])
        cylinder(r = M3ShaftRadius, h = Height + 0.02 + Wall/2); // Wall/2 accounts for rounded bottom of dome
  
      translate([-Radius + ConnectorRadius, 0, -0.1])
        cylinder(r = M3ShaftRadius, h = Height + 0.02 + Wall/2); // Wall/2 accounts for rounded bottom of dome
  
      translate([2*Radius - Height - 0.1, 0, 100/3]) rotate([0, 90, 0]) cylinder(r = M3HeadRadius, h = Height + 0.2);
      translate([2*Radius - Height - 0.1, 0, 2 * 100/3]) rotate([0, 90, 0]) cylinder(r = M3HeadRadius, h = Height + 0.2);
    }
  }
}
