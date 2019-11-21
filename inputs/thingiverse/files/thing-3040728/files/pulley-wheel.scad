//**************Constants********************
/* [Global] */

/* [Basic Settings] */
// Bearing Style
BEARING_STYLE = "Two"; // [Two,One,None]

// Bearing Type, you can ignore the charactes after the number (i.e. "zz" or "r2s") as they have no impact on the size (Can be ignored when Bearing Style is "None")
BEARING_TYPE = "B625"; // [BCustom,B608,B625]

/* [Pulley Dimensions] */
// ... of the whole pulley wheel (mm)
THICKNESS = 12.7;
// ... of the pulley wheel without holders (mm)
OUTER_DIAMETER = 17.5;
// Height of the walls on the edges (mm)
HOLDER_HEIGHT = 2.25;
// Thickness of one wall (mm)
HOLDER_THICKNESS = 1.6;


/* [Settings for no Bearing] */

// You may type 5 for M5, 4 for M4 and so on
SCREW_SIZE = 5;

/* [Fillets and Roundings] */

// Fillet for inserting Bearings
BEARING_INSERTION_FILLET = "yes"; // [yes,no]
//
ROUND_HOLDERS = "no"; // [yes,no]


/* [Custom Bearing Settings] */

// (mm)
BEARING_THICKNESS = 5;
// (mm)
BEARING_OUTER_DIAMETER = 16;
// (mm)
BEARING_INNER_DIAMETER = 5;
/* [Hidden] */

//****************Variables (in mm)******************
BEARING_HOLDER_HEIGHT = 1.34;
// Vectors for Bearings
// Inner Diameter|Outer Diameter|Thickness
V_CUSTOM = [BEARING_INNER_DIAMETER,BEARING_OUTER_DIAMETER,BEARING_THICKNESS];
V_608 = [8,22,7];
V_625 = [5,16,5];

//****************Geometry*******************



$fa=0.5; $fs=0.5;
if (BEARING_TYPE == "BCustom")
{
  Pulley(style = BEARING_STYLE, v_bearing = V_CUSTOM, thickness = THICKNESS, o_diam = OUTER_DIAMETER, h_height = HOLDER_HEIGHT, h_thickness = HOLDER_THICKNESS, s_size = SCREW_SIZE, b_h_height = BEARING_HOLDER_HEIGHT, b_in_fillet = BEARING_INSERTION_FILLET,r_holder = ROUND_HOLDERS);
}
else if (BEARING_TYPE == "B608")
{
  Pulley(style = BEARING_STYLE, v_bearing = V_608, thickness = THICKNESS, o_diam = OUTER_DIAMETER, h_height = HOLDER_HEIGHT, h_thickness = HOLDER_THICKNESS, s_size = SCREW_SIZE, b_h_height = BEARING_HOLDER_HEIGHT, b_in_fillet = BEARING_INSERTION_FILLET,r_holder = ROUND_HOLDERS);
}
else if (BEARING_TYPE == "B625")
{
  Pulley(style = BEARING_STYLE, v_bearing = V_625, thickness = THICKNESS, o_diam = OUTER_DIAMETER, h_height = HOLDER_HEIGHT, h_thickness = HOLDER_THICKNESS, s_size = SCREW_SIZE, b_h_height = BEARING_HOLDER_HEIGHT, b_in_fillet = BEARING_INSERTION_FILLET,r_holder = ROUND_HOLDERS);
}
//WallHole(side = "Right", shape="Roundy Rectangle", off = 0, size = 33);
//Hole(xoff = 0, yoff = 0, xsize = 25, ysize = 15, radius = 7.5);
//****************Modules********************

//Main Modules
module Pulley(style = "Two", v_bearing = V_625, thickness = THICKNESS, o_diam = OUTER_DIAMETER, h_height = HOLDER_HEIGHT, h_thickness = HOLDER_THICKNESS, s_size = SCREW_SIZE, b_h_height = BEARING_HOLDER_HEIGHT, b_in_fillet = BEARING_INSERTION_FILLET,r_holder = ROUND_HOLDERS)
{

    b_i_diam = v_bearing[0];
    b_o_diam = v_bearing[1];
    b_thickn = v_bearing[2];
    wall_thickn = o_diam/2-b_o_diam/2;
    two_b_h_thickn = thickness-2*b_thickn;
    fillet_radius = 0.4;
    //TODO: ERROR DETECTION
    rotate_extrude(convexity = 10) //$fn = 100)
    translate([o_diam/2, 0]) {
        difference() {
          union() {
          //Homeplate
          if (style == "Two" || style == "One")
          {
              translate([-wall_thickn, 0, 0])
              square([wall_thickn,thickness], false);
          }
          if (r_holder=="yes")
          {
            //Holder up
            translate([0, thickness-h_thickness])
            {
              translate([h_height-h_thickness/2, h_thickness/2])
              {
                circle(r=h_thickness/2);
              }
              square([h_height-h_thickness/2,h_thickness], false);
            }
            //Holder down
            translate([0, 0])
            {
              translate([h_height-h_thickness/2, h_thickness/2])
              {
                circle(r=h_thickness/2);
              }
              square([h_height-h_thickness/2,h_thickness], false);
            }
          }
          else
          {
            //Holder up
            translate([0, thickness-h_thickness])
            {
              square([h_height,h_thickness], false);
            }
            //Holder down
            translate([0, 0])
            {
              square([h_height,h_thickness], false);
            }
          }
          if (style == "Two")
          {
            translate([-b_h_height-wall_thickn, thickness/2 - two_b_h_thickn/2])
            {
              square(size=[b_h_height, two_b_h_thickn], center=false);
            }
          }
          if (style == "One" && thickness > b_thickn)
          {
            translate([-b_h_height-wall_thickn, 0])
            {
              square(size=[b_h_height, thickness/2-b_thickn/2], center=false);
            }
          }
          if (style == "None")
          {
            translate([-(o_diam/2-s_size/2), 0])
            {
              square(size=[(o_diam/2-s_size/2), thickness], center=false);
            }
          }
        }
        if(b_in_fillet == "yes")
        {
          if (style == "Two")
          {
            polygon(points=[
            [-wall_thickn,0],
            [-wall_thickn+fillet_radius,0],
            [-wall_thickn,fillet_radius],
            ]);
            polygon(points=[
            [-wall_thickn,thickness],
            [-wall_thickn+fillet_radius,thickness],
            [-wall_thickn,-fillet_radius+thickness],
            ]);
          }
          if (style == "One" && thickness > b_thickn)
          {
            polygon(points=[
            [-wall_thickn,thickness],
            [-wall_thickn+fillet_radius,thickness],
            [-wall_thickn,-fillet_radius+thickness],
            ]);
          }
          if (style == "None")
          {
            polygon(points=[
            [-(o_diam/2-s_size/2),thickness],
            [-(o_diam/2-s_size/2)+fillet_radius,thickness],
            [-(o_diam/2-s_size/2),-fillet_radius+thickness],
            ]);
            polygon(points=[
            [-(o_diam/2-s_size/2),0],
            [-(o_diam/2-s_size/2)+fillet_radius,0],
            [-(o_diam/2-s_size/2),fillet_radius],
            ]);
          }
        }
      }
    }


}
