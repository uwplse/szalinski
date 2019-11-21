//_____________________________________________//
//       Game of thrones Board Game            //
//     Box organizer and play surface          //
//=============================================//

//Author: Tomas Matecha
//Date: 11. 12. 2016
//Info: All dimensions are in mm

//___________Settings_of_printer________________
//Nozzle dia = 0.4
//Layer height = 0.3
//Supports = NO

//___________Genreal_settins____________________
Wall = 1.2;
Space = 1;

//___________Dimensions_of_parts________________
//General
Token_h = 2.3;
Card_h = 0.3;
//Sum of tokens per one player
  //Order token
  Token_Order_Dia = 25.5 + Space;
  Token_Order_h = Token_h;
  Token_Order_Type = 5;
  Token_Order_Num = 3;
  //Influence token
  Token_Influence_Dia = 21.5;
  Token_Influence_h = Token_h;
  Token_Influnce_Num = 3;
  //Might token
  Token_Might_x = 21.5;
  Token_Might_y = 15.5;
  Token_Might_h = Token_h;
  Token_Might_Num = 20;
  //Supply token
  Token_Supply_x = 25.5;
  Token_Supply_y = 19.5;
  Token_Supply_h = Token_h;
  Token_Supply_Num = 1;
  //Victory point token
  Token_VP_x = 25.5;
  Token_VP_y = 30;
  Token_VP_h = Token_h;
  Token_VP_Num = 1;
  //Home token
  Token_Home_x = 19;
  Token_Home_y = 35.5;
  Token_Home_h = Token_h;
  Token_Home_Num = 1;
  //Persons card
  Card_Person_x = 90;
  Card_Person_y = 57;
  Card_Person_h = Card_h;
  Card_Person_Num = 7;
  //Foot soldier
  Unit_Foot_x = 16.5 + Space;
  Unit_Foot_y = 10.5;
  Unit_Foot_h = 17;
  Unit_Foot_Num = 10;
  //Knight 
  Unit_Knight_x = 16 + Space;
  Unit_Knight_y = 10.5;
  Unit_Knight_h = 20;
  Unit_Knight_Num = 5;
  //Ship
  Unit_Ship_y = 10;
  Unit_Ship_x = 9.5 + Space;
  Unit_Ship_h = 21.5;
  Unit_Ship_Num = 6;
  //Siege tower
  Unit_Tower_x = 9.5 + Space;
  Unit_Tower_y = 14.5;
  Unit_Tower_h = 17.5;
  Unit_Tower_Num = 2;
//End of components of one player
//Common tokens and cards
  //Events and wild
  Card_Event_x = Card_Person_x;
  Card_Event_y = Card_Person_y;
  Card_Event_h = Card_h;
  Card_Event_Type = 4;
  Card_Event_Num = 10;
  //Fight card
  Card_Fight_x = 64;
  Card_Fight_y = 42;
  Card_Fight_h = Card_h;
  Card_Fight_Num = 24;
  //TownDefense token
  Token_Town_x = 32.5 + Space;
  Token_Town_y = 19.5 + Space;
  Token_Town_h = 2.5;
  Token_Town_Num = 14;
  //Turn token
  Token_Turn_x = 31 + Space;
  Token_Turn_y = 23.5 + Space;
  Token_Turn_h = 2.35 + Space;
  //Wild token
  Token_Wild_x = 22 + Space;
  Token_Wild_y = 20.5 + Space;
  Token_Wild_h = 2.35 + Space;
//End of common components

//Space for one player in the box
Space_Player_x = 80;
Space_Player_y = 94;
Space_Player_z = 40;
//Space for common components
Space_Common_x = 145;
Space_Common_y = 110;
Space_Common_z = Space_Player_z;
//Boxes
module Box_Support(height)
{
  union()
  {
    translate([Wall, Wall, height])
    {
      linear_extrude(height = Wall)
      {
      polygon(points = [[0, 0],[Box_Unit_Support - Wall, 0], [0, Box_Unit_Support - Wall]], paths = [[0,1,2]]);
      }
    }
    cube([Box_Unit_Support, Wall, height + Wall]);
    cube([Wall, Box_Unit_Support, height + Wall]);
  }
}

