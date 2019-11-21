
/* 
  Add a ready made library for making rounded boxes
  Learn more about the MCAD libraries here: http://reprap.org/wiki/MCAD
*/
include <MCAD/boxes.scad>

/*
  OpenSCAD Parametric Divided Box V.2 by Ryan Burnsides
  - Based heavily on OpenSCAD Parametric Box Lesson and Box With Sliding Top by Aaron Ciuffo - http://www.thingiverse.com/thing:1201466 - OpenSCAD Parametric Box Lesson 
    - http://www.thingiverse.com/thing:201304 - Box With Sliding Top
  
  April 2017

  Released under the Creative Commons Share Alike License
  http://creativecommons.org/licenses/by-sa/3.0/

  Thanks to:
  Aaron Ciuffo for his excellent lesson 

  This version adds the following functionality
  - Custom compartment sizes, specify different size for each compartment
  - Automatic calculation of box dimensions from compartment requirements
  - Optional catch
  - More options for fit tuning
  
  Roadmap:
  - Can I think of an elegant way to allow variable numbers of sub-compartments instead of forcing a grid?
  - Is there a better shape for the sliding mechanism that is easier to tune for fit?
  - Add support for extruded custom text on lid
 */

// Which part would you like to see?
part = "both"; // [first:Box Only,second:Lid Only,both:Box and Lid]

/* [Compartment Sizes] */
// use the following syntax to add 1 or more internal x compartment lengths (mm)
x_compartment_sizes = [20, 40];
// use the following syntax to add 1 or more internal y compartment widths (mm)
y_compartment_sizes = [46, 46];
// internal compartment height in (mm)
compartment_height=16;
// wall thickness (mm)
wall_thickness = 3;
// corner radius (mm)
corner_rad = 2;

/* [Lid text] */
// lid text lines. Split lines with comma's
lid_text = ["Example text", "3 lines with", "", "space between"];
// lid text x-spacing
lid_text_x_spacing = 4;
// lid text y-spacing. Will space from edge or catch/slot
lid_text_y_spacing = 15;
// lid text depth
lid_text_depth = 1;

/* [Dividers] */
// divider thickness (mm)
divider_thickness = 2;
// divider can be made to slope lower at edges
divider_min_height = 10.8;
divider_max_height = 15.8;
// percentage of divider at max height, max height will be in the middle of the divider
divider_percent_at_max_height = .8;

/* [Catch] */
// print a catch to help hold the lid in place
print_catch = "yes"; // [yes, no]
// diameter of catch cylinder (mm)
catch_diameter = 1;
// width of hole for catch (mm)
catch_hole_diameter = 2;
// length of catch bump as a percentage of box width
catch_bump_ratio = .2;
// length of catch hole as a percentage of box width
catch_hole_ratio = .25;
// position of catch bump on box wall as a percentage of wall thickness (0 is outer edge, 1 is inner edge)
catch_wall_ratio = .8;

/* [Fit Tuning] */
// Change hole x by this amount, if negative, need digit before decimal point (mm)
hole_buffer_x = .1;
// Change hole y by this amount, if negative, need digit before decimal point (mm)
hole_buffer_y = .1;
// Change hole z by this amount, if negative, need digit before decimal point (mm)
hole_buffer_z = .1;
// Change lid x by this amount, if negative, need digit before decimal point (mm)
lid_buffer_x = -0.25; 
// Change lid y by this amount, if negative, need digit before decimal point (mm)
lid_buffer_y = -0.15; 
// Change lid z by this amount, if negative, need digit before decimal point (mm)
lid_buffer_z = -0.25; 
// Adjust depth of fingernail hole, make this bigger to make the hole deeper (mm)
slot_adjust = 1;

/* [Hidden] */
fudge = .01;
wall_sub = wall_thickness*2;

function SumList(list, start, end) = (start == end) ? 0 : list[start] + SumList(list, start+1, end);
function ComputeInnerBoxDimension(compartment_list_x, compartment_list_y) = [SumList(compartment_list_x, 0, len(compartment_list_x)) + (len(compartment_list_x) - 1)*divider_thickness, SumList(compartment_list_y, 0, len(compartment_list_y)) + (len(compartment_list_y) - 1)*divider_thickness, compartment_height];
function ComputeOuterBoxDimension(innerBox) = [innerBox[0] + wall_thickness*2, innerBox[1] + wall_thickness*2, innerBox[2] + wall_thickness*2];
function lid_cut_height() = wall_thickness + hole_buffer_z;
function lid_solid_height() = wall_thickness + lid_buffer_z;

