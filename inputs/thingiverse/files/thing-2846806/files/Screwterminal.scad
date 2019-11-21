//openscad customizer
// Pole distance 
Distance = 38; // [20:100]
// Roundness
Roundness = 6; // [0:8]
// PE
PE_HOLE = "yes"; // [yes,no]
// Hole
Hole = 8; // [6:10]
// Height
Hoehe = 18; // [6:30]

Dicke = Hole * 5 / 8;
Breite   = Hole+12;
ROF = 0.1;




difference(){
  BOX();
  translate([-Distance/2,0,-ROF/2])  BOHRUNG(d = Hole, h = Hoehe+ROF, s = Hole / 1.23);
  if (PE_HOLE == "yes")
  {translate([0,0,-ROF/2])  BOHRUNG(d = Hole, h = Hoehe+ROF, s = Hole / 1.23);}
  translate([Distance/2,0,-ROF/2])  BOHRUNG(d = Hole, h = Hoehe+ROF, s = Hole / 1.23);
  
  hull()
  {
     translate([-Distance/2,0,-ROF/2])  cylinder(Hoehe+ROF/2-Dicke,15/2,15/2, $fn = 40);
     translate([Distance/2,0,-ROF/2])  cylinder(Hoehe+ROF/2-Dicke,15/2,15/2, $fn = 40);
  }  
}

module BOX()
{
  linear_extrude(Hoehe) offset(r = Roundness, $fn = 40) {
      square([Distance+Breite-(2*Roundness),Breite-(2*Roundness)], center = true);
  } 
}  

module BOHRUNG(d=8, h = 20, s=6.5 )
{
  
  difference()
  {
    cylinder(h,d/2,d/2, $fn = 40);
    translate([-d/2,s/2,0]) cube([d,d/2,h]);
    translate([-d/2,-s/2,0]) mirror([0,1,0]) cube([d,d/2,h]);
  }
  
  
}