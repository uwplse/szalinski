// card holder by ribaldos@thingiverse
// 25.11.2017

// USER PARAMETERS

// diameter
d = 17;

// total height
h = 3.8;

// width of slit holding cards or sheets
w_slit = 0.3;  

// depth of slit
z_slit = 3;

// length of card clamping of slit
l_clamp = 6;        

// height of cylindric foot
h_foot = 2;     

// diameter of top (evolves cylindrically to the top)
d_top = 11;

// width of both slot openings
w_opening = 2.2;    

//d_foot = 17;    // diameter of foot (non-cylindric bottom part)


// INTERNAL

h_top = h - h_foot; // height of top
h_slit = h - z_slit; // starting height of slit from floor 

$fn = 200;

module opening()
{
  linear_extrude(40)
    polygon([[0, l_clamp/2], [w_opening/2, d/2], [-w_opening/2, d/2]]);
}

difference()
{
  union()
  {
    cylinder(h_foot, d=d, false);
    translate([0, 0, h_foot]) cylinder(h_top, d1=d, d2=d_top, false);
  }
  
  translate([-w_slit/2, -d/2, h_slit]) cube([w_slit, d, 40], false);

  translate([0, 0, h_slit]) opening();
  mirror([0, -1, 0]) translate([0, 0, h_slit]) opening();

}
