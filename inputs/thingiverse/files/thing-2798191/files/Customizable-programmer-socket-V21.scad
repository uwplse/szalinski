//              to do

/*
    create svg file for editing in to Fritzing main file has been edited so need to review SVG module

    Create base Module

*/

/* [Chip details] */
CHIP_Width = 16;
Chip_Height = 48;

// How many pins along the side
Number_Pins_Horizontal = 4;
// How many pins along the bottom
Number_Pins_Vertical = 12;

Pin_Spacing = 3;
// To the bottom edge of the first pad from the bottom left corner on the verticle edges
Space_Befor_First_Pin_V = 2.0;
// To the left side of the first pad from the bottom left corner on the horizontal edges
Space_Befor_First_Pin_H = 4;
// The lenght of the pad on the side of the pcb
PAD_WIDTH = 1;
// Gap arround each edge of the chip to allow for errors.
Chip_Margin = 0.2;


/* [Socket Variables] */

Base_thickness = 1;
Wall_Thickness = 3;
// If there are no connections along the top of the board the STL file will have a cutout, to aid in getting the module in and out.
Top_End_Open = "yes"; // [yes,no]
Open_Top_End = Top_End_Open == "yes" ? true : false;


// length of any studs on the bottom. Set to 0 if you don't want studs!
Stud_Depth = 3;

Socket_Width = CHIP_Width + (Chip_Margin * 2) ;
Socket_Height = Chip_Height + (Chip_Margin * 2);

/* [Pin details] */

// How much pin above socket base
Pin_Height = 6.1;
// Widest dimention  of sprung part of the pin
Pin_body = 2.6;
Contact_Pin_body = Pin_body - 0.1;

// Width of the pin's main body
Pin_width = 0.75;
// Width of the leg
Pin_Leg = 0.75;


unit_Width = Socket_Width + (Wall_Thickness * 2);
unit_Height = Socket_Height + (Wall_Thickness * 2);

unit_Depth = Pin_Height + Base_thickness;

/*[Lable]*/
//Lable printed into the socket
Text = "ESP-12E";
Letter_Size = 2;

/*[Base]*/
Base_Depth = 1;
Offset1_X = 1.27;
Offset1_Y = 0;

Offset2_X = 3.8;
Offset2_Y = 2.54;

/*[Other]*/
// Which STL's do you need? The base is of greatest use when you have hole in the pcb which are not in-line with the pins in the socket
part = "Body"; // [Body, Base, Both]

/*[Hidden]*/

// SVG settings

Pin_Hole = 0.75;
copper = 0.508;
Surface_Mount = "no"; // [yes,no]
smd = Surface_Mount == "yes" ? true : false;
Pads = "Inside";//[Inside : Outside]
Pads_inside = Pads == "Inside" ? true : false;
SVG = "silk"; // [silk, copper]

Chip_Recess = 0.5;
//render settings
$fs = 0.2 * 1; // def 1, 0.2 is high res
$fa = 3 * 1; //def 12, 3 is very nice

print_part();
//Print_SVG();

module print_part()
{
  if (part == "Body")
  {
    Body();
  }
  else if (part == "Base")
  {
    Base();
  }
  else if (part == "Both")
  {
    Body();
    Base();
  }
}


module Body()
{
  // create basic shape of socket
  difference()
  {
    // the basic shape
    cube([unit_Width, unit_Height, unit_Depth]);
    {
      // remove chip space
      translate([Wall_Thickness, Wall_Thickness, Base_thickness])
      cube([Socket_Width, Socket_Height, Pin_Height + 1]);
      // part lable
      translate([unit_Width / 2, Wall_Thickness + 5, Base_thickness / 2])
      Add_Text();
      //Champher top edges
      translate([Wall_Thickness, Wall_Thickness, Base_thickness + (Pin_Height - 1)])
      {
        // W H D makes the code more readable here.
        W = Socket_Width;
        H = Socket_Height;
        D = 1.01;
        polyhedron(
          points = [ [W, H, 0], [W, 0, 0], [0, 0, 0], [0, H, 0], // bottom points
                     [W + D, H + D, D], [W + D, -D, D], [-D, -D, D], [-D, H + D, D]  ],              // Top points
          faces = [ [0, 1, 4], [4, 1, 5], [1, 2, 5], [5, 2, 6], [2, 3, 6], [6, 3, 7], [3, 0, 4], [4, 7, 3],
                    [1, 0, 3], [2, 1, 3], [5, 7, 4 ], [6, 7, 5] ]  );
      }
      // Add thumb slot if open ended
      if (Open_Top_End == true)
      {
        translate([unit_Width / 2, unit_Height - 1, -1])
        {
          cylinder(h = unit_Depth + 1.5 , d = Socket_Width - 4, center = false);
        }
        translate([Wall_Thickness + 1, unit_Height - (Wall_Thickness + 1) , Base_thickness])
        {
          cube([CHIP_Width - 2, Wall_Thickness + 2, unit_Depth]);
        }
      }

      // Remove slots for the pins
      // Slots for the sides
      for (i = [0: Number_Pins_Vertical - 1])
      {
        translate([Wall_Thickness - Contact_Pin_body + Chip_Margin , Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) - (Pin_width / 2) - 0.1  + (i * Pin_Spacing), Base_thickness - Chip_Recess])
        {
          cube([Contact_Pin_body + 0.1, Pin_width + 0.2 , Pin_Height + Chip_Recess + 1]);

          translate([0, (Pin_width + 0.2) / 2 - (Pin_Leg+0.2) / 2 , -2])
          cube([0.5, Pin_Leg + 0.2 , Base_thickness + 2.1]);
        }


        translate([unit_Width - Wall_Thickness + Contact_Pin_body - Chip_Margin, Wall_Thickness + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) - (Pin_width / 2) - 0.1 + Chip_Margin + (i * Pin_Spacing), Base_thickness - Chip_Recess])mirror([1, 0, 0])
        {
          cube([Contact_Pin_body + 0.1, Pin_width + 0.2 , Pin_Height + Chip_Recess + 1]);
          translate([0, (Pin_width + 0.2) / 2 - (Pin_Leg+0.2) / 2, -2])
          cube([0.5, Pin_Leg + 0.2 , Base_thickness + 2.1]);
        }
      }

