/* [Wellblech-Eigenschaften / properties of corrugated sheet] */
// distance from top to top (or valley to valley)
distance = 78;
// height of profile
height = 26;
// depth of distance piece
depth = 20;
// residual_width of distance piece
width = 25;
// bore diameter
diameter_bore = 8.5;

$fn=100;

rotate([90,0,0])
difference() {
translate([0,height/2,-depth/2])
linear_extrude(height = depth)
  polygon(draw_cosinus(distance,height,$fn));

// subtract unnecessary parts of the profile
translate([width/2,-height/2,-depth])
  cube([distance*2,height*2,depth*2]);

// subtract unnecessary parts of the profile    
translate([-2*distance-width/2,-height/2,-depth])
  cube([distance*2,height*2,depth*2]);

// subtract the bore
translate([0,-height/2,0])
rotate([-90,0,0])
cylinder(r=diameter_bore/2,height*2);    
}


function draw_cosinus(width, height, steps) = 
  [for (i=[-steps/2:steps/2], a=i*360/steps) [i/steps*80,height/2 *cos(a)] ];