Box_Unit_Column = 5;
Box_Unit_In_y = (Unit_Knight_Num * Unit_Knight_y) + Space;
Box_Unit_In_z = Unit_Ship_h / 2;
Box_Unit_Out_x = ((Box_Unit_Column + 1) * Wall) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x + Unit_Tower_x + Unit_Tower_x;
Box_Unit_Out_y = Box_Unit_In_y + (2 * Wall);
Box_Unit_Out_z = Wall + Box_Unit_In_z;
Box_Unit_Support = 5;
module Box_Unit()
{
  union()
  {
    difference()
    {
      cube([Box_Unit_Out_x, Box_Unit_Out_y, Box_Unit_Out_z]);
      union()
      {
        translate([(Wall * 1), Wall, Wall])
        {
          cube([Unit_Foot_x, Box_Unit_In_y, Box_Unit_In_z]);
        }
        translate([(Wall * 2) + Unit_Foot_x, Wall, Wall])
        {
          cube([Unit_Foot_x, Box_Unit_In_y, Box_Unit_In_z]);
        }
        translate([(Wall * 3) + Unit_Foot_x + Unit_Foot_x, Wall, Wall])
        {
          cube([Unit_Knight_x, Box_Unit_In_y, Box_Unit_In_z]);
        }
        translate([(Wall * 4) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x, Wall, Wall])
        {
          cube([Unit_Ship_x, Unit_Tower_y + Space, Box_Unit_In_z]);
        }
        translate([(Wall * 4) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x, Box_Unit_In_y - ((Unit_Ship_y * 3) + Space) + Wall, Wall])
        {
          cube([Unit_Ship_x, (Unit_Ship_y * 3) + Space, Box_Unit_In_z]);
        }
        translate([(Wall * 5) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x + Unit_Ship_x, Wall, Wall])
        {
          cube([Unit_Ship_x, Unit_Tower_y + Space, Box_Unit_In_z]);
        }
        translate([(Wall * 5) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x + Unit_Ship_x, Box_Unit_In_y - ((Unit_Ship_y * 3) + Space) + Wall, Wall])
        {
          cube([Unit_Ship_x, (Unit_Ship_y * 3) + Space, Box_Unit_In_z]);
        }
      }
    }  
    translate([0, 0, Wall + (Box_Unit_In_z)])
    {
      Box_Support(Box_Unit_In_z);
    }
    translate([0, (2 * Wall) + Box_Unit_In_y, Wall + (Box_Unit_In_z)])
    {
      rotate([0, 0, -90])
      {
        Box_Support(Box_Unit_In_z);
      }
    }
    translate([((Box_Unit_Column + 1) * Wall) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x + Unit_Tower_x + Unit_Tower_x, 0, Wall + (Box_Unit_In_z)])
    {
      rotate([0, 0, 90])
      {
        Box_Support(Box_Unit_In_z);
      }
    }
    translate([((Box_Unit_Column + 1) * Wall) + Unit_Foot_x + Unit_Foot_x + Unit_Knight_x + Unit_Tower_x + Unit_Tower_x, Box_Unit_In_y + (2 * Wall), Wall + (Box_Unit_In_z)])
    {
      rotate([0, 0, 180])
      {
        Box_Support(Box_Unit_In_z);
      }
    }
  }
}

