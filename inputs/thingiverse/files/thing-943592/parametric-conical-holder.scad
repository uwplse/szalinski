//The part wall thickness
wall = 2;
//outer diameter of conical
tube_diameter = 29;
//diameter of bottom tip of conical
bottom_diameter = 7; 
//height of the tapered part of conical
taper_height = 16; 
//total height of holder
overall_height = 25; 
//desired diameter of base.  
base_diameter = 45;  


/*[Hidden]*/
$fn = 100;

difference() {
conical(bottom_diameter+2*wall,taper_height,tube_diameter+2*wall,overall_height);
conical(bottom_diameter,taper_height,tube_diameter,overall_height);
}
difference() {
conical(base_diameter,taper_height,tube_diameter+2*wall,overall_height);
conical(base_diameter-2*wall,taper_height,tube_diameter,overall_height);
}
module conical(bd,th,td,oah) {
  cylinder(h=th,d1=bd,d2=td,center=false);
  translate([0,0,th]) cylinder(h=oah,d=td);
}