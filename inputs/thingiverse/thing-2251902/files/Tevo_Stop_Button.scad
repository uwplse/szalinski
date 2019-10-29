
$fn     = 50;

baseD   = 10;
baseH   = 2.6;

stemD    = 5.5;
stemH    = 4.6;



//Start
cylinder(d=stemD, h=stemH); //Button
translate([0,0,-baseH]) cylinder(d=baseD, h=baseH); //Base