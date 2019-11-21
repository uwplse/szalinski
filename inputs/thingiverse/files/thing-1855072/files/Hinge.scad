//All dimensions in milimeters

Hinge_Screw_Space = 0.4;

Hinge_Screw_Body_Dia = 3 + Hinge_Screw_Space;
Hinge_Screw_Body_Lenght = 5;
Hinge_Screw_Head_Dia = 5.5 + Hinge_Screw_Space;
Hinge_Screw_Head_Height = 2 + Hinge_Screw_Space;

Hinge_Space = 0.5;
Hinge_Body_x = 40;
Hinge_Body_y = 15;
Hinge_Body_z = Hinge_Screw_Head_Height + Hinge_Screw_Body_Lenght - 3;   //3mm of screw look out
Hinge_Hole_InnerDia = 3 + Hinge_Space;
Hinge_Hole_OutterDia = (Hinge_Body_z + Hinge_Space) * 2;
Hinge_NumOfGrips = 4;
Hinge_NumOfHoles = 3;

Hinge_SmoothEdges_Size_z = 4;
Hinge_SmoothEdges_Size_x = 2;

Hinge_ScrewsHole_Dia = Hinge_Body_x - (2 * (Hinge_Body_x / 5));
Hinge_ScrewHoleAxis_Space = Hinge_Body_y - (Hinge_Body_y - (Hinge_Hole_OutterDia / 2));

Hinge_Axis_Space = 0.2;
Hinge_Axis_Dia = Hinge_Hole_InnerDia - Hinge_Space - Hinge_Axis_Space;
Hinge_Axis_Head = 3;

Hinge_Show = true;
Hinge_Show_Axis = false;

module Hinge()
{
  echo("Hinge - Diameter of holes = ", Hinge_ScrewsHole_Dia, "mm");
  echo("Hinge - Space between screws and axis = ", Hinge_ScrewHoleAxis_Space, "mm");

  translate([-(Hinge_Body_x / 5), -((Hinge_Body_y - (Hinge_Hole_OutterDia / 2)) / 2), 0])
  {
    difference()
    {
      union() //Things to add
      {
        cube([Hinge_Body_x, Hinge_Body_y,Hinge_Body_z]);
        translate([0, Hinge_Body_y, Hinge_Body_z + Hinge_Space])
        {
          rotate([0, 90, 0])
          {
            cylinder(d = Hinge_Hole_OutterDia, h = Hinge_Body_x, $fn = 40);
          }
        }
      }
      
      union() //Things to substract
      {
        //Holes for screws
        for(NumHole = [1 : 1 : Hinge_NumOfHoles])
        {
          translate([(NumHole * (Hinge_Body_x / (Hinge_NumOfHoles + 1))), ((Hinge_Body_y - (Hinge_Hole_OutterDia / 2)) / 2), 0]) 
          {
            cylinder(d = Hinge_Screw_Body_Dia, h = Hinge_Body_z, $fn = 40);
          }
          translate([(NumHole * (Hinge_Body_x / (Hinge_NumOfHoles + 1))), ((Hinge_Body_y - (Hinge_Hole_OutterDia / 2)) / 2), Hinge_Body_z - Hinge_Screw_Head_Height]) 
          {
            cylinder(d = Hinge_Screw_Head_Dia, h = Hinge_Screw_Head_Height, $fn = 40);
          }
        }
        //Hole for axis
        translate([0, Hinge_Body_y, Hinge_Body_z + Hinge_Space])
        {
          rotate([0, 90, 0])
          {
            cylinder(d = Hinge_Hole_InnerDia, h = Hinge_Body_x, $fn = 40);
          }
        }
        //Holes for second hinge
        for(NumGrip = [0 : 1 : (Hinge_NumOfGrips - 1)])
        {
          translate([(NumGrip * 2) * (Hinge_Body_x / (Hinge_NumOfGrips * 2)), Hinge_Body_y, Hinge_Body_z + Hinge_Space])
          {
            rotate([0, 90, 0])
            {
              cylinder(d = Hinge_Hole_OutterDia + Hinge_Space, h = (Hinge_Body_x / (Hinge_NumOfGrips * 2)) + Hinge_Space, $fn = 40);
            }
          }
        }
        //Smooth edges
        translate([Hinge_SmoothEdges_Size_z, Hinge_SmoothEdges_Size_z - 0.00001, 0])
        {
          rotate([0, 0, 180])
          {
            difference()
            {
              cube([Hinge_SmoothEdges_Size_z, Hinge_SmoothEdges_Size_z, Hinge_Body_z]);
              cylinder(d = (Hinge_SmoothEdges_Size_z * 2), h = Hinge_Body_z, $fn = 40);
            }
          }
        }
        translate([Hinge_Body_x - Hinge_SmoothEdges_Size_z + 0.0001, Hinge_SmoothEdges_Size_z - 0.00001, 0])
        {
          rotate([0, 0, 270])
          {
            difference()
            {
              cube([Hinge_SmoothEdges_Size_z, Hinge_SmoothEdges_Size_z, Hinge_Body_z]);
              cylinder(d = (Hinge_SmoothEdges_Size_z * 2), h = Hinge_Body_z, $fn = 40);
            }
          }
        }
        translate([0, Hinge_SmoothEdges_Size_x - 0.00001, Hinge_Body_z - Hinge_SmoothEdges_Size_x])
        {
          rotate([180, -90, 0])
          {
            difference()
            {
              cube([Hinge_SmoothEdges_Size_x, Hinge_SmoothEdges_Size_x, Hinge_Body_x]);
              cylinder(d = (Hinge_SmoothEdges_Size_x * 2), h = Hinge_Body_x, $fn = 40);
            }
          }
        }
      }
    }
  }
}

module Hinge_Axis()
{
  difference()
  {
    translate([0, 0, (Hinge_Axis_Dia / 2) - 0.5])
    {
      rotate([-90, 0, 0])
      {
        union()
        {
          cylinder(d = Hinge_Axis_Dia, h = Hinge_Body_x + Hinge_Axis_Head, $fn = 40);
          cylinder(d = Hinge_Hole_OutterDia, h = Hinge_Axis_Head, $fn = 40);
        }
      }
    }
    translate([-(Hinge_Hole_OutterDia / 2), 0, -Hinge_Hole_OutterDia])
    {
      cube([Hinge_Hole_OutterDia, Hinge_Body_x + Hinge_Axis_Head + 0.0001, Hinge_Hole_OutterDia]);
    }
  }
}
if(Hinge_Show)
{
  Hinge();
}
if(Hinge_Show_Axis)
{
  Hinge_Axis();
}