Box_Order_Out_x = Box_Unit_Out_x;//Space_Player_x;
Box_Order_Out_y = Space_Player_y - Box_Unit_Out_y - (Space * 2);
Box_Order_Out_z = (Token_Order_Dia / 2) + Wall;
module Box_OrderTokens()
{
  union()
  {
    difference()
    {
      cube([Box_Order_Out_x, Box_Order_Out_y, Box_Order_Out_z]);
      union()
      {
        for(i = [0 : 1 : (Token_Order_Type * Token_Order_Num) - 1])
        {
          translate([Wall + (i * (Wall + ((Box_Order_Out_x - ((1 + (Token_Order_Type * Token_Order_Num)) * Wall)) / 15))), (Wall + (Token_Order_Dia / 2)) + ((i % 2) * (Box_Order_Out_y - Token_Order_Dia - (2*Wall))), Wall + (Token_Order_Dia / 2)])
          {
            rotate([0, 90, 0])
            {
              cylinder(d = Token_Order_Dia, h = (Box_Order_Out_x - ((1 + (Token_Order_Type * Token_Order_Num)) * Wall)) / 15, $fn = 40);
            } 
          }
        }
      }
    }
    translate([0, 0, Box_Order_Out_z])
    {
      Box_Support(Token_Order_Dia / 2);
    }
    translate([Box_Order_Out_x, 0, Box_Order_Out_z])
    {
      rotate([0, 0, 90])
      {
        Box_Support(Token_Order_Dia / 2);
      }
    }
    translate([0, Box_Order_Out_y, Box_Order_Out_z])
    {
      rotate([0, 0, -90])
      {
        Box_Support(Token_Order_Dia / 2);
      }
    }
    translate([Box_Order_Out_x, Box_Order_Out_y, Box_Order_Out_z])
    {
      rotate([0, 0, 180])
      {
        Box_Support(Token_Order_Dia / 2);
      }
    }
  }
}
Box_Person_Out_x = Box_Unit_Out_x;
Box_Person_Out_y = Space_Player_y - Wall;
Box_Person_Out_z = Wall + (Card_Person_Num * Card_Person_h) + Space +2;
module Box_PersonCard()
{
  union()
  {
    difference()
    {
      cube([Box_Person_Out_x, Box_Person_Out_y, Box_Person_Out_z]);
      union()
      {
        translate([Wall, Wall, Wall])
        {
          cube([Box_Person_Out_x - (2*Wall), Box_Person_Out_y - (2*Wall), Box_Person_Out_z - Wall]);
        }
        translate([(Box_Person_Out_x - (Card_Person_y - 10)) / 2, (Box_Person_Out_y - (Card_Person_x - 20)) / 2, 0])
        {
          cube([(Card_Person_y - 10), (Card_Person_x - 20), Wall]);
        }
      }
    }
    translate([Wall, Wall, (Card_Person_Num * Card_Person_h) + Space + 2])
    {
      linear_extrude(height = Wall)
      {
      polygon(points = [[0, 0],[Box_Unit_Support - Wall, 0], [0, Box_Unit_Support - Wall]], paths = [[0,1,2]]);
      }
    }
    translate([Box_Person_Out_x - Wall, Wall, (Card_Person_Num * Card_Person_h) + Space + 2])
    {
      rotate([0, 0, 90])
      {
        linear_extrude(height = Wall)
        {
        polygon(points = [[0, 0],[Box_Unit_Support - Wall, 0], [0, Box_Unit_Support - Wall]], paths = [[0,1,2]]);
        }
      }
    }
    translate([Wall, Box_Person_Out_y - Wall, (Card_Person_Num * Card_Person_h) + Space + 2])
    {
      rotate([0, 0, -90])
      {
        linear_extrude(height = Wall)
        {
        polygon(points = [[0, 0],[Box_Unit_Support - Wall, 0], [0, Box_Unit_Support - Wall]], paths = [[0,1,2]]);
        }
      }
    }
    translate([Box_Person_Out_x - Wall, Box_Person_Out_y - Wall, (Card_Person_Num * Card_Person_h) + Space + 2])
    {
      rotate([0, 0, 180])
      {
        linear_extrude(height = Wall)
        {
        polygon(points = [[0, 0],[Box_Unit_Support - Wall, 0], [0, Box_Unit_Support - Wall]], paths = [[0,1,2]]);
        }
      }
    }
  }
}
Box_Might_Out_x = Box_Unit_Out_x;
Box_Might_Out_y = Box_Unit_Out_y;
Box_Might_Out_z = Space_Player_z - (Box_Person_Out_z + (2*Space) + (2*Box_Unit_Out_z))+3;
Box_Might_In_x = Box_Unit_Out_x - (2*Wall);
Box_Might_In_y = Box_Might_Out_y - (2*Wall);
Box_Might_In_z = Box_Might_Out_z - Wall;
module Box_Might()
{
  union()
  {
    difference()
    {
      cube([Box_Might_Out_x, Box_Might_Out_y, Box_Might_Out_z]);
      translate([Wall, Wall, Wall])
      {
        cube([Box_Might_In_x, Box_Might_In_y, Box_Might_In_z]);
      }
    }
    Box_Support(Box_Might_In_z);
    translate([Box_Might_Out_x, 0, 0])
    {
      rotate([0, 0, 90])
      {
        Box_Support(Box_Might_In_z);
      }
    }
    translate([0, Box_Might_Out_y, 0])
    {
      rotate([0, 0, -90])
      {
        Box_Support(Box_Might_In_z);
      }
    }
    translate([Box_Might_Out_x, Box_Might_Out_y, 0])
    {
      rotate([0, 0, 180])
      {
        Box_Support(Box_Might_In_z);
      }
    }
  }
}
Box_Other_Out_x = Box_Unit_Out_x;
Box_Other_Out_y = Box_Order_Out_y;
Box_Other_Out_z = Space_Player_z - (Box_Person_Out_z + (2*Space) + (2*Box_Order_Out_z))+3;
Box_Other_In_x = Box_Other_Out_x - (2*Wall);
Box_Other_In_y = Box_Other_Out_y - (2*Wall);
Box_Other_In_z = Box_Other_Out_z - Wall;
module Box_Other()
{
  union()
  {
    difference()
    {
      cube([Box_Other_Out_x, Box_Other_Out_y, Box_Other_Out_z]);
      translate([Wall, Wall, Wall])
      {
        cube([Box_Other_In_x, Box_Other_In_y, Box_Other_In_z]);
      }
    }
    Box_Support(Box_Other_In_z);
    translate([Box_Other_Out_x, 0, 0])
    {
      rotate([0, 0, 90])
      {
        Box_Support(Box_Other_In_z);
      }
    }
    translate([0, Box_Other_Out_y, 0])
    {
      rotate([0, 0, -90])
      {
        Box_Support(Box_Other_In_z);
      }
    }
    translate([Box_Other_Out_x, Box_Other_Out_y, 0])
    {
      rotate([0, 0, 180])
      {
        Box_Support(Box_Other_In_z);
      }
    }
  }
}


