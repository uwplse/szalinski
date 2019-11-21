// 
// Customizable Phone Stand
// version 1.0   11/21/2015
// by Steve Van Ausdall (DaoZenCiaoYen @ Thingiverse)
//

// preview[view:west, tilt:top diagonal]

/* [Main] */
// in inches
stand_height = 3.5 ; // [2:0.1:5]
// in inches
stand_width = 2.8 ; // [2:0.1:5]
// in inches
stand_depth = 2.8 ; // [2:0.1:5]
// in inches
phone_depth = 0.5 ; // [0.3:0.1:1]
// in inches
phone_lip = 0.2 ; // [0:0.1:0.5]
// in degrees
phone_angle = 27 ; // [10:35]
// in percent of stand depth
phone_adjust_depth_pct = 10 ; // [-20:1:10]
// in percent of stand height
phone_adjust_height_pct = -10 ; // [-20:1:10]
// the hole for the charger connetor in inches
charger_width = 0.5 ; // [0:0.1:1.5]
// the width of the charger cord in inches
cord_width = 0.15 ; // [0:0.05:1.5]
// in percent of possible height
slot_taper_pct = 30 ; // [0:5:100]
// in inches
wall_thickness = 0.15 ; // [0.1:0.05:0.5]

/* [Hidden] */
mm_in = 25.4 ;
thick = mm(wall_thickness) ;
phone_y = (stand_height/2) + (phone_adjust_height_pct*stand_height/100) ;
phone_x = (stand_depth/2) + (phone_adjust_depth_pct*stand_depth/100) ;
slot_taper = (stand_height - phone_y) * slot_taper_pct/100 ;
ff = 0.01 ;
bf = 1 ;
$fn=16 ;

function mm(in) = in * mm_in ;

main();

module main()
{
  render(convexity = 3) 
    rotate_z(2)
    difference()
    {
      stand();
      cord_slot();
      charger_slot();
    }
}

module rotate_z(yn)
{
  if (yn == 0) 
  {
    children(0);
  }
  else if (yn == 1)
  {
    rotate([0,0,180])
      translate([mm(-stand_depth/2),mm(-stand_height/2)-thick/2,mm(stand_width/2)])
      children(0);
  }
  else 
  {
    rotate([0,0,-90])
      translate([mm(-stand_depth/2),0,thick/2])
      rotate([90,0,0])
      children(0) ;
  }
}

module cord_slot()
{
  translate([-thick,thick*1.5+ff,mm(-cord_width/2)])
    linear_extrude(height=mm(cord_width)) 
    offset(thick) 
    cord_slot_shape();
}

module charger_slot()
{
  translate([mm(phone_x)-thick/2,mm(phone_y)-thick,0])
    rotate([0,0,phone_angle])
    rotate([0,90,0])
    linear_extrude(height=mm(phone_depth)+thick+ff)
    polygon(points=[
      [0,mm(slot_taper)+thick*2],
      [mm(charger_width/2),thick*2],[mm(charger_width/2),0],
      [-mm(charger_width/2),0],[-mm(charger_width/2),thick*2]
    ]);
}

module stand()
{
  translate([0,0,mm(-stand_width/2)])
    linear_extrude(height=mm(stand_width)) 
    stand_outline();
}

module stand_outline()
{
  difference()
  {
    offset(r=thick/2) stand_shape();
    offset(r=-thick/2) stand_shape();
  }
}

module cord_slot_shape()
{
  square([mm(phone_x)+thick/2,mm(stand_height)]);
}

module stand_shape()
{
  difference()
  {
    square([mm(stand_depth),mm(stand_height)]);
    translate([mm(phone_x),mm(phone_y)])
      rotate([0,0,phone_angle])
      translate([0,mm(-phone_y-bf)])
      difference()
      {
        square([mm(stand_depth+bf),mm(stand_height+bf*2)]);
        square([mm(phone_depth)+thick,mm(phone_y+bf)]);
        translate([mm(phone_depth)+thick,0])
          square([mm(phone_lip),mm(phone_y+bf+phone_lip)]);
      };
  }
}