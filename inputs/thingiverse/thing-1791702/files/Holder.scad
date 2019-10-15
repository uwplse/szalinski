Space = 1;
Wall = 1.2;

Card_Size_x = 55 + Space;
Card_Size_y = 55 + Space;
Card_Size_z_B = 24 + Space;
Card_Size_z_W = 55 + Space;

Grip_Dia = 30;

Show_Base = true;
Show_Cover = false;

module Base()
{
  difference()
  {
    cube([(Card_Size_z_B + Card_Size_z_W + (3 * Wall)),
          (Card_Size_y + (2 * Wall)),   
          (Card_Size_x + Wall)]);
    union()
    {
      translate([Wall, Wall, Wall])
      {
        cube([Card_Size_z_B, Card_Size_y, Card_Size_x]);
      }
      translate([Card_Size_z_B + (2 * Wall), Wall, Wall])
      {
        cube([Card_Size_z_W, Card_Size_y, Card_Size_x]);
      }
      translate([0, (Card_Size_y + Wall) / 2, Card_Size_x + Wall])
      {
        rotate([0, 90, 0])
        {
          cylinder(d = Grip_Dia, h = (Card_Size_z_B + Card_Size_z_W + (3 * Wall)));
        }
      }
    }
  }
}
module Cover()
{
  difference()
  {
    cube([(Card_Size_z_B + Card_Size_z_W + (3 * Wall)) + Space + (2 * Wall),
          (Card_Size_y + (2 * Wall)) + Space + (2 * Wall),   
          (Card_Size_x + Wall)+ Space + Wall]);
    union()
    {
      translate([Wall, Wall, Wall])
      {
        cube([(Card_Size_z_B + Card_Size_z_W + (3 * Wall)) + Space,
          (Card_Size_y + (2 * Wall)) + Space,   
          (Card_Size_x + Wall)+ Space]);
      }
      translate([0, (Card_Size_y + Wall) / 2, Card_Size_x + Wall])
      {
        rotate([0, 90, 0])
        {
          cylinder(d = Grip_Dia, h = (Card_Size_z_B + Card_Size_z_W + (3 * Wall)) + Space + (2 * Wall));
        }
      }
      
      translate([0,0,510])
      {
        cube([1000,1000,1000], center = true);
      }
    }
    
  }
}

if(Show_Base)
{
  Base();
}
else if(Show_Cover)
{
  Cover();
}