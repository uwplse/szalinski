// Collar Diameter
collar_diameter = 250;

// Adapter Length
adapter_length = 110;
// Belt Width
belt_width = 70;
// Bolt diameter
bolt_diameter = 4;
// Bolt X distance
boltX = 45;
// Bolt Y distance
boltY = 45;
// Material Thickness
material_thickness = 3;
// GPS Screw Diameters
gps_screw_diameter = 3.4;
// GPS Screw Nut
gps_screw_nut = 7;

// constants
// GPS device
gpsX = 70;
gpsY = 50;
gpsZ = 15;

// GPS mount pattern
mountX = 38;
mountY = 60;
mountZ = 10;

//difference() {  union() {
color("red") translate([0,0,1.5]) SmartOne($fn=60);
!collar($fn=60);
//  } translate([-100,-100,-50]) cube([200,100,100]); }

module collar()
{
  bolt_angle = atan(boltX/(collar_diameter/2));
  difference() {
     hull() {
       // case
       rcube(gpsX+material_thickness*2,gpsY+material_thickness*2,mountZ,bolt_diameter+material_thickness);
       // belt mount
       translate([0,0,-mountZ]) rcube(adapter_length,belt_width,mountZ,bolt_diameter+material_thickness);
       // screws
       translate([-mountX/2,-mountY/2,0]) cylinder(d=gps_screw_diameter+material_thickness*2,h=mountZ);
       translate([-mountX/2,mountY/2,0]) cylinder(d=gps_screw_diameter+material_thickness*2,h=mountZ);
       translate([mountX/2,-mountY/2,0]) cylinder(d=gps_screw_diameter+material_thickness*2,h=mountZ);
       translate([mountX/2,mountY/2,0]) cylinder(d=gps_screw_diameter+material_thickness*2,h=mountZ);
     }
     // gps mount screws
     translate([-mountX/2,-mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,mountZ+2);
     translate([-mountX/2,mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,mountZ+2);
     translate([mountX/2,-mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,mountZ+2);
     translate([mountX/2,mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,mountZ+2);
     // gps device
//     translate([-mountX/2-20,-mountY/2+bolt_diameter/2+material_thickness,0]) cube([mountX+40,mountY-bolt_diameter-2*material_thickness,mountZ+1]);
     translate([0,0,1]) rcube(70,50,30,8); 
     translate([0,-15,mountZ-3]) cube([50,30,10]);
     // collar
     translate([0,0,-collar_diameter/2]) rotate([90,0,0]) cylinder(d=collar_diameter,h=belt_width+10*material_thickness,center=true);
     // collar bolt holes
     translate([0,-boltY/2,-collar_diameter/2]) rotate([0,-bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter);
     translate([0,boltY/2,-collar_diameter/2]) rotate([0,-bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter);
     translate([0,-boltY/2,-collar_diameter/2]) rotate([0,bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter);
     translate([0,boltY/2,-collar_diameter/2]) rotate([0,bolt_angle,0]) cylinder(d=bolt_diameter,h=collar_diameter);     
  }
}

module SmartOne()
{
  difference() {
    union() {
      translate([-19,0,9]) rcube(9,68,3,3);
      translate([19,0,9]) rcube(9,68,3,3);
    }
    // gps mount screws
    translate([-mountX/2,-mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,20);
    translate([-mountX/2,mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,20);
    translate([mountX/2,-mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,20);
    translate([mountX/2,mountY/2,0]) screwhole(gps_screw_diameter,gps_screw_nut,20);
  }
  hull() {
    translate([0,-15,0]) scale([3.4,1,1]) cylinder(d=20,h=21);
    translate([0,15,0]) scale([3.4,1,1]) cylinder(d=20,h=21);
  } 
}

module screwhole(d1,d2,hh)
{
  cylinder(d=d1,h=hh);
  translate([0,0,-4]) cylinder(d=d2,h=7,$fn=6);
}

module rcube(a,b,c,rr)
{
  linear_extrude(height=c) hull() {
    translate([-a/2+rr,-b/2+rr,0]) circle(r=rr);
    translate([-a/2+rr,b/2-rr,0]) circle(r=rr);
    translate([a/2-rr,-b/2+rr,0]) circle(r=rr);
    translate([a/2-rr,b/2-rr,0]) circle(r=rr);    
  }
  
}