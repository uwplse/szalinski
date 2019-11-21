/* [Hidden] */
$fn = 128;


/* [Ball Bearing] */
//better add 0.5 mm to make it fit easily
bearing_diameter = 14.5;
bearing_height = 5;
bearing_holder_diameter = 10;

/* [Pulley] */
pulley_height = 7;
pulley_diameter = 16;
// "roundness" of the pulley
pulley_crown_radius = 10;


difference() {
    intersection() {
        cylinder(r = pulley_diameter/2, h = pulley_height, center=true);
        s = (pulley_diameter/2)/pulley_crown_radius;
        scale([s,s,1.0]) sphere(pulley_crown_radius);
    }
    
    // ball bearing
    translate([0,0,0.05]) {
        cylinder(h=bearing_height+0.1, r=bearing_diameter/2, center=true);
    }
    
    hole_thickness = (pulley_height-bearing_height)/2+0.04;
    
    // upper hole
    translate([0,0,bearing_height/2]) {
        cylinder(h=hole_thickness, r1=bearing_diameter/2-0.1, r2=bearing_diameter/2);
    }
    
    // lower hole
    translate([0,0,-pulley_height/2-0.02]) {
        cylinder(h=hole_thickness, r=bearing_holder_diameter/2);
    }
}