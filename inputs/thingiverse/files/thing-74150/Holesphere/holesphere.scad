// Radius of big sphere
sphere_radius = 10; // [2:100]

// Radius of the holes in the sphere
hole_radius = 5; // [1:100]

difference(){
 translate([sphere_radius,0,sphere_radius])
  sphere(sphere_radius);
 union(){
  translate([sphere_radius,0,0]) 
   cylinder(2*sphere_radius,hole_radius,hole_radius);
  translate([sphere_radius,sphere_radius,sphere_radius]) rotate([90,0,0]) 
   cylinder(2*sphere_radius,hole_radius,hole_radius);
  translate([0,0,sphere_radius]) rotate([0,90,0]) 
   cylinder(2*sphere_radius,hole_radius,hole_radius);
 }
}
