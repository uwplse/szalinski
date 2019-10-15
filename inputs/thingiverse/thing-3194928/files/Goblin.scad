show_box = 0;
//else show lid

card_x = 73 + 1;
card_y = 42 + 1;
card_z = 2.2;

card_sum = 22;

box_wall = 1.5;
box_hold = box_wall * 2;
box_grip = 13;

lid_grip = 10;

module grip()
{
  linear_extrude(height = (card_z * card_sum) + box_hold)
  {
    polygon(points=[[0, 0],
                    [box_grip + box_wall, 0],
                    [box_grip + box_wall, box_wall],
                    [box_wall, box_wall],
                    [box_wall, box_wall + box_grip],
                    [0, box_wall + box_grip]]);       
  }
}

if(show_box)
{
  union()
  {
    cube([card_x + (2 * box_wall), card_y + (2 * box_wall), box_wall]);
    grip();
    translate([card_x + (2 * box_wall), 0, 0])
    {
      rotate([0, 0, 90])
      {
        grip();
      }
    }
    translate([card_x + (2 * box_wall), card_y + (2 * box_wall), 0])
    {
      rotate([0, 0, 180])
      {
        grip();
      }
    }
    translate([0, card_y + (2 * box_wall), 0])
    {
      rotate([0, 0, -90])
      {
        grip();
      }
    }
  }
}
else
{
  union()
  {
    cube([card_x + (2 * box_wall), card_y + (2 * box_wall), box_wall]);
    translate([box_wall, box_wall, box_wall])
    {
      cube([card_x, card_y, box_hold]);
    }
    
    translate([0, box_wall + box_grip, box_wall])
    {
      cube([box_wall, card_y - (2 * box_grip), lid_grip]);
    }
    translate([box_wall + card_x, box_wall + box_grip, box_wall])
    {
      cube([box_wall, card_y - (2 * box_grip), lid_grip]);
    }
    translate([box_wall + box_grip, 0, box_wall])
    {
      cube([card_x - (2 * box_grip), box_wall, lid_grip]);
    }
    translate([box_wall + box_grip, box_wall + card_y, box_wall])
    {
      cube([card_x - (2 * box_grip), box_wall, lid_grip]);
    }
  }
}