module Lid(innerBox, outerBox, cutting)
{
    /*
    Lid profile

       boxX - 2* wall thickness + 2*(wall thickness/tan(trap angle))
    p0 ---------------- p1
       \) trap angle  /
        \            /
    P3   ------------   p2
         boxX - 2* wall thickness
         
  */

  // define how snug the fit should be on the lid
  // when this sub is used to "cut" enlarge the dimensions to make the opening larger
  buffer_z = cutting == true ? hole_buffer_z + fudge : lid_buffer_z;
  buffer_x = cutting == true ? hole_buffer_x : lid_buffer_x;
  buffer_y = cutting == true ? hole_buffer_y : lid_buffer_y;
    
  // define the lid width (X)
  lidX = outerBox[0] - wall_sub + buffer_x;

  // define the length of the lid (Y) 
  lidY = outerBox[1] - wall_thickness + buffer_y;

  // define the thickness of the lid
  lidZ = wall_thickness + buffer_z;

  // define slot dimensions
  slotX = lidX*.9;
  slotY = 5;

  // define the angle in the trapezoid; this needs to be less than 45 for most printers
  trapAngle = 70;
  lidAdd = wall_thickness/tan(trapAngle);

  // define points for the trapezoidal lid
  p0 = [0, 0];
  p1 = [lidX, 0];
  p2 = [lidX + lidAdd, lidZ];
  p3 = [0 + -lidAdd , lidZ];  
 
    //center the lid
    translate([-lidX/2, -lidZ/2, 0])
        // rotate the lid -90 degrees 
        rotate([-90])

                difference() 
                {   
                    // draw a polygon using the points above and then extrude
                    // linear extrude only works in the Z axis so everything has to be rotated after
                    linear_extrude(height = lidY, center = true) 
                        polygon([p0, p1, p2, p3], paths = [[0, 1, 2, 3]]); 

                    if (cutting == false) 
                    {
                        // add a fingernail slot for making opening the lid easier
                        // the variable names are a bit wonky because the lid is drawn rotated -90 degrees
                        translate([lidX/2, -(lidZ), lidY/2-slotY*2])
                          roundedBox([slotX, lidZ - slot_adjust, slotY], radius = slotY/2, $fn=36);

                        // make a hole for the catch  
                        if(print_catch == "yes")
                        {
                           echo("Printing Catch");
                           translate([lidX/2, lidZ/2, -lidY/2 + wall_thickness*catch_wall_ratio])
                            cube([catch_hole_ratio*lidX, wall_thickness*2, catch_hole_diameter], center=true); 
                        }
                        if(lid_text != [])
                        {
                            echo("printing lid text");
                            text_minY = (lidY/2)-(slotY*3.2)-lid_text_y_spacing;
                            text_maxY = (print_catch == "yes") ? -lidY/2 + wall_thickness*catch_wall_ratio+lid_text_y_spacing+2 : -lidY/2+2+lid_text_y_spacing;
                            text_height = text_minY- text_maxY;
                            h = 12;
                            
                            translate([(lidX/2), lid_text_depth-.1, text_minY])
                            rotate([90])
                            resize([lidX-(2*lid_text_x_spacing), text_height], auto = [true, true, false])
                            linear_extrude(height=lid_text_depth, convexity=4)
                            union() {
                                for(text = [0:len(lid_text)-1]) {
                                    translate([0,-h*text,0]) text(lid_text[text], valign = "top", halign="center");
                                }
                            }
                                
                        }
                    } 
                }

}

module DrawDivider(baseLength)
{
  /*
    divider profile, we'll extrude this to divider_thickness, then rotate it into place
    if max_height and min_height are the same, we'll leave out points 0 and 1

               
      
        p0 -------- p1
          /        \  divider_max_height - divider_min_height
         /          \
    P5   ------------   p2
        |            |
        |            | divider_min_height
        |            |
     p4 -------------- p3
         
         
  */
    
    drawTop = (divider_max_height > divider_min_height) ? true : false;
    
    topLength = baseLength*divider_percent_at_max_height;
    
    p0 = [-topLength/2, divider_max_height];
    p1 = [topLength/2, divider_max_height];
    
    p2 = [baseLength/2, divider_min_height];
    p3 = [baseLength/2, 0];
    p4 = [-baseLength/2, 0];
    p5 = [-baseLength/2, divider_min_height];
        
    points = drawTop ? [p0, p1, p2, p3, p4, p5] : [p2, p3, p4, p5];
    paths = drawTop ? [0, 1, 2, 3, 4, 5] : [0, 1, 2, 3];
    
    rotate([90])
        linear_extrude(height = divider_thickness, center = true) 
            polygon(points, paths = [paths]); 
}

