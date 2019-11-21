// bearing dimentions
bearing_d = 22;
bearing_h = 7;

// max and min size of the spool holder diameter
max_d = 70;
min_d = 30;

// height of the holder
cone_h = 30;

// rod diameter
rod_d = 14;


// circle control
$fa = 1;
$fs = 1;


difference(){
// cone
	translate([0,0,cone_h/2])cylinder(r1 = max_d/2, r2 = min_d/2, h = cone_h, center=true);

// cutout for the bearing
	translate([0,0,bearing_h/2-.1]) cylinder(r=bearing_d/2, h=bearing_h, center=true);
  
// cutout for top bearing
  translate([0,0,cone_h-bearing_h/2]) cylinder(r=bearing_d/2, h=bearing_h, center=true);
	
// the center rod 
	translate([0,0,max_d/2+bearing_h+.1]) cylinder(r=rod_d/2, h=max_d, center=true);
	
// material saving cutout
   translate([max_d/1.9, 0,0]) cylinder(r=max_d/4, h=max_d, center=true);
    translate([-max_d/1.9, 0,0]) cylinder(r=max_d/4, h=max_d, center=true);
    translate([0,max_d/1.9, 0]) cylinder(r=max_d/4, h=max_d, center=true);
    translate([0,-max_d/1.9,0]) cylinder(r=max_d/4, h=max_d, center=true);	
  
}






