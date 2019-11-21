/*
  RC plane wheel hanger inspired by MLworx
  
  (c) 2017 Janne Mäntyharju
*/

// Diameter of the tire
tire_diameter = 124;

// Tire rounding (radius)
tire_rounding = 20;

// Width of the tire
tire_width = 45;

// Mounting hole diameter
fixing_hole_d = 6;

// ignore variable values
$fn=30;
tire_radius = tire_diameter / 2;
hanger_height = tire_width * 0.7;



// EMBEDDED rcube.scad MODULE

// Rounded primitives for openscad
// (c) 2013 Wouter Robers 

// Syntax example for a rounded block
//translate([-15,0,10]) rcube([20,20,20],2);

// Syntax example for a rounded cylinder
//translate([15,0,10]) rcylinder(r1=15,r2=10,h=20,b=2);

module rcube(Size=[20,20,20],b=2)
{hull(){for(x=[-(Size[0]/2-b),(Size[0]/2-b)]){for(y=[-(Size[1]/2-b),(Size[1]/2-b)]){for(z=[-(Size[2]/2-b),(Size[2]/2-b)]){ translate([x,y,z]) sphere(b);}}}}}


module rcylinder(r1=10,r2=10,h=10,b=2)
{translate([0,0,-h/2]) hull(){rotate_extrude() translate([r1-b,b,0]) circle(r = b); rotate_extrude() translate([r2-b, h-b, 0]) circle(r = b);}}



difference() {
    union() {
      // Upper part        
      translate([tire_radius / 1.075 ,-tire_radius, (tire_width - hanger_height)/2]) cube([tire_radius * 0.3, tire_radius, hanger_height]);
      // Main body
      translate([tire_radius / -1.3,tire_radius / -1.3,(tire_width - hanger_height)/2]) cube([tire_radius*2, tire_radius*2, hanger_height]);
    }
    union() {
      // Tire
      translate([0,0,tire_width/2]) rcylinder(r1=tire_radius, r2=tire_radius, h=tire_width, b=tire_rounding);
      // Trim extras
      translate([tire_radius / -0.93 , -tire_radius, -hanger_height]) cube([tire_radius*2, tire_radius, hanger_height*3]);      
      // Fixing hole
      rotate([0,90,0]) translate([tire_width/-2,-tire_radius/1.75,(tire_width +10 )]) cylinder(r=fixing_hole_d/2, h=tire_radius);
      // lower left
      translate([tire_radius *1.25, tire_radius*0.5, -hanger_height ]) rotate(a=45) cube([tire_radius*2, tire_radius*2, hanger_height*3]);
      // lower right
     translate([tire_radius *-1.15, tire_radius*0.5, -hanger_height ]) rotate(a=40) cube([tire_radius*2, tire_radius*2, hanger_height*3]);
    }
}
