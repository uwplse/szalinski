// Fitting Cap
 
$fn = 50;
 
// Parameters
inner_radius = 30.75;
wall_thickness = 1.2;
outer_radius = inner_radius + wall_thickness;
height = 25;
 
difference() {
    // This piece will be created:
    cylinder(r=outer_radius, h=height, center=false);
 
    // Everything else listed will be taken away:
    translate([0,0,1.2])cylinder(r=inner_radius, h=height, center=false);
}


    