      //  Slots for the bottom
      if (Number_Pins_Horizontal != 0)
      {
        for (i = [0:Number_Pins_Horizontal - 1])
        {
          translate([ Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) - (Pin_width / 2) - 0.1 + (i * Pin_Spacing), Wall_Thickness - Contact_Pin_body + Chip_Margin, Base_thickness - Chip_Recess])
          {
            cube([Pin_width + 0.2 , Contact_Pin_body + 0.1, Pin_Height + Chip_Recess + 1]);
            translate([ (Pin_width + 0.2) / 2 - (Pin_Leg+0.2) / 2, 0, -2])
            cube([ Pin_Leg + 0.2 , 0.5, Base_thickness + 2.1]);
          }

          if (Open_Top_End == false)
            translate([ Wall_Thickness  + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) - (Pin_width / 2) - 0.1 + (i * Pin_Spacing), unit_Height - Wall_Thickness + Contact_Pin_body - Chip_Margin, Base_thickness - Chip_Recess]) mirror([0, 1, 0])
          {
            cube([Pin_width + 0.2 , Contact_Pin_body + 0.1, Pin_Height + Chip_Recess + 1]);
            translate([ (Pin_width + 0.2) / 2 - (Pin_Leg+0.2) / 2, 0, -2])
            cube([ Pin_Leg + 0.2 , 0.5, Base_thickness + 2.1]);
          }
        }
      }
    }
  }
 
    Feet();
}

module Add_Text(letter = Text, size = Letter_Size)
{
  // convexity is needed for correct preview
  // since characters can be highly concave
  linear_extrude(height = 2 * Base_thickness + 2, convexity = 4)
  text(letter, size,
       font = "Bitstream Vera Sans",
       halign = "center", // left = left alined
       valign = "center");
}

module Feet(height=Stud_Depth,diameter = 1.5)
{

  // Studs
  translate([2, 2, -Stud_Depth]) cylinder(h = height + 0.2, d = diameter, center = false);
  translate([unit_Width - 2, 2, -Stud_Depth]) cylinder(h = height + 0.2, d = diameter, center = false);
  translate([2, unit_Height - 2, -Stud_Depth]) cylinder(h = height + 0.2, d = diameter, center = false);
  translate([unit_Width - 2, unit_Height - 2, -Stud_Depth]) cylinder(h = height + 0.2, d = diameter, center = false);
}

module Base()
{
  translate([0, 0, -Base_Depth])
  {
    difference()
    {

        cube([unit_Width, unit_Height, Base_Depth]);
      
      Feet(Stud_Depth+Base_Depth,1.75);
      // Add thumb slot if open ended
      if (Open_Top_End == true)
      {
        translate([unit_Width / 2, unit_Height - 1, -1]) cylinder(h = Base_Depth + 1.5 , d = Socket_Width - 4, center = false);
      }

      //Holes for Pin Legs
      //sides
      for (i = [0:Number_Pins_Vertical - 1])
      {
        translate([Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2), Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing), 0])
          {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
              OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
              translate ([OffSetX, OffSetY,0])  rotate([0, 0, 45]) cylinder(h = Base_Depth + 0.2, d1 = Pin_Leg + 0.2, d2 = 1, $fn = 4, center = false);
          }

        translate([unit_Width - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2), Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing), 0])
          {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
              OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
              translate ([-OffSetX, -OffSetY,0])  rotate([0, 0, 45]) cylinder(h = Base_Depth + 0.2, d1 = Pin_Leg + 0.2, d2 = 1, $fn = 4, center = false);
          }
      }
      // Top and bottom
      if (Number_Pins_Horizontal != 0)
      {
        for (i = [0:Number_Pins_Horizontal - 1])
        {       
          translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing), Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2), 0])
            {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
              OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
              translate ([ -OffSetY, OffSetX,0])  rotate([0, 0, 45]) cylinder(h = Base_Depth + 0.2, d1 = Pin_Leg + 0.2, d2 = 1, $fn = 4, center = false);
                }
          if  (Open_Top_End == false)
          {
            translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing), unit_Height - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2), 0])
              {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
              OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
              translate ([OffSetX, -OffSetY,0])  rotate([0, 0, 45]) cylinder(h = Base_Depth + 0.2, d1 = Pin_Leg + 0.2, d2 = 1, $fn = 4, center = false);
          }
          }
        }
      }
    }
  }
}




