//hole cover

$fn=80;

//hole diameter
hole_diameter = 10;

//profile depth
depth = 5;

//tube wall
wall =1.5;

//profile_wall
material_wall=2;

//cover diameter
cover_diameter =15;

//cover height
cover_height = 1;



difference(){
    cylinder(d=hole_diameter,h=depth );
    cylinder(d=hole_diameter-wall,h=depth+1 );
    }


translate([0,0,-cover_height]){
    cylinder(d=cover_diameter,h=cover_height  );
}


rotate_extrude(convexity = 20)
    translate([hole_diameter/2-0.1, material_wall, 0])
circle(r = 0.2, $fn = 20);