module MakeXDividers(innerBox, outerBox, x_compartment_sizes) 
{               
    vectorSize = len(x_compartment_sizes);
    echo("x_compartment_sizes=", x_compartment_sizes);
    // make the list of divider positions
    for(n=[1:vectorSize])
    {
        if(n != vectorSize)
        {
            // need sum size of compartments up to this one
            sum = SumList(x_compartment_sizes, 0, n);
            dividerPos = -innerBox[0]/2 + sum + divider_thickness*(n-1) + divider_thickness/2;
            echo("x dividerPos=", dividerPos);
            translate([dividerPos, 0, -divider_max_height/2 - fudge]) 
                rotate([0, 0, 90])
                    DrawDivider(innerBox[1]);
        }
    }   
}

module MakeYDividers(innerBox, outerBox, y_compartment_sizes) 
{            
    vectorSize = len(y_compartment_sizes);
    echo("y_compartment_sizes=", y_compartment_sizes);
    // make the list of divider positions
    for(n=[1:vectorSize])
    {
        if(n != vectorSize)
        {
            // need sum size of compartments up to this one
            sum = SumList(y_compartment_sizes, 0, n);
            dividerPos = -innerBox[1]/2 + sum + divider_thickness*(n-1) + divider_thickness/2;
            echo("y dividerPos=", dividerPos);
                translate([0, dividerPos, -divider_max_height/2 - fudge]) 
                    DrawDivider(innerBox[0]);
        }
    }    
}

module BasicBox(innerBox, outerBox)
{
    // Set the curve refinement
    $fn = 36;

    // Create the box then subtract the inner volume and make a cut for the sliding lid
    difference() 
    {
        // call the MCAD rounded box command imported from MCAD/boxes.scad
        // size = dimensions; radius = corner curve radius; sidesonly = round only some sides

        // First draw the outer box
        roundedBox(size = outerBox, radius = corner_rad, sidesonly = 1);
        // Then cut out the inner box
        roundedBox(size = innerBox, radius = corner_rad, sidesonly = 1);
        // Then cut out the lid
        translate([0, 0, (outerBox[2]/2)+fudge])
          Lid(innerBox, outerBox, cutting = true); 
    }
}

module MakeCatch(innerBox, outerBox)
{
    // Set the curve refinement
    $fn = 36;
    
    translate([0, -outerBox[1]/2 + wall_thickness*catch_wall_ratio, innerBox[2]/2])
        union()
        {
            translate([catch_bump_ratio*innerBox[0]/2, 0, 0])
                sphere(catch_diameter/2);   
            translate([-catch_bump_ratio*innerBox[0]/2, 0, 0])
                    sphere(catch_diameter/2);
            rotate([0, 90, 0])
                cylinder(catch_bump_ratio*innerBox[0], catch_diameter/2, catch_diameter/2, center=true);
        }
}

module DividedBox(innerBox, outerBox)
{
    innerBox = ComputeInnerBoxDimension(x_compartment_sizes, y_compartment_sizes);
    outerBox = ComputeOuterBoxDimension(innerBox);
    
    BasicBox(innerBox, outerBox);
    MakeXDividers(innerBox, outerBox, x_compartment_sizes);
    MakeYDividers(innerBox, outerBox, y_compartment_sizes);  
    if(print_catch == "yes")
    {
        MakeCatch(innerBox, outerBox);
    }
}

module PrintPart()
{   
    echo("x_compartment length=", len(x_compartment_sizes));
    echo("sum x compartments=", SumList(x_compartment_sizes, 0, len(x_compartment_sizes)));
 
    echo("y_compartment length=", len(y_compartment_sizes));
    echo("sum y compartments=", SumList(y_compartment_sizes, 0, len(y_compartment_sizes)));
    
    innerBox = ComputeInnerBoxDimension(x_compartment_sizes, y_compartment_sizes);
    outerBox = ComputeOuterBoxDimension(innerBox);
 
    echo("InnerBox=", innerBox);
    echo("OuterBox=", outerBox);
    
    if(part == "first")
    {    
        translate([0, 0, outerBox[2]/2])
            DividedBox(innerBox, outerBox);
    }
    else if(part == "second")
    {
        translate([0, 0, lid_solid_height()])
            Lid(innerBox, outerBox, cutting=false);
    }
    else
    {
        translate([-outerBox[0]/2 - wall_thickness, 0, outerBox[2]/2])
            DividedBox(innerBox, outerBox);
        
        translate([outerBox[0]/2 + wall_thickness, 0, lid_solid_height()])
            Lid(innerBox, outerBox, cutting=false);
    }
}

PrintPart();
