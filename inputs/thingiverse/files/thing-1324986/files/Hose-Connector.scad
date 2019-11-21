/*
Adapted from: Hose barb adapter and manifold by papergeek  www.thingiverse.com/thing:158717


This version gives you a few different options you can change the shape of the middle section on a two way connector so that it is round or hex shaped. the option to add multiple connections in two different sizes.

update 5/3/2016

Added the option to create a "L" shaped two way connection.

*/
// Number of tubes size A's to connect. 
Number_of_Size_A = 2;
// Number of tubes size B's to connect. Size A should be the smaller hose
Number_of_Size_B = 0;

// Hose A inside diameter or bore
Size_A = 4; 
// Hose B inside diameter or bore
Size_B = 8; 

// Manifold Bore = Size - Wall Thickness thicker walls are stronger but have a smaller bore. 
// Wall_Thickness_n must be less than Size_n

// Wall_Thickness_A must be less than Size_A
Wall_Thickness_A = 1;
// Wall_Thickness_B must be less than Size_B
Wall_Thickness_B = 1;

// on 3 and 4 port connectors you can choose if the manifold is square "T" or polygon "Y" OR "L" for a two port connector at right angles
junction_type = "T"; // [Y, T, L]

// Number of barbs on output - try 3 for larger tubing to reduce overall print height try 4 for smaller tubing
Size_A_barb_count = 4;
Size_B_barb_count = 3;

// For 2 port(inline) connectors the shoulder can be hexagional to fit a spanner or round
Inline_Connector = "round"; // [round, hex]
// Size across the flats of the Hex
Hex_Size = 8; 
// How much shoulder overhanging the largest port on round inline connectors.
Shoulder = 1;


// Hidden Variables used throught the sketch dont't sugest changing these
Size_A_Bore = Size_A - (Wall_Thickness_A * 2);
Size_B_Bore = Size_B - (Wall_Thickness_B * 2);
//change manifold to hex shaped
Edges = Inline_Connector == "hex" ? 6 : 100 ; 

Number_of_Faces = Number_of_Size_A + Number_of_Size_B;


// create inline connector
if (Number_of_Faces == 2 && junction_type !="L")
{
  Size = Number_of_Size_A == 2 ? Size_A : Size_B ;
  HYP = (Hex_Size / 2) / cos(30);
  Size_1 = Inline_Connector == "hex" ? (HYP * 2) : (Size + 2*Shoulder) ; // size of manifols 
  Bore_1 = Number_of_Size_A > 1 ? Size_A_Bore : Size_B_Bore ; 
  Bore_2 = Number_of_Size_A > 0 ? Size_A_Bore : Size_B_Bore ;

  union()
  {
    difference()
    {
      cylinder( h = Size , d = Size_1, center = true, $fa = 0.5, $fs = 0.5, $fn = Edges )  ;
      cylinder(h = Size + 1, d1 = Bore_1, d2 = Bore_2, center = true, $fa = 0.5, $fs = 0.5 );
    }

// Top port
    translate([0, 0, Size / 2])
    {
      if (Number_of_Size_A > 0)
      {
        connector_size_A();
      }
      else
      {
        connector_size_B();
      }
    }
// Bottom port
    translate([0, 0, -Size / 2])rotate([180, 0, 0])
    {
      if (Number_of_Size_A == 2)
      {
        connector_size_A();
      }
      else
      {
        connector_size_B();
      }
    }
  }
}

// Multi port manifold

if (Number_of_Faces > 2 || junction_type == "L")
{
  Port_Height = Number_of_Size_B > 0 ? Size_B : Size_A ;
  Port_Bore = Number_of_Size_B > 0 ? Size_B_Bore : Size_A_Bore;
  Face_Height = Port_Height * 1.5;

  junction = Number_of_Faces > 4 ? "Y" : junction_type  ;
  Smooth = Inline_Connector == "round" ? Number_of_Faces + 100 : Number_of_Faces;

  angleA = (360 / (Number_of_Size_A + Number_of_Size_B));
  angleB = 90;
  angle = junction == "Y" ? angleA : angleB ;

      /*  To calculate the Apothem (or radius of a polygon's inner circle)
        Apothem = R * Cos *(180/N)

          where:
          R = radius of polygons outer circle or circumcircle
          N = number of sides/faces
    */
  Radius = (Port_Height* 1.16 ) / (2 * sin(180 / Number_of_Faces));
  Apothem  = junction == "L" ? Port_Height* 1.16 : (Radius + 4) * cos(180 / Number_of_Faces) ;
//  Apothem = (Radius + 4) * cos(180 / Number_of_Faces);



// create body of manifold  
  union()
  {
    difference()
    {
      if ( junction == "Y")
      {
        rotate([0, 0, angle / 2])cylinder( h = Face_Height , r = Radius + 4, center = true, $fa = 0.5, $fs = 0.5, $fn = Smooth )  ;
      }
      if (junction == "T")
      {
        cube( Apothem *2 , center = true, $fa = 0.5, $fs = 0.5);
      }
      if ( junction == "L")
      {
        cube( Apothem * 2 , center = true, $fa = 0.5, $fs = 0.5);
      }
      
      cylinder( h = Port_Bore , d = Port_Height, center = true, $fa = 0.5, $fs = 0.5, $fn = Number_of_Faces )  ;

// bore holes for the ports
      if (Number_of_Size_A > 0)
      {
        for (n = [1:Number_of_Size_A ])
        {
          rotate([angle * n, 90, 0]) cylinder( h = Apothem *2 , d = Size_A_Bore, center = false, $fa = 0.5, $fs = 0.5);
        }
      }
      if (Number_of_Size_B > 0)
      {
        for (n = [1:Number_of_Size_B  ])
        {
          rotate([(angle * n) + (angle * Number_of_Size_A), 90, 0]) cylinder( h = Apothem *2 , d = Size_B_Bore, center = false, $fa = 0.5, $fs = 0.5);
        }
      }


    }
// Add the ports
    
    if (Number_of_Size_A > 0)
    {
      for (i = [1:Number_of_Size_A ])
      {
        rotate([angle * i, 90, 0])translate([0, 0, Apothem - 0.5])  connector_size_A();
      }
    }
    if (Number_of_Size_B > 0)
    {
      for (i = [1:Number_of_Size_B ])
      {
        rotate([(angle * i) + (angle * Number_of_Size_A), 90, 0])translate([0, 0, Apothem - 0.5])  connector_size_B();
      }
    }
  }
}



module connector_size_A()
{
  difference()
  {
    union()
    {
      for ( i = [1:Size_A_barb_count])
      {
        translate([0, 0, (i - 1) * Size_A * 0.9]) cylinder( h = Size_A , r2 = Size_A * 0.85 / 2, r1 = Size_A * 1.16 / 2, $fa = 0.5, $fs = 0.5 );

      }
    }
    translate([0, 0, -0.1]) cylinder( h = Size_A * Size_A_barb_count , d = Size_A_Bore , $fa = 0.5, $fs = 0.5 );
  }
}
module connector_size_B()
{
  difference()
  {
    union()
    {
      for ( i = [1:Size_B_barb_count])
      {
        translate([0, 0, (i - 1) * Size_B * 0.9]) cylinder( h = Size_B , r2 = Size_B * 0.85 / 2, r1 = Size_B * 1.16 / 2, $fa = 0.5, $fs = 0.5 );

      }
    }
    translate([0, 0, -0.1]) cylinder( h = Size_B * Size_B_barb_count , d = Size_B_Bore , $fa = 0.5, $fs = 0.5 );
  }
}
