//spool holder for bearings

//diameter of spool center hole in mm
spool_bore=35;

//outer diameter of bearing in mm(22mm for skate bearings)
bearing_diameter=22;

//center bore of bearing in mm (8mm for skate bearings/m8)
bearing_bore=8;

//depth of bearing (width) in mm
bearing_depth=7;

//width of flange holding bearing in place
bearing_rim=3;


spool_rad=spool_bore/2;
clearance_rad=(bearing_diameter-(2*bearing_rim))/2;
bearing_rad=(bearing_diameter/2)+0.2;
difference (){
  cylinder (bearing_depth*1.5,spool_rad-2,spool_rad+1,$fn=60);
  cylinder (bearing_depth*4,clearance_rad,clearance_rad, center=true,$fn=60);
  translate ([0,0,bearing_depth*0.5]) cylinder (bearing_depth+1,bearing_rad,bearing_rad, $fn=60);
}