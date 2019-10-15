// Customizable Simple Macro Lens Holder 
// preview[view:south, tilt:top];
/* [Parameters] */
lens_diameter = 7;

holder_height = 3.5;

rubber_band_hole_diameter = 2;



/* [Hidden] */
rubber_holder_width = 8;


module base() {        
    union() {
        translate([0, rubber_holder_width/-2, 0]) 
        cube([lens_diameter+3+rubber_band_hole_diameter*3,rubber_holder_width, holder_height]);        
        translate([(lens_diameter+3+rubber_band_hole_diameter*3)/2, 0, 0])
        cylinder(h=holder_height, r=(lens_diameter+3)/2, $fn=36);
    }
}
module holder() {
    difference() {
        base();
        
        translate([(lens_diameter+3+rubber_band_hole_diameter*3)/2, 0, 0.2])
        cylinder(h=holder_height, r=(lens_diameter+0.2)/2, $fn=36);
        
        translate([(lens_diameter+3+rubber_band_hole_diameter*3)/2, 0, -0.2])
        cylinder(h=holder_height, r=(lens_diameter-0.1)/2, $fn=36);
    
        translate([rubber_band_hole_diameter, (rubber_holder_width+1)/2, holder_height-rubber_band_hole_diameter/2+0.01]) rotate(a=[90,0,0]) 
        cylinder(h=rubber_holder_width+1, d=rubber_band_hole_diameter, $fn=36);
        

        translate([lens_diameter+3+rubber_band_hole_diameter*2, (rubber_holder_width+1)/2, holder_height-rubber_band_hole_diameter/2+0.01]) rotate(a=[90,0,0]) 
        cylinder(h=rubber_holder_width+1, d=rubber_band_hole_diameter, $fn=36);
    }
}

holder();