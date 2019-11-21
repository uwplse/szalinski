/* [Global] */

// Is the charger round or square?
charger_type = "round"; // [round:Round - Urbane and G Watch R,square:Square - G Watch]
// How thick is the part that holds the charger?
charge_pad_thick = 5;
// How wide for square chargers
charge_pad_wide  = 39;
// How long for square chargers
charge_pad_long  = 48;
// Diameter for round chargers
charge_pad_d     = 50;
// Angle of charging pad
charge_pad_angle = 30;


// How thick are your magnets?
magnet_thick = 5.25;
// How wide/long are your magnets?
magnet_wide  = 5.25;

// How far apart are the magnet centers across the width?
magnet_sep_w = 10;  // 16 = G, 10 = Urbane
// How far apart are the magnet centers across the length?
magnet_sep_h = 25;  // 16 = G, 25 = Urbane

// Frame outer radius
frame_or = 75;
// Frame inner radius
frame_ir = 55;
// Frame thickness
frame_thick = 5;

// Height of frame
frame_h= 110;

// Offset of USB port from bottom of charger
usb_offset = 5;
// Radius of hole for USB plug
usb_r = 6;

/* [Hidden] */

// Arbitrarily large number.
huge = 500;

// Frame center radius
middle = ((frame_or - frame_ir) / 2) + frame_ir;

// Charge pad radius
charge_pad_r = charge_pad_d/2;


rotate([0,-90,0])
{
  translate([0,0,frame_h-middle]) rotate([charge_pad_angle,0,0]) translate([frame_thick,0, frame_ir]) top();
  difference()
  {
    frame();
    translate([0,0,frame_h-middle]) rotate([charge_pad_angle,0,0]) translate([-huge/2,0,frame_ir + charge_pad_thick + usb_offset]) rotate([0,90,0]) cylinder(r=usb_r,h=huge);
  }
}

//top("square");
//translate([0,0,30]) top("round");



module frame()
{
  difference()
  {
    union()
    {
      translate([0,0,frame_h - middle])
      {
        difference()
        {
          sphere(r=frame_or);
          sphere(r=frame_ir);
        }
      }
    }

    translate([-huge/2,0,0]) cube([huge,huge,huge],center=true);
    translate([0,0,-huge/2]) cube([huge,huge,huge],center=true);
    translate([frame_thick,-huge/2,frame_thick]) cube([huge,huge,huge]);

  }
}

module top(ct = charger_type)
{
  if(ct == "square")
  {
    translate([0,-charge_pad_long/2,0])
    difference()
    {
      cube([charge_pad_wide, charge_pad_long, charge_pad_thick]);
      
      for(x = [(charge_pad_wide-magnet_sep_w)/2, (charge_pad_wide-magnet_sep_w)/2 + magnet_sep_w])
      {
        for(y = [(charge_pad_long-magnet_sep_h)/2, (charge_pad_long-magnet_sep_h)/2 + magnet_sep_h])
        {
          #translate([x,y,charge_pad_thick - magnet_thick + (magnet_thick)/2]) cube([magnet_wide, magnet_wide, magnet_thick+1], center=true);
        }
      }
    }
  }
  else
  {
    translate([0,-charge_pad_r,0])
    difference()
    {
      union()
      {
        translate([charge_pad_r, charge_pad_r, 0]) cylinder(r=charge_pad_r,h=charge_pad_thick);
        cube([charge_pad_r, charge_pad_d, charge_pad_thick]);
      }

      for(x = [(charge_pad_d-magnet_sep_w)/2, (charge_pad_d-magnet_sep_w)/2 + magnet_sep_w])
      {
        for(y = [(charge_pad_d-magnet_sep_h)/2, (charge_pad_d-magnet_sep_h)/2 + magnet_sep_h])
        {
          #translate([x,y,charge_pad_thick - magnet_thick + (magnet_thick)/2]) cube([magnet_wide, magnet_wide, magnet_thick+1], center=true);
        }
      }
    }
  }
}

