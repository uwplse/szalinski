/*[ Main properties of trouser button ] */
// Measure the outer diameter of the button
outer_diameter_button=20;
// Measure the inner diameter of the button
inner_diameter_button=13;
// how thick is the button without the rim?
thickness_of_button_without_rim=3;
// how thick is the rim?
thickness_of_rim=4;

/*[ Secondary properties of trouser button ] */
// radius of edges on outer side of the button. 0 not possible. Take 0.001 or something like that if you want to have sharp edges
radius_at_rim_outer_diameter = 2;
// radius of edges on inner side of the button. 0 not possible. Take 0.001 or something like that if you want to have sharp edges
radius_at_rim_inner_diameter = 2;

/*[ Properties of the bores]*/
// Number of Bores in the Button
number_of_bores = 4;
// Diameter of bores
bore_diameter = 2;
// distance between bores (diagonally)
diagonal_distance_of_bores = 7;

// auxiliary variable for maximum radius at the outer diameter
max_radius_at_rim_outer_diameter = thickness_of_rim/2.0;
    echo(max_radius_at_rim_outer_diameter);

// auxiliary variable for the maximum radius at the inner diameter
max_radius_at_rim_inner_diameter_from_height = thickness_of_rim - thickness_of_button_without_rim;
max_radius_at_rim_inner_diameter_from_width = (outer_diameter_button-inner_diameter_button)/4.0;

// actual radius at the outer diameter (using the above constraints)
actual_outer_radius = min(radius_at_rim_outer_diameter,max_radius_at_rim_outer_diameter,max_radius_at_rim_inner_diameter_from_width);
// actual radius at the inner diameter (using the above constraints)
actual_inner_radius = min(radius_at_rim_inner_diameter,max_radius_at_rim_inner_diameter_from_height,max_radius_at_rim_inner_diameter_from_width);

if(radius_at_rim_outer_diameter > max_radius_at_rim_outer_diameter) {
    echo("Intended radius at rim outer diameter too big, defaulting to maximum possible radius");
}

if(radius_at_rim_inner_diameter > max(max_radius_at_rim_inner_diameter_from_height,max_radius_at_rim_inner_diameter_from_width) ) {
       echo("Intended radius at rim inner diameter too big, defaulting to maximum possible radius");    
    }

$fn=360; // produce high quality output

// Calculate the button based on input data

difference() {  // subtract the bores
union() {
rotate_extrude(convexity=1) {  // I do the rotary extrusion to allow for smooth radii of the button. Maybe there's a simpler way to do this but it works just fine
  //union() {
    // draw the lower radius for the outer diameter
    translate([outer_diameter_button/2.0-actual_outer_radius,-thickness_of_rim/2.0+actual_outer_radius,0]) {  
      circle(r=actual_outer_radius); }
    // draw the upper radius for the outer diameter
    translate([(outer_diameter_button/2.0-actual_outer_radius),thickness_of_rim/2.0-actual_outer_radius,0])    
      circle(r=actual_outer_radius);
    // draw a square which connects the upper and lower radius
    translate([(outer_diameter_button/2.0-2.0*actual_outer_radius),-(thickness_of_rim-(2.0*actual_outer_radius))/2.0,0])
    square([2.0*actual_outer_radius,thickness_of_rim-(2.0*actual_outer_radius)]);
    // draw the radius towards the inner diameter
    difference() {
    translate([(inner_diameter_button/2.0+actual_inner_radius),thickness_of_rim/2.0-actual_inner_radius,0])   
      circle(r=(actual_inner_radius));
    translate([0,-thickness_of_rim,0]) {
    square([outer_diameter_button, 1.5*thickness_of_rim-actual_inner_radius]); }
    }
    // draw the square which connects the inner and outer radius
    translate([inner_diameter_button/2.0+actual_inner_radius,0,0])
    square([(outer_diameter_button - inner_diameter_button)/2.0 - actual_outer_radius - actual_inner_radius,thickness_of_rim/2.0]);
    // draw the square which fills the gap from the base to where the inner radius starts
    translate([inner_diameter_button/2.0,-thickness_of_rim/2.0+actual_outer_radius,0])
    square([actual_inner_radius,thickness_of_rim-actual_inner_radius-actual_outer_radius]);
//  } 
 }
 translate([0,0,-thickness_of_rim/2.0]) 
 cylinder(r=(outer_diameter_button/2.0-actual_outer_radius),thickness_of_button_without_rim);
}

// generate the bores as an own group
union() {
for (a = [0 : number_of_bores - 1]) {
    rotate(a*360/number_of_bores) {
    translate([0, -diagonal_distance_of_bores/2.0, -thickness_of_rim/2.0-1]) 
        cylinder(r=bore_diameter/2.0, 2.0*thickness_of_rim);
    }
}
}
}

// Johann Schuster, October 2019, Version 0.2
// corrected an erroneously commented line for the square which connects base and starting point of inner radius