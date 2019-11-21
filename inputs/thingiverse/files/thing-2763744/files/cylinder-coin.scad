// mathgrrl cylinder coins
// for Matt Parker and Katie Steckles

/////////////////////////////////////////////////////////////////////////////
// PARAMETERS

// resolution 
$fn = 100*1;

// diameter of the coin
d = 20;
r = d/2;

// select from popular thickness-to-diameter ratios
ratio = 2.82843; // [2.82843:1 to 2*sqrt(2), 2.7182818:1 to e, 2.3333333:1 to 7/3, 2:1 to 2, 1.7320508:1 to sqrt(3), 0:Enter Custom Ratio Below]

// only use if "custom" selected above; enter 1 to ?? ratio
custom = 0;

// set rainal ratio to be custom if ratio=0, and ratio otherwise
final = (ratio == 0) ? custom : ratio;

// thickness based on ratio
thickness = d/final;

/////////////////////////////////////////////////////////////////////////////
// RENDERS

cylinder(thickness,r,r);