Show_CompletePlayer = true;
Show_Person = false;
Show_Unit = false;
Show_Order = false;
Show_Might = false;
Show_Other = false;

Show_Common = false;

if(Show_CompletePlayer)
{
  translate([0, 0, Box_Person_Out_z + Space])
  {
    Box_Unit();
  }
  translate([0, Box_Unit_In_y + (2 * Wall) + Space, Box_Person_Out_z + Space])
  {
    Box_OrderTokens();
  }
  translate([0, 0, 0])
  {
    Box_PersonCard();
  }
  translate([0, 0, (Box_Person_Out_z + (2*Space) + (2*Box_Unit_Out_z))])
  {
    Box_Might();
  }
  translate([0, Box_Unit_In_y + (2 * Wall) + Space, (Box_Person_Out_z + (2*Space) + (2*Box_Order_Out_z))])
  {
    Box_Other();
  }
}
else if(Show_Person)
{
  Box_PersonCard();
}
else if(Show_Unit)
{
  Box_Unit();
}
else if(Show_Order)
{
  Box_OrderTokens();
}
else if(Show_Might)
{
  Box_Might();
}
else if(Show_Other)
{
  Box_Other();
}
else if(Show_Common)
{
  CardAngle = asin((Space_Common_z - Wall)/(Card_Person_y + Space));
  echo(((Space_Common_x - (7*Wall) - Token_Town_y - (cos(CardAngle)*(Space_Common_z - Wall))) / 5));
  difference()
  {
    cube([Space_Common_x, Space_Common_y, Space_Common_z]);
    union()
    {
      for(i = [1:1:5])
      {
        translate([(Wall * i)+((i-1)*((Space_Common_x - (7*Wall) - Token_Town_y - (cos(CardAngle)*(Space_Common_z - Wall))) / 5)), Space_Common_y - (2*Wall) + Wall, Wall + 0.001])
        {
          rotate([90,0,0])
          {
            linear_extrude(height = Space_Common_y - (2*Wall))
            {
              polygon(points = [[0,0],[(Space_Common_x - (7*Wall) - Token_Town_y - (cos(CardAngle)*(Space_Common_z - Wall))) / 5, 0],[((Space_Common_x - (7*Wall) - Token_Town_y - (cos(CardAngle)*(Space_Common_z - Wall))) / 5)+(cos(CardAngle)*(Space_Common_z - Wall)), (Space_Common_z - Wall)],[(cos(CardAngle)*(Space_Common_z - Wall)), (Space_Common_z - Wall)]], path=[0,1,2,3]);
            }
          }
        }
      }
      
      translate([Space_Common_x - Token_Town_y - Wall, Wall + 10, Space_Common_z - Token_Town_x])
      {
        cube([Token_Town_y, (Token_Town_h * Token_Town_Num) + Space, Token_Town_x]);
      }
      
      translate([Space_Common_x - Token_Town_y - Wall + ((Token_Town_y - Token_Wild_h) / 2), Wall + ((Token_Town_h * Token_Town_Num) + Space) + 20, Space_Common_z - (Token_Town_x / 2) - (Token_Wild_y / 2)])
      {
        cube([Token_Wild_h, Token_Wild_x, Token_Wild_y]);
      }
      
      translate([Space_Common_x - Token_Town_y - Wall + ((Token_Town_y - Token_Turn_h) / 2), Space_Common_y - Wall - Token_Turn_y, Space_Common_z - (Token_Town_x / 2) - (Token_Turn_x / 2)])
      {
        cube([Token_Turn_h, Token_Turn_y, Token_Turn_x]);
      }
      
      translate([Space_Common_x - Token_Town_y - Wall, Wall, Space_Common_z - (Token_Town_x / 2)])
      {
        cube([Token_Town_y, Space_Common_y - (2*Wall), Token_Town_x / 2]);
      }
    }
  }
}