module Print_SVG()
{
    if (SVG == "silk")
    {
        Silkscreen();// silkscreen and board
    }
    if (SVG == "copper")
    {
        Copper();
    }
}
module Silkscreen()
{
// Silk Screen
  difference()
  {
    color("red")
// the basic shape
    square([unit_Width, unit_Height]);
// Cut out thumb slot
    if (Open_Top_End == true) translate([unit_Width / 2, unit_Height - 1])
    {
      circle(d = Socket_Width - 4);
    }
//Holes for Pins
    if (smd == false)
    {
//sides
      for (i = [0:Number_Pins_Vertical - 1])
      { 
          translate([Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2) , Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing)])
          {
          OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ OffSetX, OffSetY])         
          circle(d = Pin_Hole );
          }

        translate([unit_Width - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2) , Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing)])
          {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ -OffSetX, -OffSetY])         
          circle(d = Pin_Hole );
          }
      }
// Top and bottom
      if (Number_Pins_Horizontal != 0)
      {
        for (i = [0:Number_Pins_Horizontal - 1])
        {
          translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing) , Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2)])
            {
            OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ -OffSetY, +OffSetX]) circle(d = Pin_Hole );
            }
          if  (Open_Top_End == false)
          {
            translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing) , unit_Height - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2) ])
               {
            OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ +OffSetY, -OffSetX]) circle(d = Pin_Hole );
            }
          }
        }
      }
    }
// Studs
    translate([2, 2]) circle(d = 2);
    translate([unit_Width - 2, 2]) circle(d = 2);
    translate([2, unit_Height - 2]) circle(d = 2);
    translate([unit_Width - 2, unit_Height - 2]) circle(d = 2);
  }
}



//Copper
module Copper()
{

  color ("Yellow");
  if (smd == false)
    {
//sides
      for (i = [0:Number_Pins_Vertical - 1])
      { 
          translate([Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2) , Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing)])
          {
          OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ OffSetX, OffSetY])         
          circle(d = Pin_Hole );
          }

        translate([unit_Width - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2) , Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V + (PAD_WIDTH / 2) + (i * Pin_Spacing)])
          {
              OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ -OffSetX, -OffSetY])         
          circle(d = Pin_Hole );
          }
      }
// Top and bottom
      if (Number_Pins_Horizontal != 0)
      {
        for (i = [0:Number_Pins_Horizontal - 1])
        {
          translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing) , Wall_Thickness - Contact_Pin_body + Chip_Margin + (Pin_Hole / 2)])
            {
            OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ -OffSetY, +OffSetX]) circle(d = Pin_Hole );
            }
          if  (Open_Top_End == false)
          {
            translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H + (PAD_WIDTH / 2) + (i * Pin_Spacing) , unit_Height - Wall_Thickness + Contact_Pin_body - Chip_Margin - (Pin_Hole / 2) ])
               {
            OffSetX = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_X : Offset2_X;
          OffSetY = (round ((i +1)/2)) - (round (i / 2 )) == 1 ? Offset1_Y : Offset2_Y;
          translate ([ +OffSetY, -OffSetX]) circle(d = Pin_Hole );
            }
          }
        }
      }
    }

// smd
  if (smd == true)

  {
//sides
    for (i = [0:Number_Pins_Vertical - 1])
    {
      translate([-2, Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V  + (i * Pin_Spacing)])
      square([Wall_Thickness + 2, PAD_WIDTH]);

      translate([unit_Width + 2, Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_V  + (i * Pin_Spacing)]) mirror([1, 0, 0])
      square([Wall_Thickness + 2, PAD_WIDTH]);
    }
// Top and bottom
    if (Number_Pins_Horizontal != 0)
    {
      for (i = [0:Number_Pins_Horizontal - 1])
      {
        translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H  + (i * Pin_Spacing), -2])
        square([PAD_WIDTH, Wall_Thickness + 2]);
        if  (Open_Top_End == false)
        {
          translate([Wall_Thickness + Chip_Margin + Space_Befor_First_Pin_H  + (i * Pin_Spacing), unit_Height + 2])mirror([0, 1, 0])
          square([PAD_WIDTH, Wall_Thickness + 2]);
        }
      }
    }
  }
}
