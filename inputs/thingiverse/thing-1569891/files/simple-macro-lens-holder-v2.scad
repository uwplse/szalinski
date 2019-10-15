// Customizable Simple Macro Lens Holder 
//
// Default parameters are for the lens:
//      Size: 7 x 3.3 mm
//      BFL : 6.47 mm
//      ELF : 8.0 mm
//
//  2016.05.18 by gsyan
//
//  update : 2016.05.20
//

//preview[view:south west, tilt:top diagonal];

/* [LENS] */

//Default parameters are for the lens : Size: 7 x 3.3 mm , BFL : 6.47 mm , ELF : 8.0 mm
lens_diameter = 7.04;

lens_height = 3.3;

lens_total = 1;

//Lens distance adapt for lens_total > 1
lens_distance = 0;

lens_holder_wall_thickness = 1.6;

/* [Ruber_Band] */

rubber_band_hole_diameter = 2;

rubber_band_holder_width = 8;

/* [Hidden] */
fn = 36;


module base() {        
    union() {
        //base : cube
        translate([0, rubber_band_holder_width/-2, 0]) 
        cube([lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*3,rubber_band_holder_width, lens_height]);    //base : cylinder    
        translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*3)/2, 0, 0])
        cylinder(h=lens_height*lens_total+lens_distance*(lens_total-1), r=(lens_diameter+lens_holder_wall_thickness)/2, $fn=fn);
    }
}
module holder() {
    difference() {
        base();
        
        //lens hole
        translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*3)/2, 0, -0.1])
        cylinder(h=lens_height*lens_total+lens_distance*(lens_total-1)+1, r=(lens_diameter+0.2)/2, $fn=fn);
        
        /*
        translate([(lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*3)/2, 0, -0.2])
        cylinder(h=lens_height, r=(lens_diameter-0.1)/2, $fn=fn);
        */
        
        //left rubber band hole
        translate([rubber_band_hole_diameter, (rubber_band_holder_width+1)/2, lens_height-rubber_band_hole_diameter/2]) rotate(a=[90,0,0]) 
        cylinder(h=rubber_band_holder_width+1, d=rubber_band_hole_diameter, $fn=36);
        translate([rubber_band_hole_diameter, (rubber_band_holder_width+1)/-2, lens_height-rubber_band_hole_diameter/2+0.5]) cube([0.1, rubber_band_holder_width+1,1]);
                
        //right rubber band hole
        translate([lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*2, (rubber_band_holder_width+1)/2, lens_height-rubber_band_hole_diameter/2]) rotate(a=[90,0,0]) 
        cylinder(h=rubber_band_holder_width+1, d=rubber_band_hole_diameter, $fn=36);
        translate([lens_diameter+lens_holder_wall_thickness+rubber_band_hole_diameter*2, (rubber_band_holder_width+1)/-2, lens_height-rubber_band_hole_diameter/2+0.5]) cube([0.1, rubber_band_holder_width+1,1]);
    }
}

holder();
