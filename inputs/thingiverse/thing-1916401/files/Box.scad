//All dimensions are in mm

Wall = 1.2;
Space = 2;

Card_x = 87 + Space;
Card_y = 57 + Space;
Card_z = 0.3;

Card_Fistful = 15;
Card_Fistful_z = (Card_Fistful * Card_z) + Space;
Card_WildWest = 10;
Card_WildWest_z = (Card_WildWest * Card_z) + Space;
Card_HighNoon = 15;
Card_HighNoon_z = (Card_HighNoon * Card_z) + Space;
Card_GoldRush = 24;
Card_GoldRush_z = (Card_GoldRush * Card_z) + Space;

Card_Role = 15;
Card_Role_z = (Card_Role * Card_z) + Space;
Card_Persons = 54;
Card_Persons_z = (Card_Persons * Card_z) + (2 * Space);

Card_Advice = 8;
Card_Advice_z = (Card_Advice * Card_z) + Space;

Card_Other = 135;
Card_Other_z = (Card_Other * Card_z) + (3 * Space);

Gold_x = Card_x;
Gold_y = Card_y;
Gold_z = 24;

Slots = 9;

Magnet_dia = 9.5 + 0.2;
Magnet_h = 3.3 + 0.2;

Hinge_Holes = 24;
Hinge_HoleAxis = 8.8;
Hinge_HolesDia = 2.7;

Show_DownBlock = true;
Show_UpBlockLeft = false;
Show_UpBlockRight = false;

module Block_Down()
{
  difference()
  {
    cube([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, (2 * Wall) + Card_x, (2 * Wall) + Card_y]);
    union()
    {
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) - (Hinge_Holes / 2), 0, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) + (Hinge_Holes / 2), 0, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) - (Hinge_Holes / 2), Wall + Card_x, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) + (Hinge_Holes / 2), Wall + Card_x, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([(1 * Wall), Wall, Wall])
      {
        cube([Card_Fistful_z, Card_x, Card_y]);
      }
      translate([(2 * Wall) + Card_Fistful_z, Wall, Wall])
      {
        cube([Card_WildWest_z, Card_x, Card_y]);
      }
      translate([(3 * Wall) + Card_Fistful_z + Card_WildWest_z, Wall, Wall])
      {
        cube([Card_HighNoon_z, Card_x, Card_y]);
      }
      translate([(4 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z, Wall, Wall])
      {
        cube([Card_GoldRush_z, Card_x, Card_y]);
      }
      translate([(5 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z, Wall, Wall])
      {
        cube([Card_Role_z, Card_x, Card_y]);
      }
      translate([(6 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z, Wall, Wall])
      {
        cube([Card_Persons_z, Card_x, Card_y]);
      }
      translate([(7 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z, Wall, Wall])
      {
        cube([Card_Advice_z, Card_x, Card_y]);
      }
      translate([(8 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z, Wall, Wall])
      {
        cube([Card_Other_z, Card_x, Card_y]);
      }
      translate([(9 * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z, Wall, Wall])
      {
        cube([Gold_z, Card_x, Card_y]);
      }
    }
  }
}

module Block_Up()
{
  difference()
  {
    cube([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, (2 * Wall) + Card_x, (2 * Wall) + Card_y]);
    union()
    {
      translate([(Wall), Wall, Wall])
      {
        cube([((Slots - 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, Card_x, Card_y]);
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) - (Hinge_Holes / 2), 0, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) + (Hinge_Holes / 2), 0, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) - (Hinge_Holes / 2), Wall + Card_x, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
      translate([((((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z) / 2) + (Hinge_Holes / 2), Wall + Card_x, (((2 * Wall) + Card_y) / 2) - Hinge_HoleAxis])
      {
        rotate([-90, 0, 0])
        {
          cylinder(d = Hinge_HolesDia, h = Wall, $fn = 40);
        }
      }
    }
  }
}
module MagnetSlot()
{
    difference()
    {
      cube([Magnet_dia + Wall, Magnet_h + Wall, Magnet_dia + Wall]);
      union()
      {
        translate([Magnet_dia / 2, Wall, Magnet_dia / 2])
        {
          rotate([-90, 0, 0])
          {
            cylinder(d = Magnet_dia, h = Magnet_h, $fn = 40);
          }
        }
      }
      translate([Magnet_dia / 2, -0.0001, Magnet_dia / 2])
      {
        rotate([-90, -90, 0])
        {
          intersection()
          {
            difference()
            {
              cylinder(d = Magnet_dia + 7*Wall, h = Magnet_h + Wall+1, $fn = 40);
              cylinder(d = Magnet_dia + 2*Wall, h = Magnet_h + Wall+1, $fn = 40);
            }
            translate([0, 0, 0])
            {
              cube([Magnet_dia + 5*Wall, Magnet_dia + 3*Wall, Magnet_h + Wall+1]);
            }
          }
        }
      }
    }
  
}
if(Show_DownBlock)
{
  difference()
  {
    Block_Down();
    translate([0, 0, ((2 * Wall) + Card_y) / 2])
    {
      cube([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, (2 * Wall) + Card_x, ((2 * Wall) + Card_y) / 2]);
    }
  }
}
if(Show_UpBlockLeft)
{
  union()
  {
    translate([Wall, (((2 * Wall) + Card_x) / 2) - (Magnet_h + Wall), Wall])
    {
      MagnetSlot();
    }
    intersection()
    {
      Block_Up();

      cube([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, ((2 * Wall) + Card_x) / 2, ((2 * Wall) + Card_y) / 2]);
    }
  }
}
if(Show_UpBlockRight)
{
  union()
  {
    translate([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z - (Wall), (((2 * Wall) + Card_x) / 2) - (Magnet_h + Wall), Wall])
    {
      rotate([0, -90, 0])
      {
        MagnetSlot();
      }
    }
    intersection()
    {
      Block_Up();

      cube([((Slots + 1) * Wall) + Card_Fistful_z + Card_WildWest_z + Card_HighNoon_z + Card_GoldRush_z + Card_Role_z + Card_Persons_z + Card_Advice_z + Card_Other_z + Gold_z, ((2 * Wall) + Card_x) / 2, ((2 * Wall) + Card_y) / 2]);
    }